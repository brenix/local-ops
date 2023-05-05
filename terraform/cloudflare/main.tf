data "cloudflare_zone" "default" {
  account_id = var.cloudflare_account_id
  name       = var.cloudflare_domain
}
