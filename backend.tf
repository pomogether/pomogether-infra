terraform {
  backend "s3" {
    bucket = "pomogether-tf-bucket"
    key    = "terraform-pomogether-state.tfstate"
    region = "us-east-1"
  }
}
