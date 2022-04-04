terraform {
  backend "s3" {
    bucket  = "cinchy-terraform-state"
    key     = "cinchy_nonprod/terraform.tfstate"
    region  = "ca-central-1"
    encrypt = true
  }
}

provider "aws" {
  region = "ca-central-1"
}