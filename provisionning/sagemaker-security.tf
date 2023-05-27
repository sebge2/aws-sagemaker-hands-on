# Define the SageMaker "Assume Role" policy
data "aws_iam_policy_document" "sm_assume_role_policy" {
  statement {
    actions = ["sts:AssumeRole"]

    principals {
      type = "Service"
      identifiers = ["sagemaker.amazonaws.com"]
    }
  }
}

# Define the SageMaker notebook IAM role
resource "aws_iam_role" "sm_iam_role" {
  name = "${var.resources_name}-notebook"
  assume_role_policy = data.aws_iam_policy_document.sm_assume_role_policy.json

  tags = var.tags
}

# Attach the AWS default policy, "AmazonSageMakerFullAccess"
resource "aws_iam_policy_attachment" "sm_full_access_attach" {
  name = var.resources_name
  roles = [aws_iam_role.sm_iam_role.name]
  policy_arn = "arn:aws:iam::aws:policy/AmazonSageMakerFullAccess"
}

output "sm_iam_role" {
  value = aws_iam_role.sm_iam_role.arn
}