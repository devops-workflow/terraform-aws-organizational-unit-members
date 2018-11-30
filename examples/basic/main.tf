module "example" {
  source       = "../../"
  aws_profile  = "${var.aws_profile}"
  aws_region   = "${var.aws_region}"
  account_list = "${var.account_list}"
}
