variable "sg_name" {
  type = string
  description = "Name of the Application load balancer"
  default = ""
}
variable "vpc_id" {
  type = string
  description = "VPC-id of the main VPC"
}
variable "ingress_rules" {
  description = "list of values to assign to security groups"
  type = list(object({
    from_port = number
    to_port = number
    cidr_blocks = optional(list(string))
    ipv6_cidr_blocks = optional(list(string))
    protocol=optional(string,"tcp")
  }
  ))
}
variable "egress_rules" {
  description = "list of values to assign to security groups"
  type = list(object({
    from_port = number
    to_port = number
  }))
}
