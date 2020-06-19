
data "aws_iam_policy_document" "assume" {
  statement {
    sid    = ""
    effect = "Allow"
    principals {
      identifiers = ["lambda.amazonaws.com"]
      type        = "Service"
    }
    actions = ["sts:AssumeRole"]
  }
}

data "aws_iam_policy_document" "logs" {
  count = local.global_count

  statement {
    effect = "Allow"

    actions = [
      "logs:CreateLogGroup",
    ]

    resources = [
      "*",
    ]
  }

  statement {
    effect = "Allow"

    actions = [
      "logs:CreateLogStream",
      "logs:PutLogEvents",
    ]

    resources = concat(formatlist("%v:*", local.log_group_arns), formatlist("%v:*:*", local.log_group_arns))
  }
}

resource "aws_iam_role" "lambda" {
  count              = local.global_count
  name               = format("lambda-%s", var.function_name)
  assume_role_policy = data.aws_iam_policy_document.assume.json
  tags               = local.common_tags
}

resource "aws_iam_policy" "logs" {
  count = local.global_count

  name   = "${var.function_name}-logs"
  policy = data.aws_iam_policy_document.logs[0].json
}

resource "aws_iam_policy_attachment" "logs" {
  count      = local.global_count
  name       = "${var.function_name}-logs"
  roles      = [local.lambda_role_name]
  policy_arn = aws_iam_policy.logs[0].arn
}


# Attach an additional policy if provided.
resource "aws_iam_policy" "additional" {
  count = var.policy == null ? 0 : local.global_count

  name   = var.function_name
  policy = var.policy.json
}

resource "aws_iam_policy_attachment" "additional" {
  count = var.policy == null ? 0 : local.global_count

  name       = var.function_name
  roles      = [local.lambda_role_name]
  policy_arn = aws_iam_policy.additional[0].arn
}