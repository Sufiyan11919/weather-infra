#weather-infra/terraform/uat/backend.tf
terraform {
  backend "s3" {
    bucket         = "weather-tfstate-us-east-2" # S3 bucket you created
    key            = "uat/terraform.tfstate"     # folder/object path
    region         = "us-east-2"
    dynamodb_table = "terraform-lock" # table you created
  }
}
