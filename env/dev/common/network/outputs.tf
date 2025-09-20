output "vpc_id" {
  value = module.network.vpc.id
}

output "internet_gateway_id" {
  value = module.network.internet_gateway.id
}

output "public_subnet_ids" {
  value = module.network.public_subnet_ids
}

output "dmz_subnet_ids" {
  value = module.network.dmz_subnet_ids
}

output "private_subnet_ids" {
  value = module.network.private_subnet_ids
}

output "ecs_cluster_id" {
  value = module.network.ecs_cluster.id
}

output "ecs_cluster_name" {
  value = module.network.ecs_cluster.name
}