resource "aws_launch_template" "main" {
  name_prefix                          = "${var.name}-"
  image_id                             = var.image_id
  disable_api_termination              = var.disable_api_termination
  ebs_optimized                        = var.ebs_optimized
  instance_initiated_shutdown_behavior = var.instance_initiated_shutdown_behavior
  key_name                             = var.key_name
  instance_type                        = var.instance_type
  vpc_security_group_ids               = var.vpc_security_group_ids
  user_data                            = length(var.user_data) > 0 ? base64encode(var.user_data) : null
  update_default_version               = var.update_default_version
  tags                                 = merge({ "Name" : var.name }, var.tags)

  dynamic "cpu_options" {
    for_each = var.cpu_options

    content {
      core_count       = cpu_options.value.core_count
      threads_per_core = cpu_options.value.threads_per_core
    }
  }

  dynamic "block_device_mappings" {
    for_each = var.block_device_mappings

    content {
      device_name = lookup(block_device_mappings.value, "device_name", null)

      dynamic "ebs" {
        for_each = block_device_mappings.value.ebs

        content {
          volume_size           = lookup(ebs.value, "volume_size", null)
          delete_on_termination = lookup(ebs.value, "delete_on_termination", null)
          encrypted             = lookup(ebs.value, "encrypted", null)
          kms_key_id            = lookup(ebs.value, "kms_key_id", null)
          snapshot_id           = lookup(ebs.value, "snapshot_id", null)
          volume_type           = lookup(ebs.value, "volume_type", null)
        }
      }
    }
  }

  dynamic "credit_specification" {
    for_each = var.credit_specification

    content {
      cpu_credits = lookup(credit_specification.value, "cpu_credits", null)
    }
  }

  dynamic "iam_instance_profile" {
    for_each = var.iam_instance_profile

    content {
      name = iam_instance_profile.value.name
    }
  }

  dynamic "instance_market_options" {
    for_each = var.instance_market_options

    content {
      market_type = lookup(instance_market_options.value, "market_type", null)

      dynamic "spot_options" {
        for_each = instance_market_options.value.spot_options

        content {
          instance_interruption_behavior = lookup(spot_options.value, "instance_interruption_behavior", null)
          spot_instance_type             = lookup(spot_options.value, "spot_instance_type", null)
          valid_until                    = lookup(spot_options.value, "valid_until", null)
          max_price                      = lookup(spot_options.value, "max_price", null)
          block_duration_minutes         = lookup(spot_options.value, "block_duration_minutes", null)
        }
      }
    }
  }

  dynamic "monitoring" {
    for_each = var.monitoring

    content {
      enabled = lookup(monitoring.value, "enabled", null)
    }
  }

  dynamic "network_interfaces" {
    for_each = var.network_interfaces

    content {
      associate_public_ip_address = lookup(network_interfaces.value, "associate_public_ip_address", null)
      delete_on_termination       = lookup(network_interfaces.value, "delete_on_termination", true)
      device_index                = lookup(network_interfaces.value, "device_index", 0)
      security_groups             = lookup(network_interfaces.value, "security_groups", null)
    }
  }

  tag_specifications {
    resource_type = "volume"
    tags          = merge({ "Name" : var.name }, var.tags)
  }

  tag_specifications {
    resource_type = "instance"
    tags          = merge({ "Name" : var.name }, var.tags)
  }

  lifecycle {
    create_before_destroy = true
  }
}