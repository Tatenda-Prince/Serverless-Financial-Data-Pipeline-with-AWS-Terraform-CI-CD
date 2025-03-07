resource "aws_iam_role" "lambda_role" {
  name = "lambda_invoice_processor_role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Action = "sts:AssumeRole"
      Effect = "Allow"
      Principal = {
        Service = "lambda.amazonaws.com"
      }
    }]
  })
}

resource "aws_iam_policy" "lambda_policy" {
  name        = "LambdaInvoiceProcessorPolicy"
  description = "Policy for Lambda to access S3, DynamoDB, and SNS"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      # S3 Permission: Read invoices from the raw bucket
      {
        Action   = ["s3:GetObject"]
        Effect   = "Allow"
        Resource = "arn:aws:s3:::tatenda-raw-invoice-bucket/*"
      },
      # DynamoDB Permissions: Put and Get items
      {
        Action   = ["dynamodb:PutItem", "dynamodb:GetItem", "dynamodb:Scan"]
        Effect   = "Allow"
        Resource = aws_dynamodb_table.invoices.arn
      },
      # SNS Permission: Publish failure alerts
      {
        Action   = ["sns:Publish"]
        Effect   = "Allow"
        Resource = aws_sns_topic.invoice_alerts.arn
      }
    ]
  })
}

# Attach AWS Managed Policy for CloudWatch Logs
resource "aws_iam_role_policy_attachment" "lambda_basic_execution" {
  role       = aws_iam_role.lambda_role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"
}

resource "aws_iam_role_policy_attachment" "lambda_policy_attach" {
  role       = aws_iam_role.lambda_role.name
  policy_arn = aws_iam_policy.lambda_policy.arn
}

resource "aws_lambda_function" "invoice_processor" {
  function_name    = "InvoiceProcessor"
  role            = aws_iam_role.lambda_role.arn
  handler         = "invoice_processor.lambda_handler"
  runtime         = "python3.9"
  filename        = "lambda_code/invoice_processor.zip"
  source_code_hash = filebase64sha256("lambda_code/invoice_processor.zip")

  environment {
    variables = {
      DYNAMODB_TABLE = aws_dynamodb_table.invoices.name
      SNS_TOPIC_ARN  = aws_sns_topic.invoice_alerts.arn
    }
  }

  depends_on = [
    aws_iam_role_policy_attachment.lambda_policy_attach,
    aws_iam_role_policy_attachment.lambda_basic_execution
  ]
}
