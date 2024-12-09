provider "aws" {
  region = "us-west-2"  # Update with your AWS region
}

resource "aws_security_group" "web_sg" {
  name        = "web-sg"
  description = "Allow inbound HTTP, HTTPS, and SSH traffic"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_instance" "web_server" {
  ami             = "ami-005fc0f236362e99f"  # Replace with your preferred Amazon Linux 2 AMI ID
  instance_type   = "t2.micro"
  key_name        = "jenkins"   # Replace with your SSH key name
  security_groups = [aws_security_group.web_sg.name]

  user_data = file("provision/install_apache_php_mysql.sh")

  tags = {
    Name = "WebServer"
  }
}

output "instance_public_ip" {
  value = aws_instance.web_server.public_ip
}

output "instance_public_dns" {
  value = aws_instance.web_server.public_dns
}
