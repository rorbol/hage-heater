
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
    }
  }
}