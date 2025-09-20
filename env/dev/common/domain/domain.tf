##Provider for ap-northeast-1
provider "aws" {
  profile    = "terraform-user"
  access_key = var.access_key
  secret_key = var.secret_key
  region     = "ap-northeast-1"
}

##Domain
module "domain" {
  source = "../../../../modules/common/domain"

  host_zone_name = var.host_zone_name
  domain_name    = var.domain_name
  sans           = var.sans
}