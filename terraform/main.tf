provider "aws" {
  region = "us-east-1"
}

resource "aws_instance" "example" {
  ami           = "ami-0c55b159cbfafe1f0"  # Example AMI ID
  instance_type = "t2.micro"
}

module "vpc" {
  source = "terraform-aws-modules/vpc/aws"
  name = var.vpc_name
  cidr = var.vpc_cidr_block
  enable_dns_support = true
  enable_dns_hostnames = true
  enable_nat_gateway = true
  enable_vpn_gateway = false
}

resource "aws_security_group" "apache_sg" {
  name        = "apache_sg"
  description = "Allow Apache traffic"
  vpc_id      = module.vpc.vpc_id

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 22
    to_port     = 22
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

resource "aws_security_group" "mysql_sg" {
  name        = "mysql_sg"
  description = "Allow MySQL traffic from Apache"
  vpc_id      = module.vpc.vpc_id

  ingress {
    from_port   = 3306
    to_port     = 3306
    protocol    = "tcp"
    cidr_blocks = [module.vpc.vpc_cidr_block]  # Allow access from within the VPC
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_instance" "apache_instance" {
  ami                    = var.apache_ami
  instance_type          = var.instance_type
  subnet_id              = module.vpc.public_subnets[0]
  security_group_ids     = [aws_security_group.apache_sg.id]
  associate_public_ip_address = true
  user_data              = file("provision/install_apache_php_mysql.sh")

  tags = {
    Name = "Apache Web Server"
  }
}

resource "aws_instance" "mysql_instance" {
  ami                    = var.mysql_ami
  instance_type          = var.instance_type
  subnet_id              = module.vpc.private_subnets[0]
  security_group_ids     = [aws_security_group.mysql_sg.id]
  associate_public_ip_address = false
  user_data              = file("provision/install_apache_php_mysql.sh")

  tags = {
    Name = "MySQL Database"
  }
}
