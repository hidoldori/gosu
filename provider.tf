# ---- root/providers.tf

terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "4.28.0"
    }
  }
}

provider "aws" {
    region = var.region

    #access_key = ""
    #secret_key = ""
}
