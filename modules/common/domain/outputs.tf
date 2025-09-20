output "host_zone" {
  value = data.aws_route53_zone.default
}

output "cert_alb" {
  value = aws_acm_certificate.cert_alb
}