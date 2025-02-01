# 🚀 AWS CloudFront with ALB and EC2 using Terraform

## 📌 Project Overview
This Terraform project provisions a **highly available** and **scalable** web application infrastructure on AWS. It leverages:
- **Amazon EC2** for hosting the web application
- **Application Load Balancer (ALB)** for distributing traffic across instances
- **AWS CloudFront** as a CDN to improve performance and availability

The infrastructure is designed to ensure **low latency**, **high availability**, and **global reach**.

---

## 📁 Project Architecture

### ✅ **Key Components**
1. **VPC & Networking**
   - A **VPC** with public subnets across multiple **Availability Zones (AZs)**
   - An **Internet Gateway** and proper route table associations
2. **Compute Layer**
   - Two **Amazon EC2 instances** deployed in separate **AZs**
   - **Security Groups** for controlled inbound/outbound access
3. **Application Load Balancer (ALB)**
   - Distributes incoming traffic evenly across EC2 instances
   - Performs **health checks** to ensure availability
4. **CloudFront CDN**
   - Serves content globally via AWS **Edge Locations**
   - Implements **caching and HTTPS redirection** for security and performance

---
📌 Disclaimer
 - Key Pair Not Managed by Terraform
- The SSH Key Pair was manually created due to issues encountered while generating it dynamically using Terraform. Ensure you have a valid private key (.pem file) before deploying this infrastructure.
