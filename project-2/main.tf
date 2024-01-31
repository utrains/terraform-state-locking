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
        region = "us-east-1"
        dynamodb_table = "dynamodb-state-locking"
    }
  
    required_version = ">= 1.2.0"
}

provider "aws" {
    region  = var.ec2_region
}

#data for amazon linux

data "aws_ami" "amazon-2" {
    most_recent = true
    filter {
        name = "name"
        values = ["amzn2-ami-hvm-*-x86_64-ebs"]
    }
    owners = ["amazon"]
}

resource "aws_instance" "app_server2" {
    ami           = "${data.aws_ami.amazon-2.id}"
    instance_type = var.ec2_instance_type

    tags = {
        Name = "EC2 instance with remote state developer-2"
    }
}
