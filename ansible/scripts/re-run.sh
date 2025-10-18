#!/bin/bash
set -e

PROJECT_ROOT="$(dirname "$0")/../.."
TERRAFORM_DIR="$PROJECT_ROOT/terraform"
ANSIBLE_DIR="$PROJECT_ROOT/ansible"
INVENTORY_FILE="$ANSIBLE_DIR/inventory.ini"

source "$PROJECT_ROOT/.env"

# Prompt for vault password once and store in variable
if [ -p /dev/stdin ]; then
  read -rs VAULT_PASS
  BECOME_PASS="$BECOME_PASSWORD"  # Set from env in CI
else
  echo -n "Vault password: "
  read -rs VAULT_PASS
  echo
  echo -n "BECOME password: "
  read -rs BECOME_PASS
  echo
fi

# Get SSH port and user from vault using the stored password
SSH_PORT=$(echo "$VAULT_PASS" | ansible-vault view "$ANSIBLE_DIR/vars/secrets.yml" --vault-password-file=/dev/stdin | grep "^ssh_port:" | awk '{print $2}')
USER=$(echo "$VAULT_PASS" | ansible-vault view "$ANSIBLE_DIR/vars/secrets.yml" --vault-password-file=/dev/stdin | grep "^user:" | awk '{print $2}')

# Generate inventory.ini
echo "[servers]" > "$INVENTORY_FILE"
tofu -chdir="$TERRAFORM_DIR" output -json homelab_droplet_ip \
  | jq -r --arg port "$SSH_PORT" '. + " ansible_port=" + $port' \
  >> "$INVENTORY_FILE"

echo "Generated inventory:" >&2
cat "$INVENTORY_FILE" >&2
echo >&2

# Run Ansible playbook using the generated inventory and stored password
ANSIBLE_HOST_KEY_CHECKING=False ansible-playbook \
    -i "$INVENTORY_FILE" \
    --private-key ~/.ssh/id_ed25519 \
    -u "$USER" \
    -e ssh_port="$SSH_PORT" \
    -e ansible_become_pass="$BECOME_PASS" \
    "$ANSIBLE_DIR/playbook.yml" \
    --vault-password-file=<(echo "$VAULT_PASS")
