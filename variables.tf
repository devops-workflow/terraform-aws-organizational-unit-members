variable "aws_profile" {
  description = "AWS profile in local credentials file that has rights to master account"
}

variable "account_list" {
  description = "List of member account and organizational units they should be into. Format: {account id}:{ou name} {account id}:{ou name}"
}
