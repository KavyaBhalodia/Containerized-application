
variable "ecs_cluster_id" {
  type = string
  description = "Id of the ECS cluster"
}
variable "container_name" {
  type = string
  description = "name of the container"
}
variable "cpu" {
  type = number
  description = "maximum number of CPU resources in a container for a task are allowed"
}
variable "memory" {
  type = number
  description = "amount of RAM allocated to the container"
}
variable "container_port" {
  type = number
  description = "The port of container to expose"
}
variable "host_port" {
  type = number
  description = "The port of host to expose"
}
variable "container_log_grp_name" {
  type = string
  description = "Name of the log group"
}
variable "ecs_service_name" {
  type = string
  description = "Name of the service"
}
variable "image_url" {
  type = string
  description = "value"
}
variable "target_grp_arn" {
  type = string
  description = "value"
}
variable "private_subnets" {
  type = list(string)
}
variable "ecs_sg_id" {
  type = list(string)
}
variable "environment_variable"  {
  
}
variable "role_arn" {
  type = string
}

variable "region" {
  type = string
}
variable "policy_name" {
  type = string
}
variable "target" {
  type = number
}
variable "scale_in_cooldown" {
  type = number
}
variable "scale_out_cooldown" {
  type = number
}
variable "cluster_name" {
  type = string
}
variable "alb_arn_suffix" {
  type = string
}
variable "target_group_arn_suffix" {
  type = string
}
variable "secret_variables" {
  
}