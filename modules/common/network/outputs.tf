output "vpc" {
  value = aws_vpc.vpc
}

output "internet_gateway" {
  value = aws_internet_gateway.internet_gateway
}

output "public_subnet_ids" {
  value = values(aws_subnet.public_subnets)[*].id
}

output "dmz_subnet_ids" {
  value = values(aws_subnet.dmz_subnets)[*].id
}

output "private_subnet_ids" {
  value = values(aws_subnet.private_subnets)[*].id
}

output "natgateway" {
  value = aws_eip.eip_nat_gateway
}

output "ecs_cluster" {
  value = aws_ecs_cluster.cluster
}