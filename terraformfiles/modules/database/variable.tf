variable "db-identifier" {
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
variable "subnet-grp-name" {
  type = string
  description = "Subnet-grp-name for database"
}
variable "public-subnets" {
  type = list(string)
  description = "public subnets"
}
variable "rds-sg" {
  type = list(string)
  description = "RDS Database security group"
}