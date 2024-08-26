terraform {
  backend "s3" {
    region  = "ap-northeast-2"
    key     = "terafrom.state" #state file 명
    bucket  = "gosu-terraform" #기 생성한 bucket 명 
  }
}
