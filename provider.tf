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

    access_key = "AKIAW3MEARCYSBSKOQKI"
    secret_key = "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"
}
