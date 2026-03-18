# main.tf
terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region = var.region
}

data "external" "my_public_ip" {
  program = ["bash", "-c", "echo '{\"ip\":\"'$(curl -s ifconfig.me)'\"}'"]
}


# Use the VPC module to create a new VPC with public and private subnets
module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "~> 5.0"

  name = "${var.cluster_name}-vpc"
  cidr = "10.0.0.0/16"

  azs             = ["${var.region}a", "${var.region}b", "${var.region}c"]
  private_subnets = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
  public_subnets  = ["10.0.4.0/24", "10.0.5.0/24", "10.0.6.0/24"]

  enable_nat_gateway = true
  enable_vpn_gateway = false

  # Add required tags for EKS and Kubernetes
  public_subnet_tags = {
    "kubernetes.io/cluster/${var.cluster_name}" = "shared"
    "kubernetes.io/role/elb"                    = 1
  }
  private_subnet_tags = {
    "kubernetes.io/cluster/${var.cluster_name}" = "shared"
    "kubernetes.io/role/internal-elb"           = 1
  }
}

# Use the EKS module to create the EKS cluster and managed node group
module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "~> 20.0" # Use the latest stable version

  cluster_name    = var.cluster_name
  cluster_version = "1.29" # Specify your desired Kubernetes version

  vpc_id     = module.vpc.vpc_id
  subnet_ids = module.vpc.private_subnets
  
  # Enable IRSA (IAM Roles for Service Accounts)
  enable_irsa = true

  # Configure the managed node group
  eks_managed_node_groups = {
    general = {
      min_size     = 1
      max_size     = 3
      desired_size = 1
      instance_types = ["t3.medium"]
    }
  }

cluster_endpoint_public_access = true
cluster_endpoint_private_access = true
# cluster_endpoint_public_access_cidrs = [" 157.119.218.62/32"]
cluster_endpoint_public_access_cidrs = [
    "${data.external.my_public_ip.result.ip}/32"
  ]


}


