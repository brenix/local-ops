data "cloudflare_zone" "default" {
  name = var.cloudflare_domain
}

resource "cloudflare_record" "overseerr" {
  zone_id = data.cloudflare_zone.default.id
  name    = format("overseerr.%s", data.cloudflare_zone.default.name)
  value   = data.cloudflare_zone.default.name
  type    = "CNAME"
  proxied = false
}

resource "cloudflare_record" "plex" {
  zone_id = data.cloudflare_zone.default.id
  name    = format("plex.%s", data.cloudflare_zone.default.name)
  value   = data.cloudflare_zone.default.name
  type    = "CNAME"
  proxied = false
}

resource "cloudflare_record" "www" {
  zone_id = data.cloudflare_zone.default.id
  name    = format("www.%s", data.cloudflare_zone.default.name)
  value   = data.cloudflare_zone.default.name
  type    = "CNAME"
  proxied = false
}
