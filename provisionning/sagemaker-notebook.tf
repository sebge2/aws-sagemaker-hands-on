resource "aws_sagemaker_notebook_instance" "test" {
  name                = var.resources_name
  role_arn            = aws_iam_role.sm_iam_role.arn
  instance_type       = var.ec2_instance_type
  platform_identifier = var.notebook_platform

  tags = var.tags
}

output "notebook_instance_url" {
  value       = "https://${aws_sagemaker_notebook_instance.test.url}"
  description = "Notebook Instance URL"
}