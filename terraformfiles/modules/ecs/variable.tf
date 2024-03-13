variable "ecs-cluster-name" {
    type = string
    description = "name of the ecs cluster"
}
variable "ecs-cluster-id" {
  type = string
  description = "Id of the ECS cluster"
}
variable "container-name" {
  type = string
  description = "name of the container"
}
variable "base" {
  type = number
  description = "minimum number of tasks that should be running"
  
}
variable "weight" {
  type = number
  description = "Additional tasks that needs to be launched when there is increase in demand"
}
variable "cpu" {
  type = number
  description = "maximum number of CPU resources in a container for a task are allowed"
}
variable "memory" {
  type = number
  description = "amount of RAM allocated to the container"
}
variable "container-port" {
  type = number
  description = "The port of container to expose"
}
variable "host-port" {
  type = number
  description = "The port of host to expose"
}
variable "container-log-grp-name" {
  type = string
  description = "Name of the log group"
}
variable "ecs-service-name" {
  type = string
  description = "Name of the service"
}
variable "image-url" {
  type = string
  description = "value"
}
variable "target-grp-arn" {
  type = string
  description = "value"
}
variable "private-subnets" {
  type = list(string)
}
variable "ecs-sg-id" {
  type = list(string)
}
variable "environment_variable"  {
  
}
variable "role-arn" {
  type = string
}
variable "bucket" {
  type = string
}
variable "key" {
  type = string
}
variable "region" {
  type = string
}
variable "default_capacity_providers" {
  type = list(object({
    capacity_provider = string
    base=number
    weight=number
  }))
}