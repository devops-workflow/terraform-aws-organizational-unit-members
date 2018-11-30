variable "aws_profile" {
  description = "AWS profile in local credentials file that has rights to master account"
}

variable "aws_region" {
  description = "AWS region"
  default     = "us-east-1"
}

variable "account_list" {
  description = "List of member account and organizational units they should be into. Format: {account id}:{ou name} {account id}:{ou name}"
}
