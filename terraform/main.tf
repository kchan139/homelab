terraform {
  required_providers {
    digitalocean = {
      source  = "digitalocean/digitalocean"
      version = "~> 2.0"
    }
    cloudflare = {
      source  = "cloudflare/cloudflare"
      version = "~> 5"
    }
  }
}

provider "digitalocean" {
  token = var.do_token
}

provider "cloudflare" {
  api_token = var.cloudflare_api_token
}

resource "digitalocean_ssh_key" "server" {
  name       = "Khoa SSH key"
  public_key = file("~/.ssh/id_ed25519.pub")
}

resource "cloudflare_dns_record" "digitalocean_subdomain" {
  zone_id = var.cloudflare_zone_id
  name    = "digitalocean"
  type    = "A"
  content = digitalocean_loadbalancer.server.ip
  ttl     = 1
  proxied = true
}

resource "digitalocean_loadbalancer" "server" {
  name   = "load-balancer"
  region = "sgp1"

  forwarding_rule {
    entry_port     = 80
    entry_protocol = "http"
    target_port    = 80
    target_protocol = "http"
  }

  healthcheck {
    protocol = "http"
    port     = 80
    path     = "/"
  }

  droplet_ids = digitalocean_droplet.server.*.id
}

resource "digitalocean_droplet" "server" {
  count  = 1
  image  = "ubuntu-24-04-x64"
  name   = "kserver-${count.index + 1}"
  region = "sgp1"
  size   = "s-4vcpu-8gb-intel"
  ssh_keys = [
    digitalocean_ssh_key.server.id
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
  value = [for droplet in digitalocean_droplet.server : droplet.ipv4_address]
}

output "load_balancer_ip" {
  value = digitalocean_loadbalancer.server.ip
}
