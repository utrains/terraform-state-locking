terraform {
    required_providers {
        aws = {
        source  = "hashicorp/aws"
        version = "~> 4.16"
        }
    }
    backend "s3" {
        bucket = "terraformbackend-bucket"
        key = "terraformbackend-bucket/remote-s3/terraform.tfstate"
        region = "us-west-1"
        dynamodb_table = "dynamodb-state-locking"
    }
  
    required_version = ">= 1.2.0"
}

provider "aws" {
    region  = var.ec2_region
}

resource "aws_instance" "app_server" {
    ami           = "ami-08d70e59c07c61a3a"
    instance_type = var.ec2_instance_type
}
