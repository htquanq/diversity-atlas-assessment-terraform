output "arn" {
  value = aws_autoscaling_group.main.arn
}

output "name" {
  value = aws_autoscaling_group.main.name
}

output "min_size" {
  value = aws_autoscaling_group.main.min_size
}

output "max_size" {
  value = aws_autoscaling_group.main.max_size
}

output "launch_configuration" {
  value = aws_autoscaling_group.main.launch_configuration
}

output "availability_zones" {
  value = aws_autoscaling_group.main.availability_zones
}