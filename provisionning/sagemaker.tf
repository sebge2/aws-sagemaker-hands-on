resource "aws_sagemaker_notebook_instance" "test" {
  name                = "my-notebook-instance"
  role_arn            = aws_iam_role.notebook_iam_role.arn
  instance_type       = var.ec2_instance_type
  platform_identifier = var.notebook_platform

  tags = var.tags
}

output "notebook_instance_url" {
  value       = "${aws_sagemaker_notebook_instance.test.url}"
  description = "Notebook Instance URL"
}