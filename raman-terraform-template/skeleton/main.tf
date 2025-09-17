terraform {
  required_version = ">= 1.3.0"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region = "${{ values.aws_region }}"
}

resource "aws_vpc" "main" {
  cidr_block = "${{ values.vpc_cidr }}"
  tags = {
    Name = "${{ values.project_name }}-vpc"
  }
}

resource "aws_s3_bucket" "secure" {
  bucket = "${{ values.s3_bucket_name }}"

  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        sse_algorithm = "AES256"
      }
    }
  }

  tags = {
    Name = "${{ values.project_name }}-bucket"
  }
}

