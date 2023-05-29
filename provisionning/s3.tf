resource "aws_s3_bucket" "data" {
  bucket = "${data.aws_caller_identity.current.account_id}-${var.resources_name}-data"
  force_destroy = true

  tags = var.tags
}

resource "aws_s3_object" "regression" {
  for_each = fileset("examples/data/regression", "*")

  bucket = aws_s3_bucket.data.id
  key    = "data/regression/${each.value}"
  source = "examples/data/regression/${each.value}"
  etag   = filemd5("examples/data/regression/${each.value}")
}

resource "aws_s3_object" "military_planes_labelling" {
  for_each = fileset("examples/data/labelling/military_planes", "*")

  bucket = aws_s3_bucket.data.id
  key    = "data/labelling/military_planes/${each.value}"
  source = "examples/data/labelling/military_planes/${each.value}"
  etag   = filemd5("examples/data/labelling/military_planes/${each.value}")
}

resource "aws_s3_object" "military_planes_examples" {
  for_each = fileset("examples/data/examples/military_planes", "*")

  bucket = aws_s3_bucket.data.id
  key    = "data/examples/military_planes/${each.value}"
  source = "examples/data/examples/military_planes/${each.value}"
  etag   = filemd5("examples/data/examples/military_planes/${each.value}")
}