
#VPC 
resource "aws_vpc" "main" {
  cidr_block       = "10.0.0.0/16"
  instance_tenancy = "default"
  tags = {
    Name = var.vpc_name
  }
  # lifecycle {
  #   prevent_destroy = true
  # }
}

#Public subnets
resource "aws_subnet" "public_subnet" {
  vpc_id                  = aws_vpc.main.id
  count                   = length(var.public_subnet_cidr)
  cidr_block              = element(var.public_subnet_cidr, count.index)
  map_public_ip_on_launch = true
  availability_zone       = element(var.az, count.index)
  tags = {
    Name = "${var.public_subnet_name}-${count.index + 1}"
  }
}

#Public subnet route table
resource "aws_route_table" "public_rt" {
  vpc_id   = aws_vpc.main.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.main_vpc_igw.id
  }
  tags = {
    Name = var.public_rt_name
  }
}

#Public route table association
resource "aws_route_table_association" "public_rt_association" {
  count          = length(var.public_subnet_cidr)
  subnet_id      = element(aws_subnet.public_subnet.*.id, count.index)
  route_table_id = aws_route_table.public_rt.id
}

#Private subnets
resource "aws_subnet" "private_subnet" {
  vpc_id            = aws_vpc.main.id
  count             = length(var.private_subnet_cidr)
  cidr_block        = element(var.private_subnet_cidr, count.index)
  availability_zone = element(var.az, count.index)
  tags = {
    Name = "${var.private_subnet_name}-${count.index + 1}"
  }
}


#Private subnet route table 
resource "aws_route_table" "private_rt" {
  vpc_id   = aws_vpc.main.id
  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.nat_gateway.id
  }
  tags = {
    Name = var.private_rt_name
  }
}

#Private route table association
resource "aws_route_table_association" "private_rt_association" {
  count          = length(var.private_subnet_cidr)
  subnet_id      = element(aws_subnet.private_subnet.*.id, count.index)
  route_table_id = aws_route_table.private_rt.id
}

#Internet gateway
resource "aws_internet_gateway" "main_vpc_igw" {
  vpc_id   = aws_vpc.main.id
  tags = {
    Name = var.ig_name
  }
}

#Elastic IP for NAT gateway 
resource "aws_eip" "nat_gateway_eip" {
  domain   = "vpc"
}

#NAT gateway
resource "aws_nat_gateway" "nat_gateway" {
  allocation_id = aws_eip.nat_gateway_eip.id
  subnet_id     = aws_subnet.public_subnet[0].id
  tags = {
    Name = var.NatGW_name
  }
  depends_on = [aws_eip.nat_gateway_eip, aws_subnet.public_subnet]
}

#Default NACL group for subnets
resource "aws_default_network_acl" "default_nacl" {
  default_network_acl_id = aws_vpc.main.default_network_acl_id

  dynamic ingress {
    for_each = var.ingress_rules
    content {
      from_port = ingress.value.from_port
      to_port = ingress.value.to_port
      protocol = try(coalesce(ingress.value.protocol, "tcp", null))
      rule_no = ingress.value.rule_no
      action = ingress.value.action
      cidr_block = ingress.value.cidr_block
    }
    
  }
dynamic egress {
    for_each = var.egress_rules
    content {
      from_port = egress.value.from_port
      to_port = egress.value.to_port
      protocol = try(coalesce(egress.value.protocol, "tcp", null))
      rule_no = egress.value.rule_no
      action = egress.value.action
      cidr_block = egress.value.cidr_block

    }
    
  }
 
}
