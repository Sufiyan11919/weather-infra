terraform {
  backend "s3" {
    bucket         = "weather-tfstate-us-east-2"
    key            = "prod/terraform.tfstate"   # <-- separate state file
    region         = "us-east-2"
    dynamodb_table = "terraform-lock"
  }
}
