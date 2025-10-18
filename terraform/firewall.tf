resource "digitalocean_firewall" "homelab" {
  name = "homelab-firewall"

  droplet_ids = [digitalocean_droplet.homelab.id]

  ### SSH Access ###

  # Allow SSH access from trusted IPs on a custom port.
  # Intended for initial Ansible provisioning or emergency access.
  # Lock this port down or disable it entirely during normal operation.
  # inbound_rule {
  #   protocol         = "tcp"
  #   port_range       = "22"
  #   source_addresses = var.ssh_access_ips
  # }

  inbound_rule {
    protocol         = "tcp"
    port_range       = var.custom_ssh_port
    source_addresses = var.ssh_access_ips
  }

  ### ICMP for Ping ###
  inbound_rule {
    protocol         = "icmp"
    source_addresses = ["0.0.0.0/0", "::/0"]
  }

  ### Outbound Rules (Left open for now) ###
  outbound_rule {
    protocol              = "tcp"
    port_range            = "1-65535"
    destination_addresses = ["0.0.0.0/0", "::/0"]
  }

  outbound_rule {
    protocol              = "udp"
    port_range            = "1-65535"
    destination_addresses = ["0.0.0.0/0", "::/0"]
  }

  outbound_rule {
    protocol              = "icmp"
    destination_addresses = ["0.0.0.0/0", "::/0"]
  }
}
