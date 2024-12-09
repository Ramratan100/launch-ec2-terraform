variable "instance_type" {
  description = "Type of EC2 instance"
  default     = "t2.micro"
}

variable "ami_id" {
  description = "AMI ID for the EC2 instance"
}

variable "key_name" {
  description = "The SSH key name for the EC2 instance"
}
