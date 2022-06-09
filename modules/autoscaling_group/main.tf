resource "aws_autoscaling_group" "main" {
  name                = var.name
  min_size            = var.min_size
  max_size            = var.max_size
  desired_capacity    = var.desired_capacity
  vpc_zone_identifier = var.vpc_zone_identifier
  health_check_type   = var.health_check_type
  #  tags = var.tags
  termination_policies = length(var.termination_policies) > 0 ? var.termination_policies : null
  suspended_processes  = length(var.suspended_processes) > 0 ? var.suspended_processes : null

  protect_from_scale_in = var.protect_from_scale_in
  dynamic "mixed_instances_policy" {
    for_each = var.mixed_instances_policy

    content {
      dynamic "instances_distribution" {
        for_each = lookup(mixed_instances_policy.value, "instances_distribution", [])

        content {
          on_demand_base_capacity                  = lookup(instances_distribution.value, "on_demand_base_capacity", null)
          on_demand_percentage_above_base_capacity = lookup(instances_distribution.value, "on_demand_percentage_above_base_capacity", null)
          spot_allocation_strategy                 = lookup(instances_distribution.value, "spot_allocation_strategy", null)
          spot_instance_pools                      = lookup(instances_distribution.value, "spot_instance_pools", 2)
          spot_max_price                           = lookup(instances_distribution.value, "spot_max_price", "")
        }
      }

      dynamic "launch_template" {
        for_each = lookup(mixed_instances_policy.value, "launch_template", [])

        content {
          launch_template_specification {
            launch_template_id = lookup(launch_template.value, "launch_template_id", null)
          }

          dynamic "override" {
            for_each = lookup(launch_template.value, "override", [])

            content {
              instance_type     = lookup(override.value, "instance_type", null)
              weighted_capacity = lookup(override.value, "weighted_capacity", null)
            }
          }
        }
      }
    }
  }

  dynamic "launch_template" {
    for_each = var.launch_template

    content {
      id      = lookup(launch_template.value, "id", null)
      version = lookup(launch_template.value, "version", "$Latest")
    }
  }

  dynamic "instance_refresh" {
    for_each = try(length(var.instance_refresh) > 0 ? [var.instance_refresh] : [], [])

    content {
      strategy = "Rolling"

      dynamic "preferences" {
        for_each = try(length(instance_refresh.value.preferences) > 0 ? [instance_refresh.value.preferences] : [], [])

        content {
          instance_warmup        = try(preferences.value.instance_warmup, 30)
          min_healthy_percentage = try(preferences.value.min_healthy_percentage, 50)
        }
      }

      triggers = try(instance_refresh.value.triggers, ["launch_configuration", "launch_template", "mixed_instances_policy"])
    }
  }

  lifecycle {
    create_before_destroy = true
  }
}
