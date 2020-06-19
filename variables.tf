variable "environment" {
  type = object({
    variables = map(string)
  })
  default = null
}

variable "description" {
  type    = string
  default = ""
}

variable "function_name" {
  type        = string
  description = "name of the lambda function"
  default     = "lambda_function"
}

variable "handler" {
  type    = string
  default = "lambda.lambda_handler"
}

variable "lambda_at_edge" {
  description = "Set this to true if using Lambda@Edge, to enable publishing, limit the timeout, and allow edgelambda.amazonaws.com to invoke the function"
  type        = bool
  default     = false
}

variable "memory_size" {
  type    = number
  default = 128
}

variable "policy" {
  description = "An additional policy to attach to the Lambda function role"
  type = object({
    json = string
  })
  default = null
}

variable "publish" {
  type    = bool
  default = false
}

variable "runtime" {
  type    = string
  default = "python3.8"
}

variable "source_dir" {
  type = string
}

variable "s3_bucket" {
  type = string
}

variable "s3_key_prefix" {
  type    = string
  default = "apps/"
}

variable "tags" {
  type    = map(string)
  default = null
}

variable "timeout" {
  type    = number
  default = 3
}