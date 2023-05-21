resource "aws_s3_bucket" "data" {
  bucket = "${data.aws_caller_identity.current.account_id}-${var.resources_name}-data"

  tags = var.tags
}

resource "aws_s3_object" "object" {
  bucket = aws_s3_bucket.data.id
  key    = "regression/Celsius_to_Fahrenheit.csv"
  source = "examples/data/regression/Celsius_to_Fahrenheit.csv"

  etag = filemd5("examples/data/regression/Celsius_to_Fahrenheit.csv")
}