//ecr repository
developer
data "aws_caller_identity" "current" {}
 main
resource "aws_ecr_repository" "images" {
  name                 = "images"
  image_tag_mutability = "IMMUTABLE"

  image_scanning_configuration {
    scan_on_push = true
  }
}
developer
resource "null_resource" "docker_packaging" {

provisioner "local-exec" {
	command = "bash script.sh ${aws_ecr_repository.images.repository_url}"
}
	
	  triggers = {
	    "run_at" = timestamp()
	  }

  depends_on = [
    aws_ecr_repository.images,
  ]
}


data "aws_iam_policy_document" "ecr-policy" {
  statement {
    sid    = "new policy"
    effect = "Allow"

    principals {
      type        = "AWS"
      identifiers = ["123456789012"]
    }

    actions = [
      "ecr:GetDownloadUrlForLayer",
      "ecr:PutImage",
      "ecr:DescribeRepositories",
      "ecr:GetRepositoryPolicy",
      "ecr:ListImages",
      "ecr:DeleteRepository",
      "ecr:BatchDeleteImage",
      "ecr:SetRepositoryPolicy",
      "ecr:DeleteRepositoryPolicy",
    ]
  }
}

resource "aws_ecr_repository_policy" "ecr-registry-policy" {
  repository = aws_ecr_repository.images.name
  policy     = data.aws_iam_policy_document.ecr-policy.json
}
 main
