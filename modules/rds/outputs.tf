output "rds_endpoint" {
  value = aws_rds_cluster.main.endpoint
}

output "rds_port" {
  value = aws_rds_cluster.main.port
}

output "rds_username" {
  value = aws_rds_cluster.main.master_username
}

output "rds_password" {
  value     = aws_rds_cluster.main.master_password
  sensitive = true
}
