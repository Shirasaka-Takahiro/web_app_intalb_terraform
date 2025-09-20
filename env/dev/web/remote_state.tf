data "terraform_remote_state" "common_network" {
  backend = "s3"

  config = {
    bucket = "example-dev-tfstate-bucket"
    key    = "common_network.tfstate"
    region = "ap-northeast-1"
  }
}

data "terraform_remote_state" "common_domain" {
  backend = "s3"

  config = {
    bucket = "example-dev-tfstate-bucket"
    key    = "common_domain.tfstate"
    region = "ap-northeast-1"
  }
}