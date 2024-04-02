
#Security group for load balancer
resource "aws_security_group" "load-balancer-sg" {
  name        = "${local.env}-load-balancer-sg"
  description = "Allow all traffic"
  vpc_id      = aws_vpc.main.id
  
}

#Security group rules for load balancer security group
resource "aws_security_group_rule" "load-balancer-ingress-rule" {
  type              = "ingress"
  from_port         = 0
  to_port           = 0
  protocol          = "all"
  cidr_blocks       = ["0.0.0.0/0"]
  ipv6_cidr_blocks  = ["::/0"]
  security_group_id = aws_security_group.load-balancer-sg.id
  
}
resource "aws_security_group_rule" "load-balancer-egress-rule" {
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "all"
  cidr_blocks       = ["0.0.0.0/0"]
  ipv6_cidr_blocks  = ["::/0"]
  security_group_id = aws_security_group.load-balancer-sg.id
  
}

#Security group for ECS tasks
resource "aws_security_group" "ecs-sg" {
  name        = "${local.env}-ecs-sg"
  description = "Allow traffic from lb"
  vpc_id      = aws_vpc.main.id
  
}

#Security group rules for ECS tasks
resource "aws_security_group_rule" "ecs-sg-ingress-rule" {
  type                     = "ingress"
  from_port                = 0
  to_port                  = 0
  protocol                 = "all"
  source_security_group_id = aws_security_group.load-balancer-sg.id
  security_group_id        = aws_security_group.ecs-sg.id
 
}
resource "aws_security_group_rule" "ecs-sg-egress-rule" {
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "all"
  cidr_blocks       = ["0.0.0.0/0"]
  ipv6_cidr_blocks  = ["::/0"]
  security_group_id = aws_security_group.ecs-sg.id
  
}

#Security group for RDS
resource "aws_security_group" "rds-sg" {
  name        = "${local.env}-rds-sg"
  description = "Allow all traffic"
  vpc_id      = aws_vpc.main.id
 
}

#Security group rules for RDS security group
resource "aws_security_group_rule" "rds-sg-ingress-rule" {
  security_group_id = aws_security_group.rds-sg.id
  type              = "ingress"
  from_port         = 0
  to_port           = 5432
  protocol          = "all"
  cidr_blocks       = ["0.0.0.0/0"]
  ipv6_cidr_blocks  = ["::/0"]
  

}

resource "aws_security_group_rule" "rds-sg-egress-rule" {
  security_group_id = aws_security_group.rds-sg.id
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "all"
  cidr_blocks       = ["0.0.0.0/0"]
  ipv6_cidr_blocks  = ["::/0"]
  
}

resource "aws_security_group_rule" "rds-sg-ingress-rule-1" {
  type                     = "ingress"
  from_port                = 0
  to_port                  = 0
  protocol                 = "all"
  source_security_group_id = aws_security_group.ecs-sg.id
  security_group_id        = aws_security_group.rds-sg.id
 
}

#Security group for bastion host
resource "aws_security_group" "bastion-host-sg" {
 
  name        = "${local.env}-bastion-host-sg"
  description = "Allow all traffic"
  vpc_id      = aws_vpc.main.id
}

#Security group rules for bastion host
resource "aws_security_group_rule" "bastion-host-ingress-rule" {
  
  security_group_id = aws_security_group.bastion-host-sg.id
  type              = "ingress"
  from_port         = 0
  to_port           = 0
  protocol          = "all"
  cidr_blocks       = ["0.0.0.0/0"]
  ipv6_cidr_blocks  = ["::/0"]
}
resource "aws_security_group_rule" "bastion-host-egress-rule" {
  
  security_group_id = aws_security_group.bastion-host-sg.id
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "all"
  cidr_blocks       = ["0.0.0.0/0"]
  ipv6_cidr_blocks  = ["::/0"]
}