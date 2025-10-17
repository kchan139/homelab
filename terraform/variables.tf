variable "do_token" {
  description = "DigitalOcean API token"
  type        = string
  sensitive   = true
}

variable "custom_ssh_port" {
  description = "Custom SSH Port"
  type        = number
}

variable "ssh_access_ips" {
  description = "List of CIDR blocks allowed to access SSH"
  type        = list(string)
  sensitive   = true
}

variable "cloudflare_endpoint" {
  description = "Cloudflare S3 Endpoint"
  type        = string
}
