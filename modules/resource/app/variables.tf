variable "general_config" {
  type = map(any)
}
variable "vpc_id" {}
variable "public_subnet_ids" {}
variable "cert_alb_arn" {}
variable "ecs_cluster_id" {}
variable "fargate_cpu" {}
variable "fargate_memory" {}
variable "dmz_subnet_ids" {}
variable "desired_count" {}
variable "deployment_controller" {}
variable "zone_id" {}
variable "domain_name" {
  type = list(string)
}