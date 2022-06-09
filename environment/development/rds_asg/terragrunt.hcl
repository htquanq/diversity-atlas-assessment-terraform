include "root" {
  # Include terragrunt.hcl from development folder
  path = find_in_parent_folders()
}

terraform {
  source = "${dirname(find_in_parent_folders())}/../../modules/autoscaling_group"
}

dependency "launch_template"{
  config_path = "../rds_launch_template"
}

dependency "vpc1" {
  config_path = "../vpc1"
}

inputs = merge(
  file("${dirname(find_in_parent_folders())}/../../configs/development/rds_asg.yaml"),
  {
    vpc_zone_identifier = dependency.vpc1.outputs.id
  },
  {
    launch_template = [
      {
        id = dependency.launch_template.outputs.id
      }
    ]
  }
)