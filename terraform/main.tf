terraform {
  required_providers {
    digitalocean = {
      source  = "digitalocean/digitalocean"
      version = "~> 2.0"
    }
  }
}

provider "digitalocean" {
}

resource "digitalocean_ssh_key" "web" {
  name       = "Khoa SSH key"
  public_key = file("~/.ssh/id_ed25519.pub")
}

# resource "digitalocean_domain" "domain" {
#   name = "khoa.email"
# }

# resource "digitalocean_record" "default" {
#   domain = digitalocean_domain.domain.name
#   type   = "A"
#   name   = "@"
#   value  = digitalocean_loadbalancer.web.ip
#   ttl    = 1800
# }

# resource "digitalocean_loadbalancer" "web" {
#   name   = "web-lb-1"
#   region = "sgp1"

#   forwarding_rule {
#     entry_port     = 80
#     entry_protocol = "http"

#     target_port     = 8000
#     target_protocol = "http"
#   }

#   healthcheck {
#     path     = "/"
#     port     = 8000
#     protocol = "http"
#   }

#   droplet_ids = digitalocean_droplet.web.*.id
# }

resource "digitalocean_droplet" "web" {
  count  = 1
  image  = "ubuntu-24-04-x64"
  name   = "kserver-${count.index + 1}"
  region = "sgp1"
  size   = "s-4vcpu-8gb-intel"
  ssh_keys = [
    digitalocean_ssh_key.web.id
  ]

  # provisioner "local-exec" {
  #   command = "sleep 30 && ../ansible/scripts/run.sh ${self.ipv4_address}"
  #   when    = create
  # }

  backups = false
  # backup_policy {
  #   plan    = "weekly"
  #   weekday = "TUE"
  #   hour    = 8
  # }
}

output "droplet_ips" {
  value = [for droplet in digitalocean_droplet.web : droplet.ipv4_address]
}

# output "load_balancer_ip" {
#   value = digitalocean_loadbalancer.web.ip
# }
