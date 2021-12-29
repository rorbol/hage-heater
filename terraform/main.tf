
provider "aws" {
  region = "eu-central-1"
}

module "serverless" {
  source = "github.com/efio-dk/data-as-code/tf/modules/serverless"


  git_connection = {
    provider   = "GitHub"
    owner      = "rorbol"
    repository = "hage-heater"
    branch     = "main"
  }

  default_image_tag = "latest"

  functions = {
    away-app = {
      description = "Sets heaters to away temperature"
      src_path    = "src"

      events = {
        https = {
          rootpath = {
            method = "GET"
            path   = "/away"
            public = true
          }
        }
      }

      environment_variables = {
        API_URL = {
          type  = "string"
          value = "https://api-1.adax.no/client-api"
        }
        CLIENT_ID = {
          type  = "ssm_secure_string"
          value = "ADAX_CLIENT_ID"
        }
        CLIENT_SECRET = {
          type  = "ssm_secure_string"
          value = "ADAX_CLIENT_SECRET"
        }
      }
    }
  }
}