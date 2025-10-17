# HOMELAB

Infrastructure-as-Code setup for a personal Fedora 42 server on DigitalOcean.

## Tools

- OpenTofu – infrastructure provisioning
- Ansible – configuration management
- Firewalld – basic network security

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
│   ├── playbook.yml
│   ├── inventory.ini
│   ├── files
│   │   └── motd
│   ├── scripts
│   │   ├── re-run.sh
│   │   └── run.sh
│   └── vars
│       └── secrets.yml
└── terraform
    ├── *.tf
    ├── terraform.tfvars
    └── scripts
        ├── list-images.sh
        └── list-sizes.sh
```
