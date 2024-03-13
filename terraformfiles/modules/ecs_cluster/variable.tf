variable "ecs-cluster-name" {
    type = string
    description = "name of the ecs cluster"
}
variable "default_capacity_providers" {
  type = list(object({
    capacity_provider = string
    base=number
    weight=number
  }))
}