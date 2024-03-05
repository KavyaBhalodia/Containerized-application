
# #Security group for load balancer
# resource "aws_security_group" "load-balancer-sg" {
#   name        = "load-balancer-sg"
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
#   name        = "ecs-sg"
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
#   name        = "rds-sg"
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
#   name        = "bastion-host-sg"
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