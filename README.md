Project 1: Setting Up an S3 Bucket
-----------------------------------
Objective: Create an AWS S3 bucket with Terraform. The bucket will have basic settings and public access blocked to ensure it's secure.

Note: Make sure the AWS_ACCESS_KEYS and AWS_SECRET_KEYS are configured using aws configure

#################################

Steps:
•	Write a Terraform script to:

•	Define the provider (AWS).

•	Create an S3 bucket.

•	Enable versioning.

•	Block public access.

•	Deploy the script.

•	Verify the bucket creation in AWS Management Console.

•	Verify the name and id of the new created bucket on the terminal.

•	Clean up resources.

##################################

Files included are:

•	main.tf - contains the providers and resources block

•	variables.tf - contains the variable block

•	terraform.tfvars - contains the value of the variable block (bucketname)
