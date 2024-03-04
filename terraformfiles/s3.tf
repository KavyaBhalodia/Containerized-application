resource "aws_s3_bucket" "containerized-application-alb-logs" {
  provider = aws.sandbox
  bucket   = "containerized-application-alb-logs"

  tags = {
    Name = "containerized-application-alb-logs"
  }
}


resource "aws_s3_bucket_policy" "s3-bucket-policy" {
  bucket = aws_s3_bucket.containerized-application-alb-logs.id
  policy = data.aws_iam_policy_document.s3-bucket-policy.json
}

data "aws_iam_policy_document" "s3-bucket-policy" {
  
    version= "2012-10-17"
    statement{
            effect = "Allow"
            principals {
              type = "AWS"
                identifiers =  ["arn:aws:iam::797873946194:root"]
            }
            actions=[ "s3:PutObject"]
            resources= ["arn:aws:s3:::containerized-application-alb-logs/alb-logs/AWSLogs/843728461002/*"]
        }
    
}
