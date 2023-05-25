#resource "aws_sagemaker_workforce" "test" {
#  workforce_name = var.resources_name
#
#  cognito_config {
#    client_id = aws_cognito_user_pool_client.test.id
#    user_pool = aws_cognito_user_pool_domain.test.id
#  }
#}

resource "aws_cognito_user_pool_domain" "test" {
  domain       = aws_sagemaker_domain.test.domain_name
  user_pool_id = aws_cognito_user_pool.test.id
}
