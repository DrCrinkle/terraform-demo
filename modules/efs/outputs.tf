output "efs_dns" {
  value       = aws_efs_file_system.foo.dns_name

  depends_on  = [aws_efs_mount_target.alpha]
}

