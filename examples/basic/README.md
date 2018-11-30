# terraform-aws-organizational-unit-members: basic

Configuration in this directory moves some member accounts to organizational units

## Usage

Create a terraform.tfvars file with your settings

Then to run this example you need to execute:

```bash
terraform init
terraform plan
terraform apply
```

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|:----:|:-----:|:-----:|
| account\_list | List of member account and organizational units they should be into. Format: {account id}:{ou name} {account id}:{ou name} | string | - | yes |
| aws\_profile | AWS profile in local credentials file that has rights to master account | string | - | yes |
| aws\_region | AWS region | string | `us-east-1` | no |

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
