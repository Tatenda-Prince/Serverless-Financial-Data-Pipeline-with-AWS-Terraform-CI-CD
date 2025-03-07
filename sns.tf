resource "aws_sns_topic" "invoice_alerts" {
  name = "InvoiceProcessingAlerts"

  tags = {
    Name    = "Invoice Processing Alerts"
    Purpose = "Notifies on invoice processing failures"
  }
}

resource "aws_sns_topic_subscription" "email_subscription" {
  topic_arn = aws_sns_topic.invoice_alerts.arn
  protocol  = "email"
  endpoint  = "tatendapmoyo61@gmail.com" # Replace with your email
}

