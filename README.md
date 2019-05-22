# tutorial-aws-eks

本リポジトリはEKS Clusterの作成および一般的なマイクロサービスアーキテクチャを最初の一歩のテンプレートとして再利用できるようにする目的で作成した。

## 構築手順

1. export AWS_PROFILE=yastani-dev
1. terraform init
1. terraform workspace select yastani-dev
1. terraform plan
1. terraform apply

## デプロイ手順

1. terraform output kubectl_config > .kube/config
1. terraform output ConfigMap > manifests/config_map.yml

## 今後の課題

- Ingress, Service, ConfigMap, Secret, Jobを適切に定義したマニフェストファイルをデプロイしたい
- ECRにローカル環境で動くImageを登録してlaunch_configの参照先を切り替えたい
  - イメージ更新とECRへの登録はPackerを噛ませたい
- Cloudwatchで適切な監視設定を定義したい
  - 欲を言えばCloudwatch Container Insightsを使いたい
  - Datadogとの比較もしてみたい
- RDS, Redisと疎通確認まで取れるhealthを作成したい
- kopsとかkube-awsも使ってみたい

## 所感

- やはりCluster作成はGKEのほうが圧倒的に早い(15分くらいかかった)

## 参考

https://dev.classmethod.jp/cloud/aws/terraform-eks-create/