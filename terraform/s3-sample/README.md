# Terraform S3 sample

このディレクトリは GitHub Actions で Terraform を実行して S3 バケットを作成するサンプルです。

必要な Secrets / 設定:

- `AWS_ROLE_ARN` : Actions が引き受ける IAM Role の ARN。Organization やアカウント横断で OIDC を使う場合に設定します。
- `AWS_REGION` : デフォルトの AWS リージョン (例: us-east-1)。

ワークフロー:

- PR (pull_request) が作成されると `terraform plan` を実行します。
- `main` ブランチに push されると `terraform apply` を自動実行します（注意: 自動適用されます）。

ローカルでの実行例:

```powershell
# リポジトリのルートから
cd terraform/s3-sample
terraform init
terraform plan -var "bucket_name=my-unique-bucket-name"
terraform apply -var "bucket_name=my-unique-bucket-name"
```

注意事項:

- S3 バケット名はグローバルユニークである必要があります。
- 本ワークフローはデフォルトで `aws-actions/configure-aws-credentials` を使い、`role-to-assume` を指定しているため、`AWS_ROLE_ARN` と `AWS_REGION` を GitHub Secrets に設定してください。OIDC を利用する場合は、リポジトリ/organization に OIDC トークンの信頼設定が必要です。
