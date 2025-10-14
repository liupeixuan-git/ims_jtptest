terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

# 各アカウント用provider
provider "aws" {
  alias  = "dev"
  region = "ap-northeast-1"
  assume_role {
    role_arn = var.accounts["dev"].role_arn
  }
}

provider "aws" {
  alias  = "prd"
  region = "ap-northeast-1"
  assume_role {
    role_arn = var.accounts["prd"].role_arn
  }
}

locals {
  providers_map = {
    dev = aws.dev
    prd = aws.prd
  }
}

resource "aws_iam_role" "github_oidc" {
  for_each = var.accounts

  provider = local.providers_map[each.key]

  name = "GitHubActionsOIDCRole"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Principal = {
          Federated = "arn:aws:iam::${each.value.account_id}:oidc-provider/token.actions.githubusercontent.com"
        }
        Action = "sts:AssumeRoleWithWebIdentity"
        Condition = {
          StringEquals = {
            "token.actions.githubusercontent.com:aud" = "sts.amazonaws.com"
          }
          StringLike = {
            "token.actions.githubusercontent.com:sub" = "repo:${var.github_org}/*:ref:refs/heads/*"
          }
        }
      }
    ]
  })

  managed_policy_arns = ["arn:aws:iam::aws:policy/AdministratorAccess"]
}