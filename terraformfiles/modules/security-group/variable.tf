variable "alb-sg-name" {
  type = string
  description = "Name of the Application load balancer"
}
variable "load-balancer-sg-rule-to-port" {
  type = number
  description = "Integer value for attribute to port"
}
variable "load-balancer-sg-rule-from-port" {
  type = number
  description = "Integer value for attribute from port"
}
variable "load-balancer-sg-rule-protocol" {
  type = string
  description = "The protocol to be allowed"
}
variable "load-balancer-sg-rule-cidr" {
    type = list(string)
    description = "cidr range for load balancer security group rule"
}
variable "load-balancer-sg-rule-ipv6-cidr" {
  type = list(string)
  description = "value"
}
variable "load-balancer-sg-rule-1-to-port" {
  type = number
  description = "value"
}
variable "load-balancer-sg-rule-1-from-port" {
  type = number
  description = "value"
}
variable "load-balancer-sg-rule-1-protocol" {
  type= string
  description = "value"
}
variable "load-balancer-sg-rule-1-ipv6-cidr" {
  type = list(string)
  description = "value"
}
variable "load-balancer-sg-rule-1-cidr" {
  type = list(string)
  description = "value"
}
variable "ecs-sg-name" {
  type = string
  description = "value"
}
variable "ecs-sg-rule-from-port" {
  type = number
  description = "value"
}
variable "ecs-sg-rule-to-port" {
  type = number
  description = "value"
}
variable "ecs-sg-rule-protocol" {
  type = number
  description = "value"
}
variable "ecs-sg-rule-1-from-port" {
  type = number
  description = "value"
}
variable "ecs-sg-rule-1-to-port" {
  type = number
  description = "value"
}
variable "ecs-sg-rule-1-protocol" {
  type = string
  description = "value"
}
variable "ecs-sg-rule-1-cidr" {
  type = list(string)
  description = "value"
}
variable "ecs-sg-rule-1-ipv6-cidr" {
  type = list(string)
  description = "value"
}
variable "rds-sg-name" {
  type = string
  description = "value"
}
variable "rds-sg-rule-1-from-port" {
  type = string
  description = "value"
}
variable "rds-sg-rule-1-to-port" {
  type = string
  description = "value"
}
variable "rds-sg-rule-1-protocol" {
  type = string
  description = "value"
}
variable "rds-sg-rule-1-cidr" {
  type = list(string)
  description = "value"
}
variable "rds-sg-rule-1-ipv6-cidr" {
  type = list(string)
  description = "value"
}
variable "rds-sg-rule-2-from-port" {
  type = string
  description = "value"
}
variable "rds-sg-rule-2-to-port" {
  type = string
  description = "value"
}
variable "rds-sg-rule-2-protocol" {
  type = string
  description = "value"
}
variable "rds-sg-rule-2-cidr" {
  type = list(string)
  description = "value"
}
variable "rds-sg-rule-2-ipv6-cidr" {
  type = list(string)
  description = "value"
}
variable "rds-sg-rule-3-from-port" {
  type = string
  description = "value"
}
variable "rds-sg-rule-3-to-port" {
  type = string
  description = "value"
}
variable "rds-sg-rule-3-protocol" {
  type = string
  description = "value"
}