resource "digitalocean_ssh_key" "homelab" {
  name       = "Khoa SSH key"
  public_key = file("~/.ssh/id_ed25519.pub")
}

resource "digitalocean_droplet" "homelab" {
  image  = "fedora-42-x64"
  name   = "homelab"
  region = "sgp1"
  size   = "s-2vcpu-4gb"
  ssh_keys = [
    digitalocean_ssh_key.homelab.id
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
