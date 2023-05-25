resource "aws_sagemaker_workforce" "test" {
  workforce_name = var.resources_name

  cognito_config {
    client_id = aws_cognito_user_pool_client.test.id
    user_pool = aws_cognito_user_pool_domain.test.user_pool_id
  }
}

resource "aws_sagemaker_workteam" "test" {
  workteam_name  = var.resources_name
  workforce_name = aws_sagemaker_workforce.test.id
  description = var.resources_name
  tags = var.tags

  member_definition {
    cognito_member_definition {
      client_id  = aws_cognito_user_pool_client.test.id
      user_pool  = aws_cognito_user_pool_domain.test.user_pool_id
      user_group = aws_cognito_user_group.test.id
    }
  }
}