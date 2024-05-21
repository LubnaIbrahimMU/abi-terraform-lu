terraform {
  backend "s3" {
    bucket         = "abi-lu-terra1"
    key            = "terraform.tfstate"
    region         = "us-east-1"
    # dynamodb_table = "lu-lock"
  }
}
