import json
import boto3
import os

# Initialize DynamoDB client
dynamodb = boto3.resource('dynamodb')

# Environment variable for table name
DYNAMODB_TABLE = os.getenv('DYNAMODB_TABLE')

def lambda_handler(event, context):
    try:
        # Extract parameters from API Gateway query string
        query_params = event.get("queryStringParameters", {})
        invoice_id = query_params.get("InvoiceID")
        timestamp = query_params.get("Timestamp")  # Ensure client sends Timestamp

        if not invoice_id or not timestamp:
            return {
                "statusCode": 400,
                "body": json.dumps({"error": "InvoiceID and Timestamp are required"})
            }

        # Fetch item from DynamoDB
        table = dynamodb.Table(DYNAMODB_TABLE)
        response = table.get_item(Key={"InvoiceID": invoice_id, "Timestamp": timestamp})

        # Check if the item exists
        if "Item" not in response:
            return {
                "statusCode": 404,
                "body": json.dumps({"error": "Invoice not found"})
            }

        return {
            "statusCode": 200,
            "body": json.dumps(response["Item"])
        }

    except Exception as e:
        print(f"Error querying invoice: {str(e)}")
        return {
            "statusCode": 500,
            "body": json.dumps({"error": str(e)})
        }
