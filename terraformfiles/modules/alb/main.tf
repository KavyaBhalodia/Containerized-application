
#Application load balancer
resource "aws_lb" "containerized_application_alb" {
  name                       = var.alb_name
  internal                   = false
  load_balancer_type         = "application"
  security_groups            = var.alb_sg
  subnets                    = var.public_subnets
  enable_deletion_protection = false
  access_logs {
    bucket  = var.access_log_bucket
    prefix  = var.alb_logs_prefix
    enabled = true
  }
}

#Load balacer listener
resource "aws_lb_listener" "alb_listener" {
  load_balancer_arn = aws_lb.containerized_application_alb.arn
  port              = var.listener_port
  default_action {
    target_group_arn = aws_lb_target_group.containerized_application_tg.arn
    type             = "forward"
  }
}

#Targert group
resource "aws_lb_target_group" "containerized_application_tg" {
  name        = var.target_group_name
  port        = var.listener_port
  protocol    = "HTTP"
  vpc_id      = var.vpc_id
  target_type = "ip"
}







