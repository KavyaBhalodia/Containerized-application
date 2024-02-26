##############################################################################################################################
#                                                                                                                            #
#                                               ECR repository                                                               #
#                                                                                                                            #
##############################################################################################################################

########################################## Get current aws account identity ##################################################

//data "aws_caller_identity" "current" {}

################################################## ECR repository ############################################################

resource "aws_ecr_repository" "containerized-application-repository" {
  name                 = "containerized-application-repository"
  image_tag_mutability = "MUTABLE"
  provider             = aws.sandbox
  image_scanning_configuration {
    scan_on_push = true
  }
}
data "aws_caller_identity" "current" {
  provider = aws.sandbox
}
############################################## Null resource to push docker image ############################################
//aws ecr get-login-password --region us-west-2 |  docker login --username AWS --password-stdin $(aws ecr get-login-password --region us-west-2 ) ${data.aws_caller_identity.current.account_id}.dkr.ecr.us-west-2.amazonaws.com 
resource "null_resource" "docker_packaging" {
  provisioner "local-exec" {
    command     = <<EOT
    $GIT_COMMIT_ID = git rev-parse --short HEAD
    docker build -t containerized-application .
    aws ecr get-login-password --region us-west-2 | docker login --username AWS --password-stdin 843728461002.dkr.ecr.us-west-2.amazonaws.com
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
    aws_db_instance.default
  ]
}

