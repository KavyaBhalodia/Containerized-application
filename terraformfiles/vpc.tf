
# #VPC 
# resource "aws_vpc" "main" {
#   cidr_block       = "10.0.0.0/16"
#   instance_tenancy = "default"
#   provider         = aws.sandbox
#   tags = {
#     Name = "${local.env}-containerized-application-vpc"
#   }

# }

# #Public subnets
# resource "aws_subnet" "public-subnet" {
#   vpc_id                  = aws_vpc.main.id
#   count                   = length(var.public_subnet_cidr)
#   cidr_block              = element(var.public_subnet_cidr, count.index)
#   map_public_ip_on_launch = true
#   availability_zone       = element(var.az, count.index)
#   provider                = aws.sandbox

#   tags = {
#     Name = "${local.env}-public-subnet-${count.index + 1}"
#   }
# }

# #Public subnet route table
# resource "aws_route_table" "public-rt" {
#   vpc_id   = aws_vpc.main.id
#   provider = aws.sandbox

#   route {
#     cidr_block = "0.0.0.0/0"
#     gateway_id = aws_internet_gateway.main-vpc-igw.id
#   }

#   tags = {
#     Name = "${local.env}-public-subnet-rt"
#   }
# }

# #Public route table association
# resource "aws_route_table_association" "public-rt-association" {
#   provider       = aws.sandbox
#   count          = length(var.public_subnet_cidr)
#   subnet_id      = element(aws_subnet.public-subnet.*.id, count.index)
#   route_table_id = aws_route_table.public-rt.id
# }

# #Private subnets
# resource "aws_subnet" "private-subnet" {
#   provider          = aws.sandbox
#   vpc_id            = aws_vpc.main.id
#   count             = length(var.private_subnet_cidr)
#   cidr_block        = element(var.private_subnet_cidr, count.index)
#   availability_zone = element(var.az, count.index)
#   tags = {
#     Name = "${local.env}-private-subnet-${count.index + 1}"
#   }
# }

# #Private subnet route table 
# resource "aws_route_table" "private-rt" {
#   provider = aws.sandbox
#   vpc_id   = aws_vpc.main.id

#   route {
#     cidr_block     = "0.0.0.0/0"
#     nat_gateway_id = aws_nat_gateway.nat-gateway.id
#   }

#   tags = {
#     Name = "${local.env}-private-subnet-rt"
#   }
# }

# #Private route table association
# resource "aws_route_table_association" "private-rt-association" {
#   provider       = aws.sandbox
#   count          = length(var.private_subnet_cidr)
#   subnet_id      = element(aws_subnet.private-subnet.*.id, count.index)
#   route_table_id = aws_route_table.private-rt.id
# }

# #Internet gateway
# resource "aws_internet_gateway" "main-vpc-igw" {
#   provider = aws.sandbox
#   vpc_id   = aws_vpc.main.id

#   tags = {
#     Name = "${local.env}-containerized-application-igw"
#   }
# }

# #Elastic IP for NAT gateway 
# resource "aws_eip" "nat-gateway-eip" {
#   provider = aws.sandbox
#   domain   = "vpc"
# }

# #NAT gateway
# resource "aws_nat_gateway" "nat-gateway" {
#   provider      = aws.sandbox
#   allocation_id = aws_eip.nat-gateway-eip.id
#   subnet_id     = aws_subnet.public-subnet[0].id

#   tags = {
#     Name = "${local.env}-conatainerized-application-NATgw"
#   }

#   depends_on = [aws_eip.nat-gateway-eip, aws_subnet.public-subnet]
# }
module "vpc" {
  source = "./modules/vpc"
  vpc-name = "containerized-application-vpc"
  private-subnet-name = "private-subnet"
  public-subnet-name = "public-subnet"
  private-rt-name = "private-rt"
  public-rt-name = "public-rt"
  private_subnet_cidr = ["10.0.16.0/24", "10.0.32.0/24"]
  public_subnet_cidr =  ["10.0.0.0/24", "10.0.1.0/24"]
  ig-name = "Internet-gateway"
  NatGW-name = "Nat-gateway"
  az = ["us-west-2a", "us-west-2b"]
  
  providers = {
    aws=aws.sandbox
  }
}


