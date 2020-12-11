output "url-my-flask" {
  value = "http://${aws_instance.example.public_ip}:5003"
}

output "instance_ip" {
  description = "The public ip for ssh access"
  value       = aws_instance.example.public_ip
}