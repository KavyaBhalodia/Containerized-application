resource "aws_lb" "ecs-alb" {
  name               = "ecs-alb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.load-balancer-sg.id]
  subnets = aws_subnet.public-subnet.*.id
  enable_deletion_protection = true

  tags = {
    Environment = "production"
  }
}
//target-grp
resource "aws_lb_target_group" "ecs-target-grp" {
  name        = "ecs-target-grp"
  port        = 80
  protocol    = "HTTP"
  vpc_id      = aws_vpc.main.id
  target_type = "ip"
}
