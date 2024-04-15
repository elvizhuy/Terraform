terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region                      = var.region
  s3_use_path_style = true
  skip_credentials_validation = true
  skip_requesting_account_id  = true


}