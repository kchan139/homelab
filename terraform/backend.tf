terraform {
  backend "s3" {
    endpoint                    = var.cloudflare_endpoint
    region                      = "us-east-1"
    bucket                      = "homelab-tf-state"
    key                         = "homelab/terraform.tfstate"
    skip_credentials_validation = true
    skip_metadata_api_check     = true
    use_path_style              = true
  }
}
