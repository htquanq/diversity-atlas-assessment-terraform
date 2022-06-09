include "root" {
  # Include terragrunt.hcl from development folder
  path = find_in_parent_folders()
}

terraform {
  source = "${dirname(find_in_parent_folders())}/../../modules/vpc_peering"
}

dependency "vpc1"{
  config_path = "../vpc1"
}

dependency "vpc2" {
  config_path = "../vpc2"
}

inputs = {
  vpc_id = dependency.vpc1.outputs.id
  peer_vpc_id = dependency.vpc2.outputs.id
}