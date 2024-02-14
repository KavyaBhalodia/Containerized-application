
variable "public_subnet_cidr" {
  type        = list(string)
  description = "Public subnet cidr"
developer

  default     = ["10.0.0.0/24", "10.0.1.0/24"]
 main

}
variable "private_subnet_cidr" {
  type        = list(string)
  description = "Private subnet cidr"
developer

}
variable "az" {
  type        = list(string)
  description = "Avalaibility zone for subnets"

  default     = ["10.0.16.0/24", "10.0.32.0/24"]

}
variable "az" {
  type = list(string)
  description = "Avalaibility zone for subnets"
  default = [ "ap-south-1a","ap-south-1b" ]
 main
}