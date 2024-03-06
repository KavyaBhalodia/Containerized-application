
#ECR repository 
resource "aws_ecr_repository" "containerized-application-repository" {
  name                 = "${local.env}-${var.ecr-repository}"
  image_tag_mutability = "MUTABLE"
  provider             = aws.sandbox
  image_scanning_configuration {
    scan_on_push = true
  }
}

#Data source for getting current account identity
data "aws_caller_identity" "current" {
  provider = aws.sandbox
}

#Null resource to push docker image
resource "null_resource" "docker_packaging" {
  provisioner "local-exec" {
    command     = <<EOT
    $GIT_COMMIT_ID = git rev-parse --short HEAD
    docker build -t containerized-application .
    aws ecr get-login-password --region ${var.region} |  docker login --username AWS --password-stdin ${data.aws_caller_identity.current.account_id}.dkr.ecr.us-west-2.amazonaws.com 
    docker tag containerized-application "${aws_ecr_repository.containerized-application-repository.repository_url}"
    docker push "${aws_ecr_repository.containerized-application-repository.repository_url}"
    docker tag containerized-application "${aws_ecr_repository.containerized-application-repository.repository_url}:$GIT_COMMIT_ID"
    docker push "${aws_ecr_repository.containerized-application-repository.repository_url}:$GIT_COMMIT_ID"   
    
  EOT
    interpreter = ["PowerShell", "-Command"]

  }

  triggers = {
    "run_at" = timestamp()
  }

  depends_on = [
    aws_ecr_repository.containerized-application-repository,
    # aws_db_instance.default
  ]
}


