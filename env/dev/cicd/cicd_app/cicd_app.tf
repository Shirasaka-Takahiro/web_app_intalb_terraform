##Provider for ap-northeast-1
provider "aws" {
  profile    = "terraform-user"
  access_key = var.access_key
  secret_key = var.secret_key
  region     = "ap-northeast-1"
}

##Web CI/CD
module "cicd_app" {
  source = "../../../../modules/cicd/app"

  #CodeBuild
  general_config     = var.general_config
  region             = var.region
  execution_role_arn = data.terraform_remote_state.resource_app.outputs.ecs_role_arn
  ecr_repository_url = data.terraform_remote_state.resource_app.outputs.ecr_repository_url
  ecr_repository_app_web_url = data.terraform_remote_state.resource_app.outputs.ecr_repository_app_web_url
  buildspec_path     = "scripts/buildspec.yml"
  vpc_id             = data.terraform_remote_state.common_network.outputs.vpc_id
  dmz_subnet_ids     = data.terraform_remote_state.common_network.outputs.dmz_subnet_ids
  internal_sg_id     = data.terraform_remote_state.resource_app.outputs.security_group_internal_id

  #CodeDeploy
  ecs_cluster_name       = data.terraform_remote_state.common_network.outputs.ecs_cluster_name
  ecs_service_name       = data.terraform_remote_state.resource_app.outputs.ecs_service_name
  blue_tg_name           = data.terraform_remote_state.resource_app.outputs.blue_tg_name
  green_tg_name          = data.terraform_remote_state.resource_app.outputs.green_tg_name
  alb_https_listener_arn = data.terraform_remote_state.resource_app.outputs.alb_https_listener_arn

  #CodePipeline
  pipeline_type                 = "V2"
  branch_name                   = var.branch_name
  full_repositroy_id            = var.full_repositroy_id
  task_definition_template_path = "taskdef.json"
  app_spec_template_path        = "appspec.yml"
}