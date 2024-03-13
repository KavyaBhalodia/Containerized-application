
# Security group for load balancer
resource "aws_security_group" "sg" {
  //provider = aws.sandbox
  name        = var.sg-name
  description = "Allow all traffic"
  vpc_id      = var.vpc-id
  
  dynamic "ingress" {
    
    for_each = var.ingress_rules
    content {
      
      from_port = ingress.value.from_port
      to_port = ingress.value.to_port
      protocol = "tcp"
      cidr_blocks = ingress.value.cidr_blocks
      ipv6_cidr_blocks = ingress.value.ipv6_cidr_blocks

    }
    
  }
  dynamic "egress" {
    for_each = var.egress_rules
    content {
      from_port = egress.value.from_port
      to_port = egress.value.to_port
      protocol = "all"
      cidr_blocks = ["0.0.0.0/0"]
      ipv6_cidr_blocks = ["::/0"]
    }
    
  }

}

# Security group for ECS tasks
# resource "aws_security_group" "ecs-sg" {
#   name        = var.ecs-sg-name
#   description = "Allow traffic from lb"
#   vpc_id      = var.vpc-id
#     dynamic "ingress" {
#     for_each = var.ingress
#     content {
#       from_port = ingress.value.from_port
#       to_port = ingress.value.to_port
#       protocol = "tcp"
#       cidr_blocks = [ "0.0.0.0/0" ]
#       ipv6_cidr_blocks = [ "::/0" ]
#     }
   
#   }
#   dynamic "egress" {
#     for_each = var.egress
#     content {
#       from_port = egress.value.from_port
#       to_port = egress.value.to_port
#       protocol = "tcp"
#       cidr_blocks = ["0.0.0.0/0"]
#       ipv6_cidr_blocks = ["::/0"]
    
#     }
#   }
#   # dynamic "ingress_sg" {
#   #   for_each = var.ingress_sg
#   #   content{
#   #     from_port=ingress_sg.value.from_port
#   #     to_port=ingress_sg.to_port
#   #     source_security_group_id=aws_security_group.alb-sg.id
#   #     security_group_id=aws_security_group.ecs-sg

#   #   }
 
#   # }

  
# }

# #Security group rules for ECS tasks
# # resource "aws_security_group_rule" "ecs-sg-ingress-rule" {
# #   type                     = "ingress"
# #   from_port                = var.ecs-sg-ingress-rule-from-port
# #   to_port                  = var.ecs-sg-ingress-rule-to-port
# #   protocol                 = "all"
# #   source_security_group_id = aws_security_group.alb-sg.id
# #   security_group_id        = aws_security_group.ecs-sg.id
# # }
# # resource "aws_security_group_rule" "ecs-sg-egress-rule" {
# #   type              = "egress"
# #   from_port         = var.ecs-sg-egress-rule-from-port
# #   to_port           = var.ecs-sg-egress-rule-to-port
# #   protocol          = "all"
# #   cidr_blocks       =["0.0.0.0/0"]
# #   ipv6_cidr_blocks  = ["::/0"]
# #   security_group_id = aws_security_group.ecs-sg.id
# # }

# #Security group for RDS
# resource "aws_security_group" "rds-sg" {
#   name        = var.rds-sg-name
#   description = "Allow all traffic"
#   vpc_id      = var.vpc-id
#   dynamic "ingress" {
#     for_each = var.ingress
#     content {
#       from_port = ingress.value.from_port
#       to_port = ingress.value.to_port
#       protocol = "tcp"
#       cidr_blocks = [ "0.0.0.0/0" ]
#       ipv6_cidr_blocks = [ "::/0" ]
    
#     }
#   }
#   dynamic "egress" {
#     for_each = var.egress
#     content {
#       from_port = egress.value.from_port
#       to_port = egress.value.to_port
#       protocol = "tcp"
#       cidr_blocks = ["0.0.0.0/0"]
#       ipv6_cidr_blocks = ["::/0"]
#     }
    
#   }
# #    dynamic "ingress_sg" {
# #     for_each = var.ingress_sg
# #     content{
# #       from_port=ingress_sg.value.from_port
# #       to_port=ingress_sg.to_port
# #       source_security_group_id=aws_security_group.ecs-sg.id
# #       security_group_id=aws_security_group.rds-sg.id
# #     }
 
# #   }
# }

# # #Security group rules for RDS security group
# # resource "aws_security_group_rule" "rds-sg-ingress-rule" {
# #   security_group_id = aws_security_group.rds-sg.id
# #   type              = "ingress"
# #   from_port         = var.rds-sg-ingress-rule-from-port
# #   to_port           = var.rds-sg-ingress-rule-to-port
# #   protocol          = "all"
# #   cidr_blocks       = ["0.0.0.0/0"]
# #   ipv6_cidr_blocks  = ["::/0"]
 

# # }

# # resource "aws_security_group_rule" "rds-sg-egress-rule" {
# #   security_group_id = aws_security_group.rds-sg.id
# #   type              = "egress"
# #   from_port         = var.rds-sg-egress-rule-from-port
# #   to_port           = var.rds-sg-egress-rule-to-port
# #   protocol          ="all"
# #   cidr_blocks       = ["0.0.0.0/0"]
# #   ipv6_cidr_blocks  = ["::/0"]
# # }

# # resource "aws_security_group_rule" "rds-sg-ingress-rule-1" {
# #   type                     = "ingress"
# #   from_port                = var.rds-sg-ingress-rule-from-port
# #   to_port                  = var.rds-sg-ingress-rule-to-port
# #   protocol                 = "all"
# #   source_security_group_id = aws_security_group.ecs-sg.id
# #   security_group_id        = aws_security_group.rds-sg.id
# # }

# #Security group for bastion host
# resource "aws_security_group" "bastion-host-sg" {
#   name        = var.bastion-host-sg-name
#   description = "Allow all traffic"
#   vpc_id      = var.vpc-id
#   dynamic "ingress" {
#     for_each = var.ingress
#     content {
#       from_port = ingress.value.from_port
#       to_port = ingress.value.to_port
#       protocol = "tcp"
#       cidr_blocks = [ "0.0.0.0/0" ]
#       ipv6_cidr_blocks = [ "::/0" ]
#     }
#   }
#   dynamic "egress" {
#     for_each = var.egress
#     content {
#       from_port = egress.value.from_port
#       to_port = egress.value.to_port
#       protocol = "tcp"
#       cidr_blocks = ["0.0.0.0/0"]
#       ipv6_cidr_blocks = ["::/0"]
#     }
    
#   }
# }

# # #Security group rules for bastion host
# # resource "aws_security_group_rule" "bastion-host-ingress-rule" {
# #   security_group_id = aws_security_group.bastion-host-sg.id
# #   type              = "ingress"
# #   from_port         = var.bastion-host-ingress-rule-from-port
# #   to_port           = var.bastion-host-ingress-rule-to-port
# #   protocol          = "all"
# #   cidr_blocks       = ["0.0.0.0/0"]
# #   ipv6_cidr_blocks  = ["::/0"]
# # }
# # resource "aws_security_group_rule" "bastion-host-egress-rule" {
# #   security_group_id = aws_security_group.bastion-host-sg.id
# #   type              = "egress"
# #   from_port         = var.bastion-host-egress-rule-from-port
# #   to_port           = var.bastion-host-egress-rule-to-port
# #   protocol          = "all"
# #   cidr_blocks       =["0.0.0.0/0"]
# #   ipv6_cidr_blocks  = ["::/0"]
# # }