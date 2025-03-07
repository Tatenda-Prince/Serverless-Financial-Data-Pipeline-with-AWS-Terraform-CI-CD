output "s3_bucket_name" {
  description = "The name of the S3 bucket used for raw invoice storage"
  value       = "tatenda-raw-invoice-bucket"
}

output "dynamodb_table_name" {
  description = "The name of the DynamoDB table for storing invoice data"
  value       = aws_dynamodb_table.invoices.id
}

output "sns_topic_arn" {
  description = "The ARN of the SNS topic for invoice processing alerts"
  value       = aws_sns_topic.invoice_alerts.arn
}

output "lambda_function_arn" {
  description = "The ARN of the Invoice Processor Lambda function"
  value       = aws_lambda_function.invoice_processor.arn
}

output "api_gateway_invoke_url" {
  description = "The Invoke URL for the API Gateway endpoint"
  value       = aws_api_gateway_stage.prod.invoke_url
}

