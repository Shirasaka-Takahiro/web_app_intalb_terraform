##Provider for ap-northeast-1
provider "aws" {
  profile    = "terraform-user"
  access_key = var.access_key
  secret_key = var.secret_key
  region     = "ap-northeast-1"
}

##Web CI/CD
module "cicd_web" {
  source = "../../../../modules/cicd/web"

  #CodeBuild
  general_config  = var.general_config
  region = var.region
  execution_role_arn = data.terraform_remote_state.resource_web.outputs.ecs_role_arn
  ecr_repository_url = data.terraform_remote_state.resource_web.outputs.ecr_repository_url
  buildspec_path = "web/scripts/buildspec.yml"
  vpc_id         = data.terraform_remote_state.common_network.outputs.vpc_id
  dmz_subnet_ids        = data.terraform_remote_state.common_network.outputs.dmz_subnet_ids
  internal_sg_id     = data.terraform_remote_state.resource_web.outputs.security_group_internal_id

  #CodeDeploy
  ecs_cluster_name   = data.terraform_remote_state.common_network.outputs.ecs_cluster_name
  ecs_service_name   = data.terraform_remote_state.resource_web.outputs.ecs_service_name
  blue_tg_name       = data.terraform_remote_state.resource_web.outputs.blue_tg_name
  green_tg_name      = data.terraform_remote_state.resource_web.outputs.green_tg_name
  alb_https_listener_arn = data.terraform_remote_state.resource_web.outputs.alb_https_listener_arn

  #CodePipeline
  pipeline_type = "V2"
  branch_name                        = var.branch_name
  full_repositroy_id                 = var.full_repositroy_id
  task_definition_template_path      = "./taskdef/taskdef.json"
  app_spec_template_path             = "./scripts/appspec.yml"
}