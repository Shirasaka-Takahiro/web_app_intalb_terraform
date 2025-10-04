output "ecs_role_arn" {
  value = module.app.ecs_role.arn
}

output "ecr_repository_url" {
  value = module.app.ecr.repository_url
}

output "security_group_internal_id" {
  value = module.app.security_group_internal.id
}

output "ecs_service_name" {
  value = module.app.ecs_service.name
}

output "blue_tg_name" {
  value = module.app.blue_tg.name
}

output "green_tg_name" {
  value = module.app.green_tg.name
}

output "alb_https_listener_arn" {
  value = module.app.alb_https_listener.arn
}