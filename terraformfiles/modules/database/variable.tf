variable "db_identifier" {
  type = string
  description = "Identifier for RDS database"
}
variable "username" {
  type = string
  description = "Username for RDS database"
}
variable "password" {
  type = string
  description = "Password for database"
}
variable "subnet_grp_name" {
  type = string
  description = "Subnet_grp_name for database"
}
variable "public_subnets" {
  type = list(string)
  description = "public subnets"
}
variable "rds_sg" {
  type = list(string)
  description = "RDS Database security group"
}
variable "az" {
  type = string
  description = "AZ for Database"
}