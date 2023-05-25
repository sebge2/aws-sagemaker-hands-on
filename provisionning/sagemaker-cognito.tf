resource "aws_cognito_user_pool" "test" {
  name                     = var.resources_name
  auto_verified_attributes = ["email"]

  tags = var.tags
}

resource "aws_cognito_user" "john_doe" {
  user_pool_id = aws_cognito_user_pool.test.id
  username     = "john.doe"
  password     = "T€st-123456"

  attributes = {
    email          = "john.doe@acme.com"
    email_verified = true
  }
}

resource "aws_cognito_user" "jane_doe" {
  user_pool_id = aws_cognito_user_pool.test.id
  username     = "jane.doe"
  password     = "T€st-123456"

  attributes = {
    email          = "jane.doe@acme.com"
    email_verified = true
  }
}

resource "aws_cognito_user_pool_client" "test" {
  name            = var.resources_name
  generate_secret = true
  user_pool_id    = aws_cognito_user_pool.test.id
}

resource "aws_cognito_user_group" "test" {
  user_pool_id = aws_cognito_user_pool.test.id
  name         = var.resources_name
}

resource "aws_cognito_user_in_group" "john_doe_membership" {
  user_pool_id = aws_cognito_user_pool.test.id
  group_name   = aws_cognito_user_group.test.name
  username     = aws_cognito_user.john_doe.username
}

resource "aws_cognito_user_in_group" "jane_doe_membership" {
  user_pool_id = aws_cognito_user_pool.test.id
  group_name   = aws_cognito_user_group.test.name
  username     = aws_cognito_user.jane_doe.username
}

resource "aws_cognito_user_pool_domain" "test" {
  domain       = aws_sagemaker_domain.test.domain_name
  user_pool_id = aws_cognito_user_pool.test.id
}