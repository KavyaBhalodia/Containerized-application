
variable "public_subnet_cidr" {
  type        = list(string)
  description = "Public subnet cidr"

}
variable "private_subnet_cidr" {
  type        = list(string)
  description = "Private subnet cidr"

}
variable "az" {
  type        = list(string)
  description = "Avalaibility zone for subnets"
}
variable "region" {
  type        = string
  description = "Region for infrastructure"
}
variable "ecr-repository" {
  type = string
}
variable "environment_variable" {

}
variable "secret_variable" {
  
}
variable "task_definitions" {
  type = map(string)
}