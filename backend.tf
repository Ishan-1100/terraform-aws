terraform {
  backend "s3" {
    bucket         = "terraform-state-bucket-ishan"
    key            = "eks/terraform.tfstate" # Path inside the bucket
    region         = "us-east-1"
    dynamodb_table = "terraform-state-locking"
    encrypt        = true
  }
}