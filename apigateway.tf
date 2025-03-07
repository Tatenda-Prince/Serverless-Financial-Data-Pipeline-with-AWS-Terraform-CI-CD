
resource "aws_lambda_function" "query_invoice" {
  function_name    = "QueryInvoice"
  role            = aws_iam_role.lambda_role.arn
  handler         = "query_invoice.lambda_handler"
  runtime         = "python3.9"
  filename        = "lambda_code/query_invoice.zip"
  source_code_hash = filebase64sha256("lambda_code/query_invoice.zip")

  environment {
    variables = {
      DYNAMODB_TABLE = aws_dynamodb_table.invoices.name
    }
  }

  depends_on = [aws_iam_role_policy_attachment.lambda_policy_attach]
}

resource "aws_api_gateway_rest_api" "invoice_api" {
  name        = "InvoiceAPI"
  description = "API to query invoices from DynamoDB"
}

resource "aws_api_gateway_resource" "invoice_resource" {
  rest_api_id = aws_api_gateway_rest_api.invoice_api.id
  parent_id   = aws_api_gateway_rest_api.invoice_api.root_resource_id
  path_part   = "invoice"
}

resource "aws_api_gateway_method" "get_invoice" {
  rest_api_id   = aws_api_gateway_rest_api.invoice_api.id
  resource_id   = aws_api_gateway_resource.invoice_resource.id
  http_method   = "GET"
  authorization = "NONE"
}

resource "aws_api_gateway_integration" "lambda_integration" {
  rest_api_id = aws_api_gateway_rest_api.invoice_api.id
  resource_id = aws_api_gateway_resource.invoice_resource.id
  http_method = aws_api_gateway_method.get_invoice.http_method

  integration_http_method = "POST"
  type                    = "AWS_PROXY"
  uri                     = aws_lambda_function.query_invoice.invoke_arn
}

resource "aws_lambda_permission" "api_gateway_permission" {
  statement_id  = "AllowAPIGatewayInvoke"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.query_invoice.function_name
  principal     = "apigateway.amazonaws.com"

  source_arn = "${aws_api_gateway_rest_api.invoice_api.execution_arn}/*/*"
}

resource "aws_api_gateway_deployment" "invoice_api_deployment" {
  depends_on = [aws_api_gateway_integration.lambda_integration]

  rest_api_id = aws_api_gateway_rest_api.invoice_api.id
}

resource "aws_api_gateway_stage" "prod" {
  stage_name    = "prod"
  rest_api_id   = aws_api_gateway_rest_api.invoice_api.id
  deployment_id = aws_api_gateway_deployment.invoice_api_deployment.id
}

