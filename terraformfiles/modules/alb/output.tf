output "prefix" {
  value = "${var.prefix}"
}
output "target-grp-arn" {
  value = aws_lb_target_group.containerized-application-tg.arn
}
output "alb-log-prefix" {
  value = var.prefix
}