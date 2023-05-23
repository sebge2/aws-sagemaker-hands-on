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




