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
