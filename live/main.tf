terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.0"
    }
  }

  backend "s3" {
    bucket       = "lambroll-example-terraform-state"
    key          = "terraform.tfstate"
    region       = "ap-northeast-1"
    encrypt      = true
    use_lockfile = true
  }
}

provider "aws" {
  region = "ap-northeast-1"
}

# ===================================
module "role_created_by_module" {
  source = "../module"
}

# ===================================
data "aws_iam_policy_document" "lambroll_example2" {
  statement {
    effect = "Allow"

    principals {
      type        = "Service"
      identifiers = ["lambda.amazonaws.com"]
    }

    actions = ["sts:AssumeRole"]
  }
}

resource "aws_iam_role" "lambroll_example2" {
  name               = "lambroll_example2"
  assume_role_policy = data.aws_iam_policy_document.lambroll_example2.json
}

# ===================================
output "role_created_by_module_arn" {
  value       = module.role_created_by_module.role_arn
  description = "The ARN of the IAM role created by the module."
}
