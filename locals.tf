locals {
  account_id = data.aws_caller_identity.current.account_id

  iam_region = {
    "us-east-1" : 1
    "us-east-2" : 0
    "us-west-2" : 0
  }

  archive_path = format("%s/build/dist.zip", path.module)
  archive_key  = format("%s%s/%s.zip", var.s3_key_prefix, var.function_name, data.archive_file.zip.output_md5)

  common_tags = merge(var.tags, {})

  global_count = lookup(local.iam_region, local.region)

  lambda_role               = format("arn:aws:iam::%s:role/%s", local.account_id, local.lambda_role_name)
  lambda_role_name          = format("lambda-%s", var.function_name)
  lambda_log_group_arn      = format("arn:%s:logs:%s:%s:log-group:/aws/lambda/%s", local.partition, local.region, local.account_id, var.function_name)
  lambda_edge_log_group_arn = format("arn:%s:logs:%s:%s:log-group:/aws/lambda/%s.%s", local.partition, local.region, local.account_id, local.region, var.function_name)
  log_group_arns            = slice(list(local.lambda_log_group_arn, local.lambda_edge_log_group_arn), 0, var.lambda_at_edge ? 2 : 1)

  partition = data.aws_partition.current.partition
  region    = data.aws_region.current.name
}