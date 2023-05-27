# Define the S3 "Assume Role" policy for sagemaker service
data "aws_iam_policy_document" "s3_assume_role_policy" {
  statement {
    actions = ["sts:AssumeRole"]

    principals {
      type = "Service"
      identifiers = ["sagemaker.amazonaws.com"]
    }
  }
}

# Define the S3 IAM role
resource "aws_iam_role" "s3_iam_role" {
  name = "${var.resources_name}-s3"
  assume_role_policy = data.aws_iam_policy_document.sm_assume_role_policy.json

  tags = var.tags
}

# Define the bucket access policy
resource "aws_iam_policy" "bucket_policy" {
  name = "${var.resources_name}-s3"
  path        = "/"
  description = "Allow "

  policy = jsonencode({
    "Version" : "2012-10-17",
    "Statement" : [
      {
        "Effect" : "Allow",
        "Action": [
          "s3:*"
        ],
        "Resource" : [
          aws_s3_bucket.data.arn
        ]
      },
      {
        "Effect" : "Allow",
        "Action" : [
          "s3:*"
        ],
        "Resource" : [
          "${aws_s3_bucket.data.arn}/*"
        ]
      }
    ]
  })
}

# Attach the S3 policy to the S3 role
resource "aws_iam_policy_attachment" "s3_full_access_attach" {
  name = var.resources_name
  roles = [aws_iam_role.s3_iam_role.name]
  policy_arn = aws_iam_policy.bucket_policy.arn
}

output "s3_iam_role" {
  value = aws_iam_role.s3_iam_role.arn
}