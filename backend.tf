terraform {
  backend "s3" {
    region  = "ap-northeast-2"
    key     = "teraform.state" #state file 명
    bucket  = "gosu-terraform-app" #기 생성한 bucket 명 
  }
}
