
# #Security group for load balancer
# resource "aws_security_group" "load-balancer-sg" {
#   name        = "${local.env}-load-balancer-sg"
#   description = "Allow all traffic"
#   vpc_id      = aws_vpc.main.id
#   provider    = aws.sandbox
# }

# #Security group rules for load balancer security group
# resource "aws_security_group_rule" "load-balancer-sg-rule" {
#   type              = "ingress"
#   from_port         = 0
#   to_port           = 0
#   protocol          = "all"
#   cidr_blocks       = ["0.0.0.0/0"]
#   ipv6_cidr_blocks  = ["::/0"]
#   security_group_id = aws_security_group.load-balancer-sg.id
#   provider          = aws.sandbox
# }
# resource "aws_security_group_rule" "load-balancer-sg-rule-1" {
#   type              = "egress"
#   from_port         = 0
#   to_port           = 0
#   protocol          = "all"
#   cidr_blocks       = ["0.0.0.0/0"]
#   ipv6_cidr_blocks  = ["::/0"]
#   security_group_id = aws_security_group.load-balancer-sg.id
#   provider          = aws.sandbox
# }

# #Security group for ECS tasks
# resource "aws_security_group" "ecs-sg" {
#   name        = "${local.env}-ecs-sg"
#   description = "Allow traffic from lb"
#   vpc_id      = aws_vpc.main.id
#   provider    = aws.sandbox
# }

# #Security group rules for ECS tasks
# resource "aws_security_group_rule" "ecs-sg-rule" {
#   provider                 = aws.sandbox
#   type                     = "ingress"
#   from_port                = 0
#   to_port                  = 0
#   protocol                 = "all"
#   source_security_group_id = aws_security_group.load-balancer-sg.id
#   security_group_id        = aws_security_group.ecs-sg.id
# }
# resource "aws_security_group_rule" "ecs-sg-rule-1" {
#   provider          = aws.sandbox
#   type              = "egress"
#   from_port         = 0
#   to_port           = 0
#   protocol          = "all"
#   cidr_blocks       = ["0.0.0.0/0"]
#   ipv6_cidr_blocks  = ["::/0"]
#   security_group_id = aws_security_group.ecs-sg.id
# }

# #Security group for RDS
# resource "aws_security_group" "rds-sg" {
#   name        = "${local.env}-rds-sg"
#   description = "Allow all traffic"
#   vpc_id      = aws_vpc.main.id
#   provider    = aws.sandbox
# }

# #Security group rules for RDS security group
# resource "aws_security_group_rule" "rds-sg-rule-1" {
#   security_group_id = aws_security_group.rds-sg.id
#   provider          = aws.sandbox
#   type              = "ingress"
#   from_port         = 0
#   to_port           = 5432
#   protocol          = "all"
#   cidr_blocks       = ["0.0.0.0/0"]
#   ipv6_cidr_blocks  = ["::/0"]

# }

# resource "aws_security_group_rule" "rds-sg-rule-2" {
#   security_group_id = aws_security_group.rds-sg.id
#   provider          = aws.sandbox
#   type              = "egress"
#   from_port         = 0
#   to_port           = 0
#   protocol          = "all"
#   cidr_blocks       = ["0.0.0.0/0"]
#   ipv6_cidr_blocks  = ["::/0"]

# }

# resource "aws_security_group_rule" "rds-sg-rule-3" {
#   provider                 = aws.sandbox
#   type                     = "ingress"
#   from_port                = 0
#   to_port                  = 0
#   protocol                 = "all"
#   source_security_group_id = aws_security_group.ecs-sg.id
#   security_group_id        = aws_security_group.rds-sg.id
# }

# #Security group for bastion host
# resource "aws_security_group" "bastion-host-sg" {
#   name        = "${local.env}-bastion-host-sg"
#   description = "Allow all traffic"
#   vpc_id      = aws_vpc.main.id
#   provider    = aws.sandbox
# }

# #Security group rules for bastion host
# resource "aws_security_group_rule" "bastion-host-rule-1" {
#   security_group_id = aws_security_group.bastion-host-sg.id
#   provider          = aws.sandbox
#   type              = "ingress"
#   from_port         = 0
#   to_port           = 0
#   protocol          = "all"
#   cidr_blocks       = ["0.0.0.0/0"]
#   ipv6_cidr_blocks  = ["::/0"]

# }
# resource "aws_security_group_rule" "bastion-host-rule-2" {
#   security_group_id = aws_security_group.bastion-host-sg.id
#   provider          = aws.sandbox
#   type              = "egress"
#   from_port         = 0
#   to_port           = 0
#   protocol          = "all"
#   cidr_blocks       = ["0.0.0.0/0"]
#   ipv6_cidr_blocks  = ["::/0"]
# }
module "security-group" {
    source = "./modules/security-group"
    vpc-id = "${module.vpc.vpc-id}"
    alb-sg-name="containerized-app-alb-sg"
    alb-ingress-rule-protocol="all"
    alb-ingress-rule-cidr=["0.0.0.0/0"]
    alb-ingress-rule-ipv6-cidr=["::/0"]
    alb-ingress-rule-from-port=0
    alb-ingress-rule-to-port=0
    alb-egress-rule-protocol="all"
    alb-egress-rule-cidr=["0.0.0.0/0"]
    alb-egress-rule-ipv6-cidr=["::/0"]
    alb-egress-rule-from-port=0
    alb-egress-rule-to-port=0
    ecs-sg-name="containerized-app-ecs-sg"
    ecs-sg-ingress-rule-from-port=0
    ecs-sg-ingress-rule-to-port=0
    ecs-sg-ingress-rule-protocol="all"
    ecs-sg-egress-rule-from-port=0
    ecs-sg-egress-rule-to-port=0
    ecs-sg-egress-rule-protocol="all"
    ecs-sg-egress-rule-cidr=["0.0.0.0/0"]
    ecs-sg-egress-rule-ipv6-cidr=["::/0"]
    rds-sg-name="containerized-app-rds-sg"
    rds-sg-ingress-rule-from-port=0
    rds-sg-ingress-rule-to-port=0
    rds-sg-ingress-rule-protocol="all"
    rds-sg-ingress-rule-cidr=["0.0.0.0/0"]
    rds-sg-ingress-rule-ipv6-cidr=["::/0"]
    rds-sg-egress-rule-from-port=0
    rds-sg-egress-rule-to-port=0
    rds-sg-egress-rule-protocol="all"
    rds-sg-egress-rule-cidr=["0.0.0.0/0"]
    rds-sg-egress-rule-ipv6-cidr=["::/0"]
    bastion-host-sg-name="containerized-app--bastion-host-sg"
    bastion-host-ingress-rule-from-port=0
    bastion-host-ingress-rule-to-port=0
    bastion-host-ingress-rule-protocol="all"
    bastion-host-ingress-cidr=["0.0.0.0/0"]
    bastion-host-ingress-ipv6-cidr=["::/0"]
    bastion-host-egress-rule-from-port=0
    bastion-host-egress-rule-to-port=0
    bastion-host-egress-rule-protocol="all"
    bastion-host-egress-cidr=["0.0.0.0/0"]
    bastion-host-egress-ipv6-cidr=["::/0"]
  providers = {
    aws = aws.sandbox
  }
}