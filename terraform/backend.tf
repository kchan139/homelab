terraform {
  backend "s3" {
    endpoint                    = "https://852864276e83709a3837663c1bb0679e.r2.cloudflarestorage.com"
    region                      = "us-east-1"
    bucket                      = "homelab-tf-state"
    key                         = "homelab/terraform.tfstate"
    skip_credentials_validation = true
    skip_metadata_api_check     = true
    use_path_style              = true
  }
}
