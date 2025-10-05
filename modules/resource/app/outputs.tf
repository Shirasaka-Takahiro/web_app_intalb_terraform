output "alb" {
  value = aws_lb.alb
}

output "blue_tg" {
  value = aws_lb_target_group.blue_tg
}

output "green_tg" {
  value = aws_lb_target_group.green_tg
}

output "alb_https_listener" {
  value = aws_lb_listener.alb_https_listener
}

output "ecr" {
  value = aws_ecr_repository.default
}

output "ecr_app_web" {
  value = aws_ecr_repository.app-web
}

output "ecs_service" {
  value = aws_ecs_service.service
}

output "ecs_role" {
  value = aws_iam_role.ecs
}

output "security_group_internal" {
  value = aws_security_group.internal
}