output "ecs-cluster-name" {
  value = aws_ecs_cluster.containerized-application-ecs-cluster.name
}
output "ecs-cluster-id" {
  value = aws_ecs_cluster.containerized-application-ecs-cluster.id
}