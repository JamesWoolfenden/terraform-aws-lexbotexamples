data "archive_file" "lambda" {
  type        = "zip"
  source_file = "${path.module}/code/lambda_function.py"
  output_path = "${path.module}/files/lambda.zip"
}