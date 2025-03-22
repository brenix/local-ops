data "cloudflare_zone" "default" {
  filter = {
    account = {
      id = var.cloudflare_account_id
    }
    name = var.cloudflare_domain
  }
}
