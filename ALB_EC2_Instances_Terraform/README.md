This Project contains Load balanced EC2 instances:
--------------------------------------------------------------------------------------
Features
--------------------------------------------------------------------------------------
Networking:
--------------------------------------------------------------------------------------
VPC with a CIDR block of 10.0.0.0/16.

Two public subnets in different Availability Zones (ap-south-1a and ap-south-1b).

Internet Gateway for public internet access.

Route tables configured for public subnets.
--------------------------------------------------------------------------------------
Frontend Instances:

Three EC2 instances (Amazon Linux 2) hosting Apache web servers.

Instances deployed in the public subnets.

Configured with a security group to allow HTTP (port 80) and SSH (port 22) access.
--------------------------------------------------------------------------------------
Application Load Balancer (ALB):

ALB distributing traffic across the frontend instances.

ALB spans two public subnets for high availability.

Configured with a listener on port 80 and a target group for the frontend instances.
