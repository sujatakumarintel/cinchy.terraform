terraform {
  required_version = ">= 0.12"
}

provider "aws" {
  region     = var.region
  #access_key = var.access_key
  #secret_key = var.secret_key
}

data "aws_availability_zones" "available" {}
