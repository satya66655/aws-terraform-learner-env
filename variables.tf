variable "participants" {
  description = "List of participants with their usernames and assigned regions"
  type = list(object({
    username        = string
    dedicated_region = string
  }))
}

variable "common_region" {
  description = "Shared region for all participants"
  type        = string
  default     = "ap-south-1"
}

variable "ec2_instance_type" {
  description = "Instance type for EC2"
  type        = string
  default     = "t3.micro"
}

variable "ami_lookup_name" {
  description = "AMI name filter for Amazon Linux 2023"
  type        = string
  default     = "al2023-ami-*-x86_64"
}

