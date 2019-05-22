#####################################
# Provider Settings
#####################################
provider "aws" {
  region  = "ap-northeast-1"

  # チーム開発の場合は基本的に固定しないとtfstateの管理バージョンで怒られる
  version = "~> 1.60.0"
}