variable "accounts" {
  type = map(object({
    account_id = string
    role_arn   = string
  }))
}

variable "github_org" {
  type = string
}