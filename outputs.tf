output "function_arn" {
  value       = aws_lambda_function.this.arn
}

output "function_invoke_arn" {
  value       = aws_lambda_function.this.invoke_arn
}

output "function_name" {
  value       = aws_lambda_function.this.function_name
}

output "function_qualified_arn" {
  value       = aws_lambda_function.this.qualified_arn
}

output "role_arn" {
  value       = local.lambda_role
}

output "role_name" {
  value       = local.lambda_role_name
}