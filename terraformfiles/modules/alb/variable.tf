variable "alb_name" {
  type = string
  description = "Name of the application load balancer"
}
variable "alb_logs_prefix" {
  type = string
}
variable "listener_port" {
    type = number
    description = "Port where listener will listen for requests"
}
variable "target_group_name" {
  type = string
  description = "Name of the Target_grp"
}
variable "alb_sg" {
  type = list(string)
  description = "Application load balancer security group"
}
variable "public_subnets" {
  type = list(string)
  description = "Public subnets"
}
variable "access_log_bucket" {
  type = string
  description = "Access log bucket for logs of application load balancer"
}
variable "vpc_id" {
  type = string
  description = "VPC_id"
}