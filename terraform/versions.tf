terraform {
  required_version = "~> 1.0.10"
  experiments = [module_variable_optional_attrs]
  
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.0"
    }
  }
}