variable "alb-sg-name" {
  type = string
  description = "Name of the Application load balancer"
}
variable "alb-ingress-rule-protocol" {
  type = string
  description = "protocols that are allowed in load balancer sg"
}
variable "alb-ingress-rule-cidr" {
  type = list(string)
  description = "CIDR range for ALB-sg"
}

variable "alb-ingress-rule-ipv6-cidr" {
  type = list(string)
  description = "IPV6 CIDR range for ALB-sg"
}
variable "alb-ingress-rule-from-port" {
  type = number
  description = "From port value for ALB-sg"
}
variable "alb-ingress-rule-to-port" {
  type = number
  description = "To port value for ALB-sg"
}
variable "alb-egress-rule-protocol" {
  type = string
  description = "protocols that are allowed in load balancer sg"
}
variable "alb-egress-rule-cidr" {
  type = list(string)
  description = "CIDR range for ALB-sg"
}

variable "alb-egress-rule-ipv6-cidr" {
  type = list(string)
  description = "IPV6 CIDR range for ALB-sg"
}
variable "alb-egress-rule-from-port" {
  type = number
  description = "From port value for ALB-sg"
}
variable "alb-egress-rule-to-port" {
  type = number
  description = "To port value for ALB-sg"
}
variable "ecs-sg-name" {
  type = string
  description = "name of the sg for ecs"
}
variable "ecs-sg-ingress-rule-from-port" {
  type = number
  description = "From port value for ecs sg-ingress rule"
}
variable "ecs-sg-ingress-rule-to-port" {
  type = number
  description = "To port value for ecs sg-ingress rule"
}
variable "ecs-sg-ingress-rule-protocol" {
  type = string
  description = "Protocol for ecs-sg"
}
variable "ecs-sg-egress-rule-from-port" {
  type = number
  description = "From port value for ecs sg-ingress rule"
}
variable "ecs-sg-egress-rule-to-port" {
  type = number
  description = "To port value for ecs sg-ingress rule"
}
variable "ecs-sg-egress-rule-protocol" {
  type = string
  description = "Protocol for ecs-sg"
}
variable "ecs-sg-egress-rule-cidr" {
  type=list(string)
  description = "CIDR range for ecs-sg"  
}
variable "ecs-sg-egress-rule-ipv6-cidr" {
  type=list(string)
  description = "IPV6 CIDR range for ecs-sg"  
}
variable "rds-sg-name" {
  type = string
  description = "name of the RDS-sg"
}
variable "rds-sg-ingress-rule-from-port" {
 type=number
 description = "From port value for RDS-sg"   
}
variable "rds-sg-ingress-rule-to-port" {
  type = number
  description = "To port value for RDS-sg"
  
}
variable "rds-sg-ingress-rule-protocol" {
  type = string
  description = "Protocol for RDS-sg"
}
variable "rds-sg-ingress-rule-cidr" {
  type = list(string)
  description = "CIDR range for RDS-sg"
}
variable "rds-sg-ingress-rule-ipv6-cidr" {
  type = list(string)
  description = "IPV6 CIDR range for RDS-sg"
}
variable "rds-sg-egress-rule-from-port" {
 type=number
 description = "From port value for RDS-sg"   
}
variable "rds-sg-egress-rule-to-port" {
  type = number
  description = "To port value for RDS-sg"
  
}
variable "rds-sg-egress-rule-protocol" {
  type = string
  description = "Protocol for RDS-sg"
}
variable "rds-sg-egress-rule-cidr" {
  type = list(string)
  description = "CIDR range for RDS-sg"
}
variable "rds-sg-egress-rule-ipv6-cidr" {
  type = list(string)
  description = "IPV6 CIDR range for RDS-sg"
}
variable "bastion-host-sg-name" {
  type = string
  description = "Name of the bastion host sg"
}
variable "bastion-host-ingress-rule-from-port" {
  type = number
  description = "From port value for bastion host sg"
}
variable "bastion-host-ingress-rule-to-port" {
  type = number
  description = "To port value for bastion host sg"
}
variable "bastion-host-ingress-rule-protocol" {
  type = string
  description = "Protocol for bastion host ingress value"
}
variable "bastion-host-ingress-cidr" {
  type = list(string)
  description = "CIDR range for bastion host"
}
variable "bastion-host-ingress-ipv6-cidr" {
  type = list(string) 
  description = "IPV6 CIDR range for bastion host "
}
variable "bastion-host-egress-rule-from-port" {
  type = number
  description = "From port value for bastion host sg"
}
variable "bastion-host-egress-rule-to-port" {
  type = number
  description = "To port value for bastion host sg"
}
variable "bastion-host-egress-rule-protocol" {
  type = string
  description = "Protocol for bastion host ingress value"
}
variable "bastion-host-egress-cidr" {
  type = list(string)
  description = "CIDR range for bastion host"
}
variable "bastion-host-egress-ipv6-cidr" {
  type = list(string) 
  description = "IPV6 CIDR range for bastion host "
}
variable "vpc-id" {
  type = string
}