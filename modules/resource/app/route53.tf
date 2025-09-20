resource "aws_route53_record" "default" {
  for_each = { for name in var.domain_name : name => name }
  zone_id  = var.zone_id
  name     = each.value
  type     = "A"
  alias {
    name                   = aws_lb.alb.dns_name
    zone_id                = aws_lb.alb.zone_id
    evaluate_target_health = true
  }
}