Project 3: Creating a DynamoDB Table

Objective: Set up an AWS DynamoDB table with Terraform. The table will be used to store key-value pairs, and it will have a basic configuration suitable for free-tier usage.

Note: Make sure the AWS_ACCESS_KEYS and AWS_SECRET_KEYS are configured using aws configure

--------------------------------------------------------------

Project Details

Resources to Create:

A DynamoDB table with a partition key (primary key).

Optional provisioned throughput or on-demand mode (free-tier compatible).

--------------------------------------------------------------

Configuration:

Table name: Project3-DynamoDB-Table.

Partition key: ID (type: String).

Tags for identification.

Free Tier Compatibility:

Use provisioned throughput with 5 read capacity units (RCU) and 5 write capacity units (WCU) to stay within the free tier.

--------------------------------------------------------------

Suggested Code Structure

Main Configuration (main.tf):

Define the DynamoDB table resource.
Variables (variables.tf):

Parameterize the table name, partition key, and throughput settings.
Outputs (outputs.tf):

Output the table name and ARN.
