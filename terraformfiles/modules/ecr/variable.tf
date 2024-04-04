variable "ecr_repository" {
  type = string
  description = "Name of the ECR repository"
}
variable "region" {
  type = string
  description = "region specified for ECR push commands"
}