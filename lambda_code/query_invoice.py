import json
import boto3
import os

# Initialize DynamoDB client
dynamodb = boto3.resource('dynamodb')

# Get the DynamoDB table name from environment variables
DYNAMODB_TABLE = os.getenv('DYNAMODB_TABLE')

def lambda_handler(event, context):
    try:
        # Extract query parameters from API Gateway request
        query_params = event.get("queryStringParameters", {}) or {}

        invoice_id = query_params.get("InvoiceID")

        # Get reference to the DynamoDB table
        table = dynamodb.Table(DYNAMODB_TABLE)

        if invoice_id:
            # Query a single invoice by InvoiceID
            response = table.scan(
                FilterExpression="InvoiceID = :invoice_id",
                ExpressionAttributeValues={":invoice_id": invoice_id}
            )
        else:
            # Scan the entire table to get all invoices
            response = table.scan()

        # Check if any invoices exist
        if "Items" not in response or not response["Items"]:
            return {
                "statusCode": 404,
                "body": json.dumps({"error": "No invoices found"})
            }

        return {
            "statusCode": 200,
            "body": json.dumps(response["Items"])
        }

    except Exception as e:
        print(f"Error querying invoices: {str(e)}")
        return {
            "statusCode": 500,
            "body": json.dumps({"error": str(e)})
        }

