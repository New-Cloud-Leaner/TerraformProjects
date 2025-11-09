Terraform documentation Source: https://registry.terraform.io/providers/hashicorp/aws/latest/docs 

Terraform project- How to create multiple EC2 instances in AWS

###############################################################

The following are the files created for this small project:

providers.tf - It contains the aws provider code block and region in which the resource will be created.
ec2.tf - It contains the ec2 resource and ami data block in which we fetch the ami of the ubuntu image from aws and use it in the ec2 resource block to create the VMs.
variables.tf - It contains the variables to be used in the terraform files.
outputs.tf - It contains the output code to display the ec2 ids of the three ec2 instances created.







