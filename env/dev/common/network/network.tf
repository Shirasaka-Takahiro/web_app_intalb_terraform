##Network
module "network" {
  source = "../../../../modules/common/network"

  general_config     = var.general_config
  availability_zones = var.availability_zones
  vpc_cidr           = var.vpc_cidr
  public_subnets     = var.public_subnets
  private_subnets    = var.private_subnets
  dmz_subnets        = var.dmz_subnets
  dmz_subnet_ids     = module.network.dmz_subnet_ids
}