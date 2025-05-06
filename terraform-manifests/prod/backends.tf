# terraform {
#   cloud {
#     organization = "ORGNAME"

#     workspaces {
#       name = "dev_tf_resources_ws"
#     }
#   }
# }

terraform {
  backend "s3" {
    bucket = "aws-d-testbucket"
    key    = "terraformstates/prod.tfstate"
    region = "ap-south-1"
  }
}
