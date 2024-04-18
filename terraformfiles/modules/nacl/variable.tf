variable "ingress_rules" {
  description = "value"
  type = list(object({
  rule_no    = number
  cidr_block = string
  from_port  = number
  to_port    = number
  protocol = optional(string,"tcp")
  action=string
  }))
}
variable "egress_rules" {
  description = "value"
  type = list(object({
  rule_no    = number
  cidr_block = string
  from_port  = number
  to_port    = number
  protocol   = optional(string,"tcp")
  action=string
  }))
}
variable "vpc_nacl" {
  type = string
  description = "value"
}
