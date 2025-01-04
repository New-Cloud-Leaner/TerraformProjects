Project 4: AWS VPC with Subnets and a NAT Gateway

Objective: Build a custom AWS VPC with both public and private subnets, an internet gateway, and a NAT gateway for secure internet access from private subnets.

Note: Make sure the AWS_ACCESS_KEYS and AWS_SECRET_KEYS are configured using aws configure.

Free Tier Note: Nat Gateways incur a price so destroy the as soon as your Infrastructure check is complete.

--------------------------------------------------------------------------------

Project Details

What We'll Create

VPC:

A custom Virtual Private Cloud with a CIDR block (e.g., 10.0.0.0/16).
Subnets:

One public subnet.

One private subnet.

Internet Gateway:

Attached to the VPC to allow internet access for public subnet resources.

NAT Gateway:

For private subnet internet access via the public subnet.

Routing:
Configure route tables for public and private subnets.

--------------------------------------------------------------------------------
Project Steps

Resources to Create

VPC with CIDR 10.0.0.0/16.

Public Subnet with CIDR 10.0.1.0/24.

Private Subnet with CIDR 10.0.2.0/24.

Internet Gateway attached to the VPC.

NAT Gateway in the public subnet.

Route Tables:

Public route table: Route traffic to the internet gateway.

Private route table: Route traffic to the NAT gateway.

--------------------------------------------------------------------------------

Project Files

providers.tf -Contains the AWS and HashiCorp providers block

main.tf - Contains locals for common tags and VPC resource block

internetgateway.tf - Contains IGW resource block

natgateway.tf- Contains the NGW public EIP and NGW resource block

subnets.tf - Contains the public and private subnet resource block

routetable.tf - Contains the Route table routes and route table associations

outputs.tf - Contains output of the resources block defined in the above config files.

variables.tf - Contains the common variables used in the above config files.
