terraform {
  backend "s3" {
    bucket  = "github-action-ryutest-bucket"
    key     = "terraform/s3-sample/terraform.tfstate"
    region  = "ap-northeast-1"
    encrypt = true
  }
}