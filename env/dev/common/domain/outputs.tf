output "host_zone_id" {
  value = module.domain.host_zone.id
}

output "cert_alb_arn" {
  value = module.domain.cert_alb.arn
}