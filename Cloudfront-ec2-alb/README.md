# **CloudFront with ALB and EC2 - Terraform Project**

## **📌 Overview**
This Terraform project deploys a highly available web application using:
- **CloudFront (CDN)**
- **Application Load Balancer (ALB)**
- **Two EC2 instances (in separate subnets)**

## **🛠 Technologies Used**
- Terraform, AWS CloudFront, ALB, EC2, VPC

## **🚀 Deployment Steps**
```bash
git clone https://github.com/New-Cloud-Leaner/TerraformProjects.git
cd TerraformProjects/CloudFront-ec2-alb
terraform init
terraform apply -auto-approve
```

Find the CloudFront domain using:
```bash
terraform output cloudfront_domain
```

## **📂 Terraform Modules**
- **VPC:** Creates VPC, subnets, and networking resources.
- **Security Groups:** Manages firewall rules.
- **EC2:** Deploys web servers with an Auto Scaling Group.
- **ALB:** Manages load balancing.
- **CloudFront:** Secures and caches content.

## **🔐 Security Notes**
- **SSH Key Pair** was manually created due to Terraform issues.
- **Security Groups** follow best practices.

## **🧹 Clean Up Resources**
```bash
terraform destroy -auto-approve
```

## **📌 Disclaimer**
- Designed to be **within AWS Free Tier** (costs may apply).
- **SSH key pair must be manually configured.**

## **📧 Contact & Contributions**
- GitHub: [New-Cloud-Leaner](https://github.com/New-Cloud-Leaner)
- Contributions welcome!

🚀 **Deploy your CloudFront + ALB + EC2 project today!**

