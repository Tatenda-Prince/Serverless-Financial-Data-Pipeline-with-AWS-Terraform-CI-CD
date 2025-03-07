resource "aws_dynamodb_table" "invoices" {
  name         = "Invoices"
  billing_mode = "PAY_PER_REQUEST"

  attribute {
    name = "InvoiceID"
    type = "S" # String type
  }

  attribute {
    name = "Timestamp"
    type = "S" # String type (ISO 8601 format: YYYY-MM-DDTHH:MM:SSZ)
  }

  hash_key  = "InvoiceID"
  range_key = "Timestamp" # Sort key (optional, but useful for querying)

  tags = {
    Name    = "Invoices Table"
    Purpose = "Stores processed invoice data"
  }
}

