
#Application load balancer
resource "aws_lb" "containerized-app-alb" {
  name                       = "${local.env}-containerized-app-alb"
  internal                   = false
  load_balancer_type         = "application"
  security_groups            = [aws_security_group.load-balancer-sg.id]
  subnets                    = aws_subnet.public-subnet.*.id
  enable_deletion_protection = false
  access_logs {
    bucket  = aws_s3_bucket.containerized-app-alb-logs.id
    prefix  = "alblogs"
    enabled = true
  }

}

#Load balacer listener
resource "aws_lb_listener" "containerized-app-listener" {
  load_balancer_arn = aws_lb.containerized-app-alb.arn
  port              = 80
  default_action {
    target_group_arn = aws_lb_target_group.containerized-app-tg.arn
    type             = "forward"
  }

}

#Targert group
resource "aws_lb_target_group" "containerized-app-tg" {
  name        = "${local.env}-containerized-app-tg"
  port        = 80
  protocol    = "HTTP"
  vpc_id      = aws_vpc.main.id
  target_type = "ip"

}







