##Route53 Host Zone
data "aws_route53_zone" "default" {
  name = var.host_zone_name
}

/*
resource "aws_route53_zone" "default" {
  name = var.host_zone_name
}
*/