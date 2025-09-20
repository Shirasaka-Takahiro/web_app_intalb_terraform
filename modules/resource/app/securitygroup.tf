##Internal Security Group
resource "aws_security_group" "internal" {
  name   = "${var.general_config["project"]}-${var.general_config["env"]}-${var.general_config["service"]}-internal-sg"
  vpc_id = var.vpc_id

  tags = {
    Name = "${var.general_config["project"]}-${var.general_config["env"]}-${var.general_config["service"]}-internal-sg"
  }

}

##Internal Security Group Rule Ingress
resource "aws_security_group_rule" "internal_ingress" {
  type              = "ingress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = ["10.0.0.0/16"]
  security_group_id = aws_security_group.internal.id
}

##Internal Security Group Rule Egress
resource "aws_security_group_rule" "internal_egress" {
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.internal.id
}

##ALB Security Group
resource "aws_security_group" "alb" {
  name   = "${var.general_config["project"]}-${var.general_config["env"]}-${var.general_config["service"]}-alb-sg"
  vpc_id = var.vpc_id

  tags = {
    Name = "${var.general_config["project"]}-${var.general_config["env"]}-${var.general_config["service"]}-alb-sg"
  }

}

##ALB HTTP Security Group Rule Ingress
resource "aws_security_group_rule" "alb_http_ingress" {
  type              = "ingress"
  from_port         = 80
  to_port           = 80
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.alb.id
}

##ALB HTTPS Security Group Rule Ingress
resource "aws_security_group_rule" "alb_https_ingress" {
  type              = "ingress"
  from_port         = 443
  to_port           = 443
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.alb.id
}

##ALB HTTPS Security Group Rule Egress
resource "aws_security_group_rule" "alb_egress" {
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.alb.id
}