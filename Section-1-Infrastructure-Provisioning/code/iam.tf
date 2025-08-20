# below is the creation of user and allowing access to read from the S3 buckets

resource "aws_iam_access_key" "terraform_user_key" {
  user = aws_iam_user.this.name
}

output "access_key_id" {
  value = aws_iam_access_key.terraform_user_key.id
}

output "secret_access_key" {
  value     = aws_iam_access_key.terraform_user_key.secret
  sensitive = true
}

resource "aws_iam_user" "this" {
  name = "terraform-user"
}

resource "aws_iam_group" "this" {
  name = "developers"
}

resource "aws_iam_group_membership" "this" {
  name  = "assign-user-to-group"
  group = aws_iam_group.this.name
  users = [aws_iam_user.this.name]
}

resource "aws_iam_group_policy" "user-s3-access" {
  group = aws_iam_group.this.name
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow",
        Action = "s3:ListAllMyBuckets",
        Resource = "*"
      },
      {
        Effect = "Allow"
        Action = [
          "s3:GetObject",
          "s3:GetObjectVersion",
          "s3:ListBucket"
        ]
        Resource = [
        aws_s3_bucket.application-logs.arn,
        "${aws_s3_bucket.application-logs.arn}/*",
        aws_s3_bucket.service-backups.arn,
        "${aws_s3_bucket.service-backups.arn}/*",
        aws_s3_bucket.application-data.arn,
        "${aws_s3_bucket.application-data.arn}/*"
        ]
      },
      {
        Effect   = "Allow"
        Action   = ["kms:Decrypt"]
        Resource = aws_kms_key.this.arn
      }
    ]
  })
}

# below is for EC2 instance to assume a role and access the S3 bucket

resource "aws_iam_instance_profile" "this" {
  name = "app-instance-profile"
  role = aws_iam_role.ec2-s3-access.name
}

resource "aws_iam_role" "ec2-s3-access" {
  name = "ec2-s3-access"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Sid    = ""
        Principal = {
          Service = "ec2.amazonaws.com"
        }
      },
    ]
  })
}

resource "aws_iam_role_policy" "ec2-s3-access" {
  name = "ec2-s3-access"
  role = aws_iam_role.ec2-s3-access.id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = [
          "s3:ListBucket",
          "s3:GetObject",
          "s3:PutObject",
          "s3:DeleteObject"
        ]
        Resource = [
          aws_s3_bucket.application-logs.arn,
          "${aws_s3_bucket.application-logs.arn}/*",
          aws_s3_bucket.service-backups.arn,
          "${aws_s3_bucket.service-backups.arn}/*",
          aws_s3_bucket.application-data.arn,
          "${aws_s3_bucket.application-data.arn}/*"
        ]
      },
      {
        Effect = "Allow"
        Action = [
          "kms:Decrypt",
          "kms:Encrypt",
          "kms:GenerateDataKey*"
        ]
        Resource = aws_kms_key.this.arn
      }
    ]
  })
}