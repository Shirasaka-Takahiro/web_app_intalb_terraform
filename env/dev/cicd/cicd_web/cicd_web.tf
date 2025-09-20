##Provider for ap-northeast-1
provider "aws" {
  profile    = "terraform-user"
  access_key = var.access_key
  secret_key = var.secret_key
  region     = "ap-northeast-1"
}

##Web CI/CD
module "cicd_web" {
  source = "../../../modules/cicd/web"

  #CodeBuild
  general_config  = var.general_config
  execution_role_arn = data.terraform_remote_state.resource_web.outputs.ecs_role_arn
  ecr_repository_url = data.terraform_remote_state.resource_web.outputs.ecr_repository_url
  buildspec_path = "module/codebuild/buildspec.yml"
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
  codebuild_project_name             = module.codebuild.codebuild_project_name
  codedeploy_app_name                = module.codedeploy.codedeploy_app_name
  codedeploy_deployment_group_name   = module.codedeploy.codedeploy_deployment_group_name
  task_definition_template_path      = file("../../module/codebuild/taskdef.json")
  app_spec_template_path             = file("../../module/codebuild/appspec.yml")
}
















##CodeStarConnections
module "codestarconnections" {
  source = "../../module/codestarconnections"

  general_config  = var.general_config
  repository_role = var.repository_role
}


##CodeStarConnections
module "codestarconnections" {
  source = "../../module/codestarconnections"

  general_config  = var.general_config
  repository_role = var.repository_role
}

##Codebuild
module "codebuild" {
  source = "../../module/codebuild"

  general_config     = var.general_config
  region             = var.region
  ecr_repository_url = module.ecr.ecr_repository_url
  iam_codebuild_arn  = module.iam_codebuild.iam_role_arn
  task_role          = var.task_role
  execution_role_arn = module.iam_ecs.iam_role_arn
  vpc_id             = module.network.vpc_id
  dmz_subnet_ids     = module.network.dmz_subnet_ids
  internal_sg_id     = module.internal_sg.security_group_id
}

##CodeDeploy
module "codedeploy" {
  source = "../../module/codedeploy"

  general_config     = var.general_config
  iam_codedeploy_arn = module.iam_codedeploy.iam_role_arn
  ecs_cluster_name   = module.ecs.ecs_cluster_name
  ecs_service_name   = module.ecs.ecs_service_name
  blue_tg_name       = module.alb.blue_tg_name
  green_tg_name      = module.alb.green_tg_name
  alb_https_listener = module.alb.alb_https_listener_arn
}

##Codepipeline
module "codepipeline" {
  source = "../../module/codepipeline"

  general_config                     = var.general_config
  iam_codepipeline_arn               = module.iam_codepipeline.iam_role_arn
  bucket_name                        = module.s3_pipeline_bucket.bucket_name
  branch_name                        = var.branch_name
  codestarconnections_connection_arn = module.codestarconnections.codestarconnections_connection_arn
  full_repositroy_id                 = var.full_repositroy_id
  codebuild_project_name             = module.codebuild.codebuild_project_name
  codedeploy_app_name                = module.codedeploy.codedeploy_app_name
  codedeploy_deployment_group_name   = module.codedeploy.codedeploy_deployment_group_name
  task_definition_template_path      = file("../../module/codebuild/taskdef.json")
  app_spec_template_path             = file("../../module/codebuild/appspec.yml")
}