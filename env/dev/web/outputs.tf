output "ecs_role_arn" {
  value = module.web.ecs_role.arn
}

output "ecr_repository_url" {
  value = module.web.ecr.repository_url
}

output "security_group_internal_id" {
  value = module.web.security_group_internal.id
}

output "ecs_service_name" {
  value = module.web.ecs_service.name
}

output "blue_tg_name" {
  value = module.web.blue_tg.name
}

output "green_tg_name" {
  value = module.web.green_tg.name
}

output "alb_https_listener_arn" {
  value = module.web.alb_https_listener.arn
}