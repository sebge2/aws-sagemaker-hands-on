resource "aws_sagemaker_domain" "test" {
  domain_name = var.resources_name
  auth_mode   = "IAM"
  vpc_id      = aws_vpc.main.id
  subnet_ids  = [aws_subnet.subnet-public.id]

  default_user_settings {
    execution_role = aws_iam_role.sm_iam_role.arn
  }
}

output "domain_url" {
  value       = "${aws_sagemaker_domain.test.url}"
  description = "Domain URL"
}