# homelab

IaC for personal Fedora 42 homelab on DigitalOcean.

## Stack

- **OpenTofu**: Provision infrastructure
- **Ansible**: Configure and manage servers
- **Fedora 42**: Base OS
- **Firewalld**: Firewall management

## Structure

```
homelab
├── login.sh
├── ansible
│   ├── inventory.ini
│   ├── playbook.yml
│   ├── scripts
│   │   ├── re-run.sh
│   │   └── run.sh
│   └── vars
│       └── secrets.yml
└── terraform
    ├── firewall.tf
    ├── main.tf
    ├── outputs.tf
    ├── providers.tf
    ├── scripts
    │   ├── list-images.sh
    │   └── list-sizes.sh
    └── variables.tf
```
