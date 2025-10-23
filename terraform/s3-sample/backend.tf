terraform {
  backend "s3" {
    bucket         = "my-ims-test-bucket-20251023"
    key            = "terraform/s3-sample/${terraform.workspace}/terraform.tfstate"
    region         = "ap-northeast-1"
    encrypt        = true
  }
}
