terraform {
  required_version = ">= 1.3.0"
  cloud {
    hostname     = "app.terraform.io"
    organization = "brenix"

    workspaces {
      name = "home-cloudflare"
    }
  }

  required_providers {
    cloudflare = {
      source  = "cloudflare/cloudflare"
      version = "4.6.0"
    }
  }
}
