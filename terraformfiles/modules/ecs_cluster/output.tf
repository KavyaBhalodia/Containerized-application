
output "ecs_cluster_id" {
  value = aws_ecs_cluster.containerized_app_ecs_cluster.id
}
output "ecs_cluster_name" {
  value = aws_ecs_cluster.containerized_app_ecs_cluster.name
}
