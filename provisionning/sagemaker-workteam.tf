resource "aws_sagemaker_workforce" "test" {
  workforce_name = var.resources_name

  cognito_config {
    client_id = aws_cognito_user_pool_client.test.id
    user_pool = aws_cognito_user_pool_domain.test.user_pool_id
  }
}