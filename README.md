# HOMELAB

Automated provisioning and configuration of a Fedora 42 cloud server using Infrastructure-as-Code principles.
The setup bootstraps a DigitalOcean droplet with hardened SSH access, firewall policies, user management, intrusion prevention, and remote Terraform state management.

## Tools

* **OpenTofu** – declarative infrastructure provisioning
* **Ansible** – post-provision configuration and system hardening
* **Firewalld** – network-level access control
* **CrowdSec** – behavioral intrusion detection and automated banning

## Usage

1. Copy `.env.example` to `.env` and fill in the details.

2. Run Terraform (OpenTofu) to create the droplet:

   ```bash
   source .env
   tofu -chdir=terraform apply
   ```

3. Run Ansible to configure it:

   ```bash
   ./ansible/scripts/run.sh
   ```

   > Note: ssh_port, user, password must be defined in ansible/vars/secrets.yml

4. Use `login.sh` to SSH into the server with port forwarding:

   ```bash
   ./login.sh
   ```

## Layout

```
homelab
├── login.sh
├── .env
├── ansible
│   ├── playbook.yml
│   ├── inventory.ini
│   ├── files
│   │   └── motd
│   ├── scripts
│   │   ├── re-run.sh
│   │   └── run.sh
│   └── vars
│       └── secrets.yml
└── terraform
    ├── *.tf
    ├── terraform.tfvars
    └── scripts
        ├── list-images.sh
        └── list-sizes.sh
```
