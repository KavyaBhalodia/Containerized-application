variable "vpc-name" {
  type = string
  description = "name of the vpc"
}
variable "public_subnet_cidr" {
  type        = list(string)
  description = "Public subnet cidr"
}
variable "private_subnet_cidr" {
  type        = list(string)
  description = "Private subnet cidr"
}
variable "public-subnet-name" {
  type = string
  description = "name of the public subnet"
}
variable "private-subnet-name" {
    type = string
    description = "name of the private subnet"
  
}
variable "az" {
  type        = list(string)
  description = "Avalaibility zone for subnets"
}
variable "public-rt-name" {
    type=string
  description = "name of the route table"
}
variable "private-rt-name" {
    type=string
  description = "name of the route table"
}
variable "ig-name" {
    type = string
    description = "name of the internet gateway"
  
}
variable "NatGW-name" {
  type = string
  description = "name of Nat Gateway"
}
