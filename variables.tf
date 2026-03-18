# variables.tf
variable "region" {
  description = "AWS region to deploy resources"
  type        = string
  default     = "us-east-1" # Modify as needed
}

variable "cluster_name" {
  description = "Name of the EKS cluster"
  type        = string
  default     = "my-terraform-eks-cluster"
}
