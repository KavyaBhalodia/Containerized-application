# //main-vpc
# resource "aws_vpc" "main" {
#   cidr_block       = "10.0.0.0/16"
#   instance_tenancy = "default"

#   tags = {
#     Name = "main"
#   }
# }
# //public-subnets(2)
# resource "aws_subnet" "public-subnet" {
#   vpc_id                  = aws_vpc.main.id
#   count                   = length(var.public_subnet_cidr)
#   cidr_block              = element(var.public_subnet_cidr, count.index)
#   map_public_ip_on_launch = true
#   availability_zone       = element(var.az, count.index)

#   tags = {
#     Name = "public-subnet-${count.index + 1}"
#   }
# }
# //private-subnets(2)
# resource "aws_subnet" "private-subnet" {
#   vpc_id            = aws_vpc.main.id
#   count             = length(var.private_subnet_cidr)
#   cidr_block        = element(var.private_subnet_cidr, count.index)
#   availability_zone = element(var.az, count.index)
#   tags = {
#     Name = "private-subnet-${count.index + 1}"
#   }
# }
# //internet-gateway
# resource "aws_internet_gateway" "main-vpc-igw" {
#   vpc_id = aws_vpc.main.id

#   tags = {
#     Name = "main"
#   }
# }
# //route-table for public subnet
# resource "aws_route_table" "public-rt" {
#   vpc_id = aws_vpc.main.id

#   route {
#     cidr_block = "0.0.0.0/0"
#     gateway_id = aws_internet_gateway.main-vpc-igw.id
#   }

#   tags = {
#     Name = "public-subnet-rt"
#   }
# }

# //eip for nat gateway
# resource "aws_eip" "nat-gateway-eip" {
#   domain = "vpc"

# }
# resource "aws_nat_gateway" "nat-gateway" {
#   allocation_id = aws_eip.nat-gateway-eip.id
#   subnet_id     = aws_subnet.public-subnet[0].id

#   tags = {
#     Name = "gw NAT"
#   }

#   depends_on = [aws_eip.nat-gateway-eip, aws_subnet.public-subnet]
# }
# //route-table for private subnets
# resource "aws_route_table" "private-rt" {
#   vpc_id = aws_vpc.main.id

#   route {
#     cidr_block     = "0.0.0.0/0"
#     nat_gateway_id = aws_nat_gateway.nat-gateway.id
#   }

#   tags = {
#     Name = "private-subnet-rt"
#   }
# }
# //public-rt association
# resource "aws_route_table_association" "public-rt-association" {
#   count          = length(var.public_subnet_cidr)
#   subnet_id      = element(aws_subnet.public-subnet.*.id, count.index)
#   route_table_id = aws_route_table.public-rt.id
# }
# //private-rt association
# resource "aws_route_table_association" "private-rt-association" {
#   count          = length(var.private_subnet_cidr)
#   subnet_id      = element(aws_subnet.private-subnet.*.id, count.index)
#   route_table_id = aws_route_table.private-rt.id
# }
