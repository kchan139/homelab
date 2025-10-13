# HOMELAB

Infrastructure-as-Code setup for a personal Fedora 42 server on DigitalOcean.

## Tools

- OpenTofu – infrastructure provisioning
- Ansible – configuration management
- Firewalld – basic network security

## Usage

1. Run Terraform (OpenTofu) to create the droplet:
   ```bash
   tofu -chdir=terraform apply
   ```

2. Run Ansible to configure it:

   ```bash
   ./ansible/scripts/run.sh
   ```
3. Copy `.env.example` to `.env` and fill in connection details.  
4. Use `login.sh` to SSH into the server with port forwarding:

   ```bash
   ./login.sh
   ```

## Layout

```
homelab
├── login.sh
├── .env.example
├── ansible
│   ├── playbook.yml
│   ├── inventory.ini
│   ├── files
│   │   └── motd
│   ├── scripts
│   │   ├── re-run.sh
│   │   └── run.sh
│   └── vars
│       └── example.secrets.yml
└── terraform
    ├── *.tf
    ├── terraform.tfvars
    └── scripts
        ├── list-images.sh
        └── list-sizes.sh
```
