Project 2: Launching an EC2 Instance
-------------------------------------------------------------------------------------

Objective: Deploy a simple EC2 instance using Terraform under the AWS Free Tier. The instance will be launched with a minimal configuration and associated with a security group to allow SSH access.

Note: Make sure the AWS_ACCESS_KEYS and AWS_SECRET_KEYS are configured using aws configure

-------------------------------------------------------------------------------------

Project Details

Resources to Create:

An EC2 instance using a free-tier eligible instance type (e.g., t2.micro or t3.micro).

A security group to allow inbound SSH traffic.

A key pair for SSH access.

-------------------------------------------------------------------------------------

Configuration:

Use the Amazon Linux 2 AMI.

Configure the security group to allow SSH access only from your public IP.

Output the public IP address of the EC2 instance.

-------------------------------------------------------------------------------------

Free Tier Compatibility:

Use t2.micro or t3.micro instances to stay within the free tier limits.

Steps

Set Up Variables:

Define variables for the instance type, AMI ID, and allowed SSH IP.

Write Terraform Code:

Configure the AWS provider.

Create a security group for SSH access.

Create an EC2 instance.

-------------------------------------------------------------------------------------

Test Deployment:

Run terraform init, terraform plan, and terraform apply.

Check in the AWS management console your EC2 instance has now been launched

-------------------------------------------------------------------------------------

Clean Up:

Terminate the instance and delete the security group after researching.

-------------------------------------------------------------------------------------

Suggested Code Structure

Main Configuration (main.tf):

Define resources for the EC2 instance and security group.

Variables (variables.tf and terraform.tfvars):

Parameterize instance type, AMI ID, and allowed SSH IP.

Outputs (outputs.tf):

Output the EC2 instance public IP.

Output the EC2 ARN

Output the EC2 ID

-------------------------------------------------------------------------------------
