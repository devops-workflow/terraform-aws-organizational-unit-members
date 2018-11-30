#!/usr/local/bin/bash
# #!/bin/bash
#
# This script is expected to be from Terraform via external provider
#
# Parameters:
#   aws_profile   AWS profile
#   account_list  List of accounts with OUs. Format: <account id>:<OU name>
#
# Assumptions:
#   There is only a single root
#   Only OUs off of root. No nested OUs
#   Accounts will either be in the correct OU or in the root
#

# Using Cloud formation & lambda
# https://theithollow.com/2018/09/10/create-aws-accounts-with-cloudformation/

set -e
eval "$(jq -r '@sh "aws_profile=\(.aws_profile) account_list=\(.account_list)"')"

#echo "profile: $aws_profile, OUs: $ou_list, Accounts: $account_list" > test.output

root_id=$(aws organizations list-roots --profile ${aws_profile} | jq -r .Roots[0].Id)

# Get current OU with with IDs
ou_exists_list=$(aws organizations list-organizational-units-for-parent --parent-id ${root_id} --profile ${aws_profile} | jq -r '.OrganizationalUnits[] | [.Name, .Id] | join(":")')
declare -A ou_lookup
for ou in ${ou_exists_list}; do
  ou_lookup["${ou%%:*}"]="${ou##*:}"
done

# ?? account_exists_list=$(aws organizations list-accounts --profile appzen-admin |jq -r .)
for account_ou in $(account_list); do
  # if account not exist, create - Done by terraform
  # if account not in ou then move - How to check
    # list-accounts-for-parent or list-children to check if account is in OU
    # if not, try root
    # if not, how to find - Future if not in terraform by then
  account="${account_ou%%:*}"
  ou="${account_ou##*:}"
  if [[ -v ou_lookup[${ou}] ]]; then
    accounts=$(aws organizations list-children --parent-id ${ou_lookup[${ou}]} --child-type ACCOUNT --profile ${aws_profile} | jq -r .Children[].Id)
    if [ $(echo ${accounts} | grep ${account} | wc -l) -eq 0 ]; then
      # account not in ou. Find and move
      if [ $(aws organizations list-children --parent-id ${root_id} --child-type ACCOUNT --profile ${aws_profile} | jq -r .Children[].Id | grep ${account} | wc -l) -eq 1 ]; then
        aws organizations move-account --account-id ${account} --source-parent-id ${root_id} --destination-parent-id ${ou_lookup[${ou}]} --profile ${aws_profile}
      fi
    fi
  fi
done

# OUs: core, environments
# What data should be outputted?
jq -n --arg aws_profile "$aws_profile" '{"aws_profile":$aws_profile}'
