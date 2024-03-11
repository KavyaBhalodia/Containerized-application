
#Application load balancer
resource "aws_lb" "containerized-application-alb" {
  name                       = var.alb-name
  internal                   = false
  load_balancer_type         = "application"
  security_groups            = var.alb-sg
  subnets                    = var.public-subnets
  enable_deletion_protection = false
  access_logs {
    bucket  = var.access-log-bucket
    prefix  = var.prefix
    enabled = true
  }
}

#Load balacer listener
resource "aws_lb_listener" "alb-listener" {
  load_balancer_arn = aws_lb.containerized-application-alb.arn
  port              = var.listener-port
  default_action {
    target_group_arn = aws_lb_target_group.containerized-application-tg.arn
    type             = "forward"
  }
}

#Targert group
resource "aws_lb_target_group" "containerized-application-tg" {
  name        = var.target-group-name
  port        = var.listener-port
  protocol    = "HTTP"
  vpc_id      = var.vpc-id
  target_type = "ip"
}







