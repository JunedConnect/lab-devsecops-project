terraform {
  backend "s3" {
    bucket              = "terraform-state-123456789101"
    region              = "eu-west-2"
    key                 = "tfstate"
  }
}