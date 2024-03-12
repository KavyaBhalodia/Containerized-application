variable "alb-sg-name" {
  type = string
  description = "Name of the Application load balancer"
  default = ""
}

variable "alb-ingress-rule-from-port" {
  type = number
  description = "From port value for ALB-sg"
  default = 0
}
variable "alb-ingress-rule-to-port" {
  type = number
  description = "To port value for ALB-sg"
  default = 0
}

variable "alb-egress-rule-from-port" {
  type = number
  description = "From port value for ALB-sg"
  default = 0
}
variable "alb-egress-rule-to-port" {
  type = number
  description = "To port value for ALB-sg"
  default = 0
}
variable "ecs-sg-name" {
  type = string
  description = "name of the sg for ecs"
  default = ""
}
variable "ecs-sg-ingress-rule-from-port" {
  type = number
  description = "From port value for ecs sg-ingress rule"
  default = 0
}
variable "ecs-sg-ingress-rule-to-port" {
  type = number
  description = "To port value for ecs sg-ingress rule"
  default = 0
}

variable "ecs-sg-egress-rule-from-port" {
  type = number
  description = "From port value for ecs sg-ingress rule"
  default = 0
}
variable "ecs-sg-egress-rule-to-port" {
  type = number
  description = "To port value for ecs sg-ingress rule"
  default = 0
}
variable "rds-sg-name" {
  type = string
  description = "name of the RDS-sg"
  default = ""
}
variable "rds-sg-ingress-rule-from-port" {
 type=number
 description = "From port value for RDS-sg"   
 default = 0
}
variable "rds-sg-ingress-rule-to-port" {
  type = number
  description = "To port value for RDS-sg"
  default = 0
  
}

variable "rds-sg-egress-rule-from-port" {
 type=number
 description = "From port value for RDS-sg"   
 default = 0
}
variable "rds-sg-egress-rule-to-port" {
  type = number
  description = "To port value for RDS-sg"
  default = 0
}

variable "bastion-host-sg-name" {
  type = string
  description = "Name of the bastion host sg"
  default = ""
}
variable "bastion-host-ingress-rule-from-port" {
  type = number
  description = "From port value for bastion host sg"
  default = 0
}
variable "bastion-host-ingress-rule-to-port" {
  type = number
  description = "To port value for bastion host sg"
  default = 0
}


variable "bastion-host-egress-rule-from-port" {
  type = number
  description = "From port value for bastion host sg"
  default = 0
}
variable "bastion-host-egress-rule-to-port" {
  type = number
  description = "To port value for bastion host sg"
  default = 0
}


variable "vpc-id" {
  type = string
  description = "VPC-id of the main VPC"
}