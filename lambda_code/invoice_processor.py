import json
import boto3
import os
from datetime import datetime

# Initialize AWS clients
s3 = boto3.client('s3')
dynamodb = boto3.resource('dynamodb')
sns = boto3.client('sns')

# Environment variables
DYNAMODB_TABLE = os.getenv('DYNAMODB_TABLE')
SNS_TOPIC_ARN = os.getenv('SNS_TOPIC_ARN')

def lambda_handler(event, context):
    try:
        print("Event: ", json.dumps(event))

        # Get S3 bucket and object key from the event
        record = event['Records'][0]
        bucket_name = record['s3']['bucket']['name']
        object_key = record['s3']['object']['key']

        # Fetch the invoice file from S3
        response = s3.get_object(Bucket=bucket_name, Key=object_key)
        invoice_data = json.loads(response['Body'].read().decode('utf-8'))

        # Debugging: Print the parsed invoice data
        print("Parsed Invoice Data:", json.dumps(invoice_data, indent=2))

        # Extract key details from the invoice
        invoice_id = invoice_data.get("InvoiceID", "Unknown")
        total_amount = invoice_data.get("TotalAmount", "0.0")
        customer_name = invoice_data.get("CustomerName", "Unknown")

        # Ensure PurchaseDate is valid, else generate a timestamp
        purchase_date = invoice_data.get("PurchaseDate")
        if not purchase_date:
            purchase_date = datetime.utcnow().isoformat()  # Example: "2025-03-07T16:00:00Z"

        # Save extracted data to DynamoDB
        table = dynamodb.Table(DYNAMODB_TABLE)
        table.put_item(
            Item={
                'InvoiceID': invoice_id,
                'Timestamp': purchase_date,  # Now stores a valid timestamp
                'TotalAmount': str(total_amount),
                'CustomerName': customer_name
            }
        )

        print(f" Invoice {invoice_id} processed successfully!")

    except Exception as e:
        print(f" Error processing invoice: {str(e)}")

        # Send an SNS alert in case of failure
        sns.publish(
            TopicArn=SNS_TOPIC_ARN,
            Message=f"Failed to process invoice: {str(e)}",
            Subject="Invoice Processing Failure"
        )

        raise e  # Re-throw the exception

    return {
        "statusCode": 200,
        "body": json.dumps("Invoice processed successfully!")
    }
