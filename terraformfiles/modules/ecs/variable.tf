
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
  description = "Private subnets for vpc"
}
variable "ecs_sg_id" {
  type = list(string)
  description = "private subnets for ECS security groups"
}
variable "environment_variable"  {
  description = "values for environment variables in task definition"
}
variable "role_arn" {
  type = string
  description = "Role arn for ECS Tasks"
}

variable "region" {
  type = string
  description = "Region for resources"
}
variable "policy_name" {
  type = string
  description = "Policy for ECS"
}
variable "target" {
  type = number
  description = "target of tasks to deploy"
}
variable "scale_in_cooldown" {
  type = number
  description = "attribute for ASG policy"
}
variable "scale_out_cooldown" {
  type = number
  description = "attribute for ASG policy"
}
variable "cluster_name" {
  type = string
  description = "Name of the cluster"
}
variable "alb_arn_suffix" {
  type = string
  description = "ALB arn suffic for ASG policy"
}
variable "target_group_arn_suffix" {
  type = string
  description = "ALB arn suffic for ASG policy"
}
variable "secret_variables" {
  description = "values for secret variables in task definition"
}