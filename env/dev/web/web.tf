##Provider for ap-northeast-1
provider "aws" {
  profile    = "terraform-user"
  access_key = var.access_key
  secret_key = var.secret_key
  region     = "ap-northeast-1"
}

##Web
module "web" {
  source = "../../../modules/resource/web"

  general_config = var.general_config
  vpc_id         = data.terraform_remote_state.common_network.outputs.vpc_id

  #ALB
  public_subnet_ids = data.terraform_remote_state.common_network.outputs.public_subnet_ids
  cert_alb_arn      = data.terraform_remote_state.common_domain.outputs.cert_alb_arn

  #ECS
  ecs_cluster_id        = data.terraform_remote_state.common_network.outputs.ecs_cluster_id
  fargate_cpu           = "256"
  fargate_memory        = "512"
  dmz_subnet_ids        = data.terraform_remote_state.common_network.outputs.dmz_subnet_ids
  desired_count         = 1
  deployment_controller = "CODE_DEPLOY"

  #Route53
  domain_name = var.domain_name
  zone_id     = data.terraform_remote_state.common_domain.outputs.host_zone_id

}