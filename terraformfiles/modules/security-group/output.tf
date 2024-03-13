# output "ecs-sg-id" {
#   value = [aws_security_group.ecs-sg.id]
# }
# output "bastion-host-sg" {
#   value = [aws_security_group.bastion-host-sg.id]
# }
# output "alb-sg" {
#   value = [aws_security_group.alb-sg.id]
# }
# output "rds-sg" {
#   value = [aws_security_group.rds-sg.id]
# }
output "sg-id" {
  value = aws_security_group.sg.id
}