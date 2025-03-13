# Automated Serverless Financial Data Pipeline with AWS

## Technical Architecture

![image_alt](https://github.com/Tatenda-Prince/Serverless-Financial-Data-Pipeline-with-AWS-Terraform-CI-CD/blob/c64c45edd901dd14d4a3841dbceacab7df0c1407/screenshots/Screenshot%202025-03-07%20213637.png)


## Project Overview
This project automates financial invoice processing using a serverless architecture on AWS. It leverages AWS services such as S3, Lambda, DynamoDB, API Gateway, SNS, and CloudWatch, ensuring a scalable, cost-effective, and reliable solution.

## Project Objective
1.Automate the ingestion, processing, storage, and retrieval of financial invoices.

2.Reduce manual intervention and errors in invoice handling.

3.Provide an API for real-time invoice querying.

4.Implement DevOps best practices using Terraform and GitHub Actions for CI/CD.

## Features
1.Automated Invoice Processing – JSON invoices uploaded to S3 are processed automatically by Lambda.

2.Scalable NoSQL Database – Uses DynamoDB for fast and scalable invoice storage.

3.API-Based Invoice Querying – Fetch invoices using API Gateway + Lambda.

4.Error Handling & Notifications – Alerts via SNS when failures occur.

5.CI/CD for AWS Deployment – Infrastructure managed via Terraform, auto-deployed using GitHub Actions.

6.Cloud Monitoring – Uses AWS CloudWatch for logging and monitoring.

## Technologies Used

1.AWS S3 – Stores raw invoice JSON files.

2.AWS Lambda – Processes invoices and fetches stored invoices.

3.AWS DynamoDB – NoSQL database for storing invoice data.

4.AWS API Gateway – Exposes API endpoints for querying invoices.

5.AWS SNS – Sends notifications for failures.

6.AWS CloudWatch – Logs and monitors system events.

7.Terraform – Infrastructure as Code (IaC) to automate AWS deployments.

8.GitHub Actions – CI/CD pipeline for automating Terraform & Lambda deployments.

## Use Case

You works at the Up The Chelsea Reatail that receives thousands of invoices daily and wants to automate invoice processing instead of relying on manual data entry. This solution enables fast, error-free, and real-time processing while ensuring business continuity with monitoring and alerts.

##  Prerequisites

1.An AWS Account with necessary permissions.

2.Terraform Installed (>=1.5.7)

3.GitHub Repository with secrets configured for AWS credentials.

4.AWS CLI Installed & Configured

## Step 1: Clone the Repository

1.1.Clone this repository to your local machine.

```language 
git clone https://github.com/Tatenda-Prince/Serverless-Financial-Data-Pipeline-with-AWS-Terraform-CI-CD.git
```


## Step 2 : Run Terraform workflow to initialize, validate, plan then apply

2.1.Terraform will create:S3 Bucket, DynamoDB Table, Lambda Functions, API Gateway and SNS Topic.

2.2.In your local terraform visual code environment terminal, to initialize the necessary providers, execute the following command in your environment terminal.

```language
terraform init
```


Upon completion of the initialization process, a successful prompt will be displayed, as shown below.

![image_alt](https://github.com/Tatenda-Prince/Serverless-Financial-Data-Pipeline-with-AWS-Terraform-CI-CD/blob/da89a04b3ab9e621345b51957a3c16a271757eee/screenshots/Screenshot%202025-03-08%20143748.png)


2.3.Next, let’s ensure that our code does not contain any syntax errors by running the following command


```language
terraform validate
```

The command should generate a success message, confirming that it is valid, as demonstrated below.

![image_alt](https://github.com/Tatenda-Prince/Serverless-Financial-Data-Pipeline-with-AWS-Terraform-CI-CD/blob/c9c631d54f2e1e58923b1c46f773f43622aa189b/screenshots/Screenshot%202025-03-08%20143843.png)

2.4.Let’s now execute the following command to generate a list of all the modifications that Terraform will apply.

```language
terraform plan
```

![image_alt](https://github.com/Tatenda-Prince/Serverless-Financial-Data-Pipeline-with-AWS-Terraform-CI-CD/blob/6102e46ce1c79ad55ffc8c1f12e3ee419e0f9451/screenshots/Screenshot%202025-03-08%20144030.png)

The list of changes that Terraform is anticipated to apply to the infrastructure resources should be displayed. The “+” sign indicates what will be added, while the “-” sign indicates what will be removed.


2.5.Now, let’s deploy this infrastructure! Execute the following command to apply the changes and deploy the resources. Note — Make sure to type “yes” to agree to the changes after running this command.

```language
terraform apply
```

Terraform will initiate the process of applying all the changes to the infrastructure. Kindly wait for a few seconds for the deployment process to complete.

![image_alt](https://github.com/Tatenda-Prince/Serverless-Financial-Data-Pipeline-with-AWS-Terraform-CI-CD/blob/567280accdad33e480d5743e8b57df111b7a9421/screenshots/Screenshot%202025-03-08%20144231.png)


## Success

The process should now conclude with a message indicating “Apply complete”, stating the total number of added, modified, and destroyed resources, accompanied by several resources.

![image_alt](https://github.com/Tatenda-Prince/Serverless-Financial-Data-Pipeline-with-AWS-Terraform-CI-CD/blob/5d94b253a62187d3121fc06c1e96e561f8f996c1/screenshots/Screenshot%202025-03-08%20144954.png)


## Step 3: Verify creation of our resources

3.1.In the AWS Management Console, head to the Amazon S3 dashboard and verify that a S3 bucket was successfully created as shown below

![image_alt](https://github.com/Tatenda-Prince/Serverless-Financial-Data-Pipeline-with-AWS-Terraform-CI-CD/blob/5292c422c7908f7bf8dcc35c6b1f89a5749ccc0a/screenshots/Screenshot%202025-03-08%20142954.png)

3.2.In the AWS Management Console, head to the AWS Lambda dashboard and verify that you two lambda function that were successfully created.

![image_alt](https://github.com/Tatenda-Prince/Serverless-Financial-Data-Pipeline-with-AWS-Terraform-CI-CD/blob/5cc1e4dd6bdd305ea66e14d4a5edf46f5b0a6b66/screenshots/Screenshot%202025-03-08%20143027.png)

3.3.In the AWS Management Console, head to the Amazon DynamoDB dashboard and verify that a table was successfully created as shown below

![image_alt](https://github.com/Tatenda-Prince/Serverless-Financial-Data-Pipeline-with-AWS-Terraform-CI-CD/blob/7282ddeb9bd04eba21e824baf82395c25985aacc/screenshots/Screenshot%202025-03-08%20143013.png)


3.4.In the AWS Management Console, head to the Amazon API Gateway dashboard and verify that a API Invoice was successfully created as shown below

![image_alt](https://github.com/Tatenda-Prince/Serverless-Financial-Data-Pipeline-with-AWS-Terraform-CI-CD/blob/6218990b5719835d7778b2cf9f268f2ae6b5afb3/screenshots/Screenshot%202025-03-08%20145111.png)

3.4.In the AWS Management Console, head to the Amazon SNS dashboard and verify that a InvoiceProcessingAlerts topic was successfully created as shown below

![image_alt](https://github.com/Tatenda-Prince/Serverless-Financial-Data-Pipeline-with-AWS-Terraform-CI-CD/blob/d521f52ace88cf8d954d10564974ca29df161b6e/screenshots/Screenshot%202025-03-08%20143037.png)


## Step 4: Push changes to GitHub to trigger CI/CD:
4.1.This GitHub Actions workflow automates the deployment of AWS infrastructure using Terraform:

1.On push to the `master` branch – Ensures updates are applied automatically.

2.On pull requests to `master` – Allows reviewing changes before merging.

3.On manual trigger (workflow_dispatch) – Allows optional destruction of AWS resources.

GitHub Actions Workflow:

```language
name: Terraform CI/CD

on:
  push:
    branches:
      - master  # Ensure this matches your repo's default branch
  pull_request:
    branches:
      - master
  workflow_dispatch:  # Allows manual trigger
    inputs:
      destroy:
        description: "Destroy AWS resources (true/false)"
        required: false
        default: "false"

jobs:
  terraform:
    runs-on: ubuntu-latest

    steps:
      - name: Checkout Repository
        uses: actions/checkout@v3

      - name: Setup Terraform
        uses: hashicorp/setup-terraform@v2
        with:
          terraform_version: 1.5.7

      - name: Cache Terraform Providers
        uses: actions/cache@v3
        with:
          path: .terraform
          key: ${{ runner.os }}-terraform-${{ hashFiles('**/.terraform.lock.hcl') }}
          restore-keys: |
            ${{ runner.os }}-terraform-

      - name: Configure AWS Credentials
        uses: aws-actions/configure-aws-credentials@v2
        with:
          aws-access-key-id: ${{ secrets.AWS_ACCESS_KEY_ID }}
          aws-secret-access-key: ${{ secrets.AWS_SECRET_ACCESS_KEY }}
          aws-region: ${{ secrets.AWS_REGION }}

      - name: Initialize Terraform
        run: terraform init

      - name: Terraform Plan
        run: terraform plan

      - name: Terraform Apply
        if: github.ref == 'refs/heads/master' && github.event.inputs.destroy != 'true'
        run: terraform apply -auto-approve

      - name: Terraform Destroy
        if: github.event.inputs.destroy == 'true'
        run: terraform destroy -auto-approve
```


4.2.Manage Secrets in GitHub:

1.Environment Variables:

The env section within the steps that require AWS credentials pulls the values from the secrets stored in the GitHub repository.

2.Navigate to Your Repository on GitHub

3.Add Secrets `Settings > Secrets and variables > Actions`.

4.Add the following secrets:

![image_alt](https://github.com/Tatenda-Prince/Serverless-Financial-Data-Pipeline-with-AWS-Terraform-CI-CD/blob/cc5455d29c80d9cd3d2962477678b0bf11ea8f84/screenshots/Screenshot%202025-03-13%20192625.png)


4.3.Run the following commands.

```language
git add .

git commit -m "Deploy infrastructure"

git push origin main
```

![image_alt](https://github.com/Tatenda-Prince/Serverless-Financial-Data-Pipeline-with-AWS-Terraform-CI-CD/blob/d2f7b4c48f118f1d216309ee717813487ca4ead0/screenshots/Screenshot%202025-03-08%20124135.png)


4.4.Monitor GitHub Actions to ensure successful deployment.

![image_alt](https://github.com/Tatenda-Prince/Serverless-Financial-Data-Pipeline-with-AWS-Terraform-CI-CD/blob/f10188b0da9aa2a875c6d3c609900a0306717dd6/screenshots/Screenshot%202025-03-08%20124344.png)



![image_alt](https://github.com/Tatenda-Prince/Serverless-Financial-Data-Pipeline-with-AWS-Terraform-CI-CD/blob/ec275a324fbf7fe48c7f1c1dba563146e471a76f/screenshots/Screenshot%202025-03-08%20124538.png)




## Step 5:Testing the System

## Upload a Sample Invoice to S3

5.1.Use the AWS CLI to upload an invoice:

```language
aws s3 cp sample_invoice.json s3://your-s3-bucket-name/
```

![image_alt](https://github.com/Tatenda-Prince/Serverless-Financial-Data-Pipeline-with-AWS-Terraform-CI-CD/blob/51735e0f74a9a6b24801d67df85270b586762561/screenshots/Screenshot%202025-03-08%20125033.png)


5.2.Expected Result: The invoice should be processed by Lambda and stored in DynamoDB.

![image_alt](https://github.com/Tatenda-Prince/Serverless-Financial-Data-Pipeline-with-AWS-Terraform-CI-CD/blob/9a92ce9d4d590ac9687cd5b07de2b09b6af02c02/screenshots/Screenshot%202025-03-08%20125836.png)



##  Query Invoice via API Gateway

```language
curl -X GET "https://your-api-gateway-url/prod/invoice"
```

5.3.Expected Result: A JSON response containing invoice details.

![image_alt](https://github.com/Tatenda-Prince/Serverless-Financial-Data-Pipeline-with-AWS-Terraform-CI-CD/blob/d68a430007be3532eaeb46b44a582a6aab459295/screenshots/Screenshot%202025-03-08%20130026.png)


## Test Error Handling

5.4.Upload a malformed JSON file to S3:

```language
aws s3 cp invalid_invoice.json s3://your-s3-bucket-name/
```

5.5.Expected Result: SNS notification is triggered, and an alert is sent.

![image_alt](https://github.com/Tatenda-Prince/Serverless-Financial-Data-Pipeline-with-AWS-Terraform-CI-CD/blob/0c2a313e616076fbba04da10fceb62a3c0e0481e/screenshots/Screenshot%202025-03-08%20131449.png)


## Future Enhancements

1.Multi-region Deployment for high availability.

2.AI-based Invoice Verification before storing data.

3.Enhanced Security with AWS IAM Policies.

4.Billing Dashboard to visualize invoice trends and analytics.

## Congratulations
We have successfully created a "serverless financial data pipeline using AWS services" and Terraform. We learned how to integrate S3, Lambda, DynamoDB, API Gateway, and SNS to create a scalable and fault-tolerant system for invoice processing. 

Implementing CI/CD with GitHub Actions reinforced best practices in infrastructure automation and continuous deployment. We also explored error handling by testing with malformed JSON files, ensuring system resilience. This project not only strengthened our Cloud Engineering & DevOps skills but also demonstrated real-world business value by automating financial data processing, reducing manual work, and improving operational efficiency. 










