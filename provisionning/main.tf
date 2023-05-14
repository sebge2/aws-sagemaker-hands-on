# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/sagemaker_notebook_instance
# https://github.com/dkhundley/terraform-sagemaker-tutorial/tree/main/Part%202a%20-%20Creating%20a%20SageMaker%20Notebook/terraform
# https://towardsdatascience.com/terraform-sagemaker-part-2a-creating-a-custom-sagemaker-notebook-instance-1d68c90b192b

terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
  }
}

provider "aws" {
  region                   = var.region
  shared_credentials_files = ["~/.aws/credentials"]
}

data "aws_availability_zones" "available" {
  filter {
    name   = "opt-in-status"
    values = ["opt-in-not-required"]
  }
}