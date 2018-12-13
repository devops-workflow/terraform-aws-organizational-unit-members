module "example" {
  source       = "../../"
  aws_profile  = "${var.aws_profile}"
  account_list = "${var.account_list}"
}
