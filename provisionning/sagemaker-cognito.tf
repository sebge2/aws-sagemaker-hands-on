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

  explicit_auth_flows                  = ["ALLOW_REFRESH_TOKEN_AUTH", "ALLOW_USER_PASSWORD_AUTH", "ALLOW_CUSTOM_AUTH", "ALLOW_USER_SRP_AUTH"]
  allowed_oauth_flows_user_pool_client = true
  supported_identity_providers         = ["COGNITO"]

  allowed_oauth_flows = ["code", "implicit"]
  allowed_oauth_scopes = ["email", "openid", "profile"]
  id_token_validity = 1 # TODO check if necessary
  callback_urls = [ "https://${aws_cognito_user_pool_domain.test.cloudfront_distribution_arn}"]
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