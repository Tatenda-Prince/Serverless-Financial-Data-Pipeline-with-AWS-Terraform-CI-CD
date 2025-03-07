resource "aws_s3_bucket" "raw_invoice_bucket" {
  bucket = "tatenda-raw-invoice-bucket"
  tags = {
    Name = "Raw Invoice Bucket"
    Purpose = "Stores unprocessed invoices"
  }
}

resource "aws_s3_bucket" "processed_data_bucket" {
  bucket = "tatenda-processed-invoice-bucket" 

  tags = {
    Name = "Processed Data Bucket"
    Purpose = "Stores processed invoices"
  }
}

resource "aws_s3_bucket_notification" "s3_lambda_trigger" {
  bucket = aws_s3_bucket.raw_invoice_bucket.id  # Fixed reference

  lambda_function {
    lambda_function_arn = aws_lambda_function.invoice_processor.arn
    events              = ["s3:ObjectCreated:*"]
  }

  depends_on = [aws_lambda_permission.allow_s3]
}

resource "aws_lambda_permission" "allow_s3" {
  statement_id  = "AllowExecutionFromS3"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.invoice_processor.function_name
  principal     = "s3.amazonaws.com"
  source_arn    = aws_s3_bucket.raw_invoice_bucket.arn  # Fixed reference
}
