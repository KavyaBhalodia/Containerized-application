variable "alb-name" {
  type = string
  description = "Name of the application load balancer"
}
variable "prefix" {
  type = string
  description = "Name of the prefix of APplication load balancer logs in s3 bucket"
}
variable "listener-port" {
    type = number
    description = "Port where listener will listen for requests"
}
variable "target-group-name" {
  type = string
  description = "Name of the Target-grp"
}
variable "alb-sg" {
  type = list(string)
}
variable "public-subnets" {
  type = list(string)
}
variable "access-log-bucket" {
  type = string
}
variable "vpc-id" {
  type = string
}