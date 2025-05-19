data "aws_ami" "amazon_linux" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = [var.ami_lookup_name]
  }

  filter {
    name   = "architecture"
    values = ["x86_64"]
  }

  provider = aws.dedicated
}

resource "tls_private_key" "ssh_key" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "aws_key_pair" "user_key" {
  key_name   = "${var.username}-key"
  public_key = tls_private_key.ssh_key.public_key_openssh

  provider = aws.dedicated
}

resource "aws_instance" "linux_ec2" {
  ami           = data.aws_ami.amazon_linux.id
  instance_type = var.ec2_instance_type
  key_name      = aws_key_pair.user_key.key_name

  tags = {
    Name = var.username
  }

  provider = aws.dedicated
}

