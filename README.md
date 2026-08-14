# Terraform AWS – EKS Cluster

Infrastructure as Code project to provision a production-style Amazon EKS cluster using Terraform.

## What this creates

- VPC with public and private subnets (3 AZs)
- NAT Gateway
- Amazon EKS cluster
- Managed Node Group (`t3.medium`)
- IRSA enabled
- Cluster endpoint restricted to your public IP
- Remote state in S3 + DynamoDB locking
- GitHub Actions CI/CD (plan on PR, apply on main)

## Prerequisites

- AWS Account
- Terraform >= 1.5
- AWS CLI configured
- GitHub Secrets: `AWS_ACCESS_KEY_ID`, `AWS_SECRET_ACCESS_KEY`

## How to use

```bash
git clone https://github.com/Ishan-1100/terraform-aws.git
cd terraform-aws

terraform init
terraform plan
terraform apply

Pipeline


EventActionPull Requestterraform planPush to mainterraform apply
Security highlights

Nodes run in private subnets
API endpoint restricted by IP
IRSA enabled
State file encrypted

Cleanup
Bashterraform destroy
Note: This will incur AWS costs. Always destroy resources after testing.

Author: Ishan Ahuja
DevSecOps | Cloud Infrastructure
