/*
data "external" "organizational_unit_members" {
  program = ["bash", "${path.module}/scripts/ou.sh"]

  query = {
    aws_profile = "${var.aws_profile}"
    account_list     = "${var.account_list}"
  }
}
/**/

resource "null_resource" "organizational_unit_members" {
  triggers = {
    aws_profile  = "${var.aws_profile}"
    account_list = "${var.account_list}"
  }

  provisioner "local-exec" {
    command = "echo '${jsonencode(map("aws_profile", var.aws_profile, "account_list", var.account_list))}' | bash -c ${path.module}/scripts/ou.sh"
  }
}
