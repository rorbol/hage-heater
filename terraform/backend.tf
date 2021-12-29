terraform {
  backend "s3" {
    bucket = "rorbol.tfstate"
    key    = "hage-heater.tfstate"
    region = "eu-north-1"
  }
}