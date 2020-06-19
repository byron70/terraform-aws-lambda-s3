# See this as an example: https://github.com/claranet/terraform-aws-lambda/

resource "aws_lambda_function" "this" {
  description      = var.description
  function_name    = var.function_name
  memory_size      = var.memory_size
  publish          = var.publish
  s3_bucket        = aws_s3_bucket_object.archive.bucket
  s3_key           = aws_s3_bucket_object.archive.key
  source_code_hash = data.archive_file.zip.output_base64sha256
  role             = local.lambda_role
  handler          = var.handler
  runtime          = var.runtime
  tags             = local.common_tags
  timeout          = var.timeout

  depends_on = [
    aws_cloudwatch_log_group.group
  ]

  lifecycle {
    ignore_changes = [last_modified]
  }

  dynamic "environment" {
    for_each = var.environment == null ? [] : [var.environment]
    content {
      variables = environment.value.variables
    }
  }
}

resource "aws_cloudwatch_log_group" "group" {
  name              = "/aws/lambda/${var.function_name}"
  retention_in_days = 60
  tags              = local.common_tags
}