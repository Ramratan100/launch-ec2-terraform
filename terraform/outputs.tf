output "apache_instance_public_ip" {
  value = aws_instance.apache_instance.public_ip
}

output "mysql_instance_private_ip" {
  value = aws_instance.mysql_instance.private_ip
}

output "instance_id" {
  value = aws_instance.example.id
}
