variable "aws_region" {
  default = "us-east-1"
}

variable "vpc_name" {
  default = "launch-ec2-vpc"
}

variable "vpc_cidr_block" {
  default = "10.0.0.0/16"
}

variable "instance_type" {
  default = "t2.micro"
}

variable "apache_ami" {
  description = "AMI for Apache Web Server"
  default     = "ami-0c55b159cbfafe1f0"  # Update with correct Apache AMI
}

variable "mysql_ami" {
  description = "AMI for MySQL Database"
  default     = "ami-0c55b159cbfafe1f0"  # Update with correct MySQL AMI
}
