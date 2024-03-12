variable "ecr-repository" {
    type = string
    description = "Name of the ECR repository"
}
variable "region" {
  type = string
  description = "Region where the ECR repository will be created"
}
