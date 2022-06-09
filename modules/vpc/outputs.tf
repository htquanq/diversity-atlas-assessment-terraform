output "id" {
  value = aws_vpc.main.id
}

output "arn" {
  value = aws_vpc.main.arn
}

output "main_route_table" {
  value = aws_vpc.main.main_route_table_id
}