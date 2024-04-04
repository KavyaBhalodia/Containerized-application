variable "vpc_name" {
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
variable "public_subnet_name" {
  type = string
  description = "name of the public subnet"
}
variable "private_subnet_name" {
    type = string
    description = "name of the private subnet"
  
}
variable "az" {
  type        = list(string)
  description = "Avalaibility zone for subnets"
}
variable "public_rt_name" {
  type=string
  description = "name of the route table"
}
variable "private_rt_name" {
  type=string
  description = "name of the route table"
}
variable "ig_name" {
  type = string
  description = "name of the internet gateway"
}
variable "NatGW_name" {
  type = string
  description = "name of Nat Gateway"
}
