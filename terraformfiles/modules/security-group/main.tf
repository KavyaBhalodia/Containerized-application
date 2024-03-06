
#Security group for load balancer
resource "aws_security_group" "load-balancer-sg" {
  name        = var.alb-sg-name
  description = "Allow all traffic"
  vpc_id      = aws_vpc.main.id
}

#Security group rules for load balancer security group
resource "aws_security_group_rule" "load-balancer-sg-rule" {
  type              = "ingress"
  from_port         = var.load-balancer-sg-rule-to-port
  to_port           = var.load-balancer-sg-rule-from-port
  protocol          = var.load-balancer-sg-rule-protocol
  cidr_blocks       = var.load-balancer-sg-rule-cidr
  ipv6_cidr_blocks  = var.load-balancer-sg-rule-ipv6-cidr
  security_group_id = aws_security_group.load-balancer-sg.id
}
resource "aws_security_group_rule" "load-balancer-sg-rule-1" {
  type              = "egress"
  from_port         = var.load-balancer-sg-rule-1-from-port
  to_port           = var.load-balancer-sg-rule-1-to-port
  protocol          = var.load-balancer-sg-rule-1-protocol
  cidr_blocks       = var.load-balancer-sg-rule-1-cidr
  ipv6_cidr_blocks  = var.load-balancer-sg-rule-1-ipv6-cidr
  security_group_id = aws_security_group.load-balancer-sg.id
 
}

#Security group for ECS tasks
resource "aws_security_group" "ecs-sg" {
  name        = var.ecs-sg-name
  description = "Allow traffic from lb"
  vpc_id      = aws_vpc.main.id
}

#Security group rules for ECS tasks
resource "aws_security_group_rule" "ecs-sg-rule" {
  type                     = "ingress"
  from_port                = var.ecs-sg-rule-from-port
  to_port                  = var.ecs-sg-rule-to-port
  protocol                 = var.ecs-sg-rule-protocol
  source_security_group_id = aws_security_group.load-balancer-sg.id
  security_group_id        = aws_security_group.ecs-sg.id
}
resource "aws_security_group_rule" "ecs-sg-rule-1" {
 
  type              = "egress"
  from_port         = var.ecs-sg-rule-1-from-port
  to_port           = var.ecs-sg-rule-1-to-port
  protocol          = var.ecs-sg-rule-1-protocol
  cidr_blocks       = var.ecs-sg-rule-1-cidr
  ipv6_cidr_blocks  = var.ecs-sg-rule-1-ipv6-cidr
  security_group_id = aws_security_group.ecs-sg.id
}

#Security group for RDS
resource "aws_security_group" "rds-sg" {
  name        = var.rds-sg-name
  description = "Allow all traffic"
  vpc_id      = aws_vpc.main.id
  
}

#Security group rules for RDS security group
resource "aws_security_group_rule" "rds-sg-rule-1" {
  security_group_id = aws_security_group.rds-sg.id
  provider          = aws.sandbox
  type              = "ingress"
  from_port         = var.rds-sg-rule-1-from-port
  to_port           = var.rds-sg-rule-1-to-port
  protocol          = var.rds-sg-rule-1-protocol
  cidr_blocks       = var.rds-sg-rule-1-cidr
  ipv6_cidr_blocks  = var.rds-sg-rule-1-ipv6-cidr
}

resource "aws_security_group_rule" "rds-sg-rule-2" {
  security_group_id = aws_security_group.rds-sg.id
  provider          = aws.sandbox
  type              = "egress"
  from_port         = var.rds-sg-rule-2-from-port
  to_port           = var.rds-sg-rule-2-to-port
  protocol          = var.rds-sg-rule-2-protocol
  cidr_blocks       = var.rds-sg-rule-2-cidr
  ipv6_cidr_blocks  = var.rds-sg-rule-2-ipv6-cidr

}

resource "aws_security_group_rule" "rds-sg-rule-3" {
  provider                 = aws.sandbox
  type                     = "ingress"
  from_port                = var.rds-sg-rule-3-from-port
  to_port                  = var.rds-sg-rule-3-to-port
  protocol                 = var.rds-sg-rule-3-protocol
  source_security_group_id = aws_security_group.ecs-sg.id
  security_group_id        = aws_security_group.rds-sg.id
}

#Security group for bastion host
resource "aws_security_group" "bastion-host-sg" {
  name        = "bastion-host-sg"
  description = "Allow all traffic"
  vpc_id      = aws_vpc.main.id
  provider    = aws.sandbox
}

#Security group rules for bastion host
resource "aws_security_group_rule" "bastion-host-rule-1" {
  security_group_id = aws_security_group.bastion-host-sg.id
  provider          = aws.sandbox
  type              = "ingress"
  from_port         = 0
  to_port           = 0
  protocol          = "all"
  cidr_blocks       = ["0.0.0.0/0"]
  ipv6_cidr_blocks  = ["::/0"]

}
resource "aws_security_group_rule" "bastion-host-rule-2" {
  security_group_id = aws_security_group.bastion-host-sg.id
  provider          = aws.sandbox
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "all"
  cidr_blocks       = ["0.0.0.0/0"]
  ipv6_cidr_blocks  = ["::/0"]
}