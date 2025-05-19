output "username" {
  value = var.username
}

output "dedicated_region" {
  value = var.dedicated_region
}

output "initial_password" {
  value = aws_iam_user_login_profile.login.password
  sensitive = true
}

output "access_key" {
  value = aws_iam_access_key.key.id
  sensitive = true
}

output "secret_key" {
  value = aws_iam_access_key.key.secret
  sensitive = true
}

output "ec2_public_ip" {
  value = aws_instance.linux_ec2.public_ip
}

output "pem_content" {
  value     = tls_private_key.ssh_key.private_key_pem
  sensitive = true
}

