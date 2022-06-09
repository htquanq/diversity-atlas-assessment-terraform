inputs = yamldecode(file("${dirname(find_in_parent_folders())}/../../configs/development/rds_launch_template.yaml"))

include "root" {
  # Include terragrunt.hcl from development folder
  path = find_in_parent_folders()
}

terraform {
  source = "${dirname(find_in_parent_folders())}/../../modules/launch_template"
}