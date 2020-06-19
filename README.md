# aws-lambda-s3

Terraform module to build an archive for AWS Lambda, push the archive to AWS S3 and publish the S3 archive to Lambda.

## Requirements

Terraform version 0.12.x or greater

## Usage

```js
locals {
  lambda_environment = {
    variables = {
      LOG_LEVEL = var.log_level
    }
  }
}

module "lambda" {
  source = "github.com/byron70/terraform-aws-lambda-s3"

  environment = local.lambda_environment
  function_name = "Hello_World"
  description = "Does something cool!"
  handler = "lambda.lambda_handler"
  memory_size = 128
  publish = true
  runtime = "python3.8"
  s3_bucket = "my_s3_repo"
  s3_key_prefix = "apps/"
  source_dir = format("%s/function/", path.module)
  timeout = 10
  tags = {
    "foo": "bar"
  }

  // additional policy
  policy = {
    json = data.aws_iam_policy_document.this.json
  }
}
```
