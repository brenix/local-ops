data "cloudflare_zone" "default" {
  account_id = var.cloudflare_account_id
  name       = var.cloudflare_domain
}

resource "cloudflare_record" "overseerr" {
  zone_id = data.cloudflare_zone.default.id
  name    = "overseerr"
  value   = data.cloudflare_zone.default.name
  type    = "CNAME"
  proxied = false
}

resource "cloudflare_record" "jellyfin" {
  zone_id = data.cloudflare_zone.default.id
  name    = "jellyfin"
  value   = data.cloudflare_zone.default.name
  type    = "CNAME"
  proxied = false
}

resource "cloudflare_record" "jellyseerr" {
  zone_id = data.cloudflare_zone.default.id
  name    = "jellyseerr"
  value   = data.cloudflare_zone.default.name
  type    = "CNAME"
  proxied = false
}

resource "cloudflare_record" "plex" {
  zone_id = data.cloudflare_zone.default.id
  name    = "plex"
  value   = data.cloudflare_zone.default.name
  type    = "CNAME"
  proxied = false
}

resource "cloudflare_record" "www" {
  zone_id = data.cloudflare_zone.default.id
  name    = "www"
  value   = data.cloudflare_zone.default.name
  type    = "CNAME"
  proxied = false
}
