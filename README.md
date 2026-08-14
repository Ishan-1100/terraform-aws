# Terraform AWS - EKS Cluster

Production-style Infrastructure as Code to provision a secure Amazon EKS cluster using Terraform.

## What this project creates

- VPC with public & private subnets across 3 Availability Zones
- NAT Gateway for private subnet internet access
- Amazon EKS cluster (managed control plane)
- Managed Node Group (`t3.medium`)
- IRSA (IAM Roles for Service Accounts) enabled
- Cluster endpoint restricted to your current public IP
- Remote state stored in S3 + DynamoDB locking
- GitHub Actions CI/CD pipeline (plan on PR, apply on main)

## Architecture
Internet
│
▼
Public Subnets (ALB / Bastion if needed)
│
▼
Private Subnets ← EKS Worker Nodes
│
▼
NAT Gateway → Internet (outbound only)


## Prerequisites

- AWS Account
- Terraform >= 1.5
- AWS CLI configured
- GitHub repository secrets:
  - `AWS_ACCESS_KEY_ID`
  - `AWS_SECRET_ACCESS_KEY`
  - `AWS_REGION` (optional)

## How to use

1. Clone the repository
```bash
git clone https://github.com/Ishan-1100/terraform-aws.git
cd terraform-aws
