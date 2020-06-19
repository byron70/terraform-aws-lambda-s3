
data "archive_file" "zip" {
  type        = "zip"
  source_dir  = var.source_dir
  output_path = local.archive_path
}

resource "aws_s3_bucket_object" "archive" {
  bucket        = var.s3_bucket
  content_type  = "binary/octet-stream"
  etag          = data.archive_file.zip.output_md5
  key           = local.archive_key
  metadata      = {}
  source        = local.archive_path
  storage_class = "STANDARD"
  tags          = local.common_tags
}