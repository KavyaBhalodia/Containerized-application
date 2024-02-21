##############################################################################################################################
#                                                                                                                            #
#                                               Security groups                                                              #
#                                                                                                                            #
##############################################################################################################################

############################################## Security group for load balancer ##############################################

resource "aws_security_group" "load-balancer-sg" {
  name        = "load-balancer-sg"
  description = "Allow all traffic"
  vpc_id      = aws_vpc.main.id
}

############################### Security group rules for load balancer security group ##########################################

resource "aws_security_group_rule" "load-balancer-sg-rule" {
  type              = "ingress"
  from_port         = 0
  to_port           = 0
  protocol          = "all"
  cidr_blocks       = ["0.0.0.0/0"]
  ipv6_cidr_blocks  = ["::/0"]
  security_group_id = aws_security_group.load-balancer-sg.id
}
resource "aws_security_group_rule" "load-balancer-sg-rule-1" {
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "all"
  cidr_blocks       = ["0.0.0.0/0"]
  ipv6_cidr_blocks  = ["::/0"]
  security_group_id = aws_security_group.load-balancer-sg.id
}

######################################## Security group for ECS tasks ########################################################

resource "aws_security_group" "ecs-sg" {
  name        = "ecs-sg"
  description = "Allow traffic from lb"
  vpc_id      = aws_vpc.main.id
}

############################### Security group rules for load balancer ecs group ############################################

resource "aws_security_group_rule" "ecs-sg-rule" {
  type                     = "ingress"
  from_port                = 0
  to_port                  = 0
  protocol                 = "all"
  source_security_group_id = aws_security_group.load-balancer-sg.id
  security_group_id        = aws_security_group.ecs-sg.id
}
resource "aws_security_group_rule" "ecs-sg-rule-1" {
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "all"
  cidr_blocks       = ["0.0.0.0/0"]
  ipv6_cidr_blocks  = ["::/0"]
  security_group_id = aws_security_group.ecs-sg.id
}
