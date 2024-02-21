//ecr repository
data "aws_caller_identity" "current" {}


resource "aws_ecr_repository" "containerized-application-repository" {
  name                 = "containerized-application-repository"
  image_tag_mutability = "IMMUTABLE"

  image_scanning_configuration {
    scan_on_push = true
  }
}
//$GIT_COMMIT_ID = git rev-parse --short HEAD
//aws ecr get-login-password --region ap-south-1 | docker login --username AWS --password-stdin ${data.aws_caller_identity.current.account_id}.dkr.ecr.ap-south-1.amazonaws.com
resource "null_resource" "docker_packaging" {
  provisioner "local-exec" {
    command     = <<EOT
    $GIT_COMMIT_ID = git rev-parse --short HEAD
    docker build -t containerized-application .
    aws ecr get-login-password --region ap-south-1 |  docker login --username AWS --password-stdin $(aws ecr get-login-password --region ap-south-1 ) ${data.aws_caller_identity.current.account_id}.dkr.ecr.ap-south-1.amazonaws.com 
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
  ]
}

