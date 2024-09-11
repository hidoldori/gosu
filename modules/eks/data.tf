
data "terraform_remote_state" "network" {
  backend = "s3"
  config = {
    bucket = "gosu-terraform"
    key    = "teraform.state"
    region = "ap-northeast-2"
  }
}
