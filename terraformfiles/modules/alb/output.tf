
output "target_grp_arn" {
  value = aws_lb_target_group.containerized_application_tg.arn
}
output "alb_logs_prefix" {
  value = aws_lb.containerized_application_alb.access_logs.prefix
}