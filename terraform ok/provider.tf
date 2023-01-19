terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "4.46.0"
    }
  }
}

provider "aws" {
    region = var.region
    access_key = var.access_key_instance
    secret_key = var.secret_key_instance
    token= var.token_key_instance
}
