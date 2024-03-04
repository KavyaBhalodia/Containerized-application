
#Application load balancer
resource "aws_lb" "conainerized-application-alb" {
  name                       = "conainerized-application-alb"
  internal                   = false
  load_balancer_type         = "application"
  security_groups            = [aws_security_group.load-balancer-sg.id]
  subnets                    = aws_subnet.public-subnet.*.id
  enable_deletion_protection = false
  access_logs {
    bucket  = aws_s3_bucket.containerized-application-alb-logs.id
    prefix  = "conainerized-application-alb"
    enabled = true
  }
  provider = aws.sandbox


}

#Load balacer listener
resource "aws_lb_listener" "example" {
  load_balancer_arn = aws_lb.conainerized-application-alb.arn
  port              = 80
  provider          = aws.sandbox
  default_action {
    target_group_arn = aws_lb_target_group.conainerized-application-tg.arn
    type             = "forward"
  }
}

#Targert group
resource "aws_lb_target_group" "conainerized-application-tg" {
  name        = "conainerized-application-tg"
  port        = 80
  protocol    = "HTTP"
  vpc_id      = aws_vpc.main.id
  target_type = "ip"
  provider    = aws.sandbox
}







