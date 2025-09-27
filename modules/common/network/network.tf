##VPC
resource "aws_vpc" "vpc" {
  cidr_block           = var.vpc_cidr
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = {
    Name = "${var.general_config["project"]}-${var.general_config["env"]}-vpc"
  }
}

##Public Subnets
resource "aws_subnet" "public_subnets" {
  vpc_id                  = aws_vpc.vpc.id
  for_each                = var.public_subnets.subnets
  cidr_block              = each.value.cidr
  availability_zone       = each.value.az
  map_public_ip_on_launch = true

  tags = {
    Name = "${var.general_config["project"]}-${var.general_config["env"]}-public-${substr(each.value.az, -2, 2)}"
  }
}

##DMZ Subnets
resource "aws_subnet" "dmz_subnets" {
  vpc_id                  = aws_vpc.vpc.id
  for_each                = var.dmz_subnets.subnets
  cidr_block              = each.value.cidr
  availability_zone       = each.value.az
  map_public_ip_on_launch = false
  tags = {
    Name = "${var.general_config["project"]}-${var.general_config["env"]}-dmz-${substr(each.value.az, -2, 2)}"
  }
}


##Private Subnets
resource "aws_subnet" "private_subnets" {
  vpc_id            = aws_vpc.vpc.id
  for_each          = var.private_subnets.subnets
  cidr_block        = each.value.cidr
  availability_zone = each.value.az

  tags = {
    Name = "${var.general_config["project"]}-${var.general_config["env"]}-private-${substr(each.value.az, -2, 2)}"
  }
}


##Internet Gateway
resource "aws_internet_gateway" "internet_gateway" {
  vpc_id = aws_vpc.vpc.id

  tags = {
    Name = "${var.general_config["project"]}-${var.general_config["env"]}-igw"
  }
}

##Public Route Tables
resource "aws_route_table" "public_route_tables" {
  vpc_id   = aws_vpc.vpc.id
  for_each = var.public_subnets.subnets

  tags = {
    Name = "${var.general_config["project"]}-${var.general_config["env"]}-pubic-rtb-${substr(each.value.az, -2, 2)}"
  }
}

##DMZ Route Tables
resource "aws_route_table" "dmz_route_tables" {
  vpc_id   = aws_vpc.vpc.id
  for_each = var.dmz_subnets.subnets

  tags = {
    Name = "${var.general_config["project"]}-${var.general_config["env"]}-dmz-rtb-${substr(each.value.az, -2, 2)}"
  }
}

##Public Internet Gateway
resource "aws_route" "public_internet_gateway" {
  gateway_id             = aws_internet_gateway.internet_gateway.id
  for_each               = var.public_subnets.subnets
  route_table_id         = aws_route_table.public_route_tables[each.key].id
  destination_cidr_block = "0.0.0.0/0"
}

##Public Route Associations
resource "aws_route_table_association" "public_route_associations" {
  for_each       = var.public_subnets.subnets
  subnet_id      = aws_subnet.public_subnets[each.key].id
  route_table_id = aws_route_table.public_route_tables[each.key].id
}

##DMZ Route Associations
resource "aws_route_table_association" "dmz_route_associations" {
  for_each       = var.dmz_subnets.subnets
  subnet_id      = aws_subnet.dmz_subnets[each.key].id
  route_table_id = aws_route_table.dmz_route_tables[each.key].id
}

##Private Route Tables
resource "aws_route_table" "private_route_tables" {
  vpc_id   = aws_vpc.vpc.id
  for_each = var.private_subnets.subnets

  tags = {
    Name = "${var.general_config["project"]}-${var.general_config["env"]}-private-rtb-${substr(each.value.az, -2, 2)}"
  }
}

##Private Route Associtions
resource "aws_route_table_association" "private_route_associations" {
  for_each       = var.private_subnets.subnets
  subnet_id      = aws_subnet.private_subnets[each.key].id
  route_table_id = aws_route_table.private_route_tables[each.key].id
}

##Elastic IP for Nat Gateway
resource "aws_eip" "eip_nat_gateway" {
  domain = "vpc"
  tags = {
    Name = "${var.general_config["project"]}-${var.general_config["env"]}-eip"
  }
}

##NAT Gateway
resource "aws_nat_gateway" "nat_gateway" {
  allocation_id = aws_eip.eip_nat_gateway.id
  subnet_id     = var.public_subnet_ids[0]
  depends_on = [
    aws_internet_gateway.internet_gateway
  ]

  tags = {
    Name = "${var.general_config["project"]}-${var.general_config["env"]}-natgw"
  }
}

##DMZ Nat Gateway
resource "aws_route" "dmz_nat_gateway" {
  for_each               = var.dmz_subnets.subnets
  nat_gateway_id         = aws_nat_gateway.nat_gateway.id
  route_table_id         = aws_route_table.dmz_route_tables[each.key].id
  destination_cidr_block = "0.0.0.0/0"
}