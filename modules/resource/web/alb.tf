##ALB
resource "aws_lb" "alb" {
  name               = "${var.general_config["project"]}-${var.general_config["env"]}-${var.general_config["service"]}-alb"
  internal           = false
  load_balancer_type = "application"
  security_groups = [
    aws_security_group.alb.id
  ]
  subnets         = var.public_subnet_ids
  ip_address_type = "ipv4"

  tags = {
    Name = "${var.general_config["project"]}-${var.general_config["env"]}-${var.general_config["service"]}-alb"
  }
}

##Target Group Blue
resource "aws_lb_target_group" "blue_tg" {
  name             = "${var.general_config["project"]}-${var.general_config["env"]}-${var.general_config["service"]}-blue-tg"
  target_type      = "ip"
  protocol_version = "HTTP1"
  port             = "80"
  protocol         = "HTTP"
  vpc_id           = var.vpc_id

  health_check {
    interval            = 30
    path                = "/healthchek.html"
    port                = "traffic-port"
    protocol            = "HTTP"
    timeout             = 5
    healthy_threshold   = 5
    unhealthy_threshold = 5
    matcher             = "200"
  }

  tags = {
    Name = "${var.general_config["project"]}-${var.general_config["env"]}-${var.general_config["service"]}-blue-tg"
  }
}

##Target Group Green
resource "aws_lb_target_group" "green_tg" {
  name             = "${var.general_config["project"]}-${var.general_config["env"]}-${var.general_config["service"]}-green-tg"
  target_type      = "ip"
  protocol_version = "HTTP1"
  port             = "80"
  protocol         = "HTTP"
  vpc_id           = var.vpc_id

  health_check {
    interval            = 30
    path                = "/healthchek.html"
    port                = "traffic-port"
    protocol            = "HTTP"
    timeout             = 5
    healthy_threshold   = 5
    unhealthy_threshold = 5
    matcher             = "200"
  }

  tags = {
    Name = "${var.general_config["project"]}-${var.general_config["env"]}-${var.general_config["service"]}-green-tg"
  }
}

##HTTPS Listener
resource "aws_lb_listener" "alb_https_listener" {
  load_balancer_arn = aws_lb.alb.arn
  port              = "443"
  protocol          = "HTTPS"
  ssl_policy        = "ELBSecurityPolicy-2016-08"
  certificate_arn   = var.cert_alb_arn

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.blue_tg.arn
  }
}

##Attach target group to the alb
#resource "aws_lb_target_group_attachment" "attach_tg_to_alb" {
#  count            = length(var.instance_ids)
#  target_id        = element(var.instance_ids, count.index % 2)
#  target_group_arn = aws_lb_target_group.blue_tg.arn
#  port             = 80
#}