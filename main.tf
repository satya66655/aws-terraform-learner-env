provider "aws" {
  alias  = "mumbai"
  region = var.common_region
}

provider "aws" {
  alias  = "ireland"
  region = "eu-west-1"
}

provider "aws" {
  alias  = "london"
  region = "eu-west-2"
}

provider "aws" {
  alias  = "paris"
  region = "eu-west-3"
}

# Separate participants per region
locals {
  ireland_users = { for user in var.participants : user.username => user if user.dedicated_region == "eu-west-1" }
  london_users  = { for user in var.participants : user.username => user if user.dedicated_region == "eu-west-2" }
  paris_users   = { for user in var.participants : user.username => user if user.dedicated_region == "eu-west-3" }
}

module "iam_and_ec2_ireland" {
  source = "./modules/user_env"

  for_each = local.ireland_users

  username          = each.value.username
  dedicated_region  = each.value.dedicated_region
  common_region     = var.common_region
  ec2_instance_type = var.ec2_instance_type
  ami_lookup_name   = var.ami_lookup_name

  providers = {
    aws.dedicated = aws.ireland
    aws.common    = aws.mumbai
  }
}

module "iam_and_ec2_london" {
  source = "./modules/user_env"

  for_each = local.london_users

  username          = each.value.username
  dedicated_region  = each.value.dedicated_region
  common_region     = var.common_region
  ec2_instance_type = var.ec2_instance_type
  ami_lookup_name   = var.ami_lookup_name

  providers = {
    aws.dedicated = aws.london
    aws.common    = aws.mumbai
  }
}

module "iam_and_ec2_paris" {
  source = "./modules/user_env"

  for_each = local.paris_users

  username          = each.value.username
  dedicated_region  = each.value.dedicated_region
  common_region     = var.common_region
  ec2_instance_type = var.ec2_instance_type
  ami_lookup_name   = var.ami_lookup_name

  providers = {
    aws.dedicated = aws.paris
    aws.common    = aws.mumbai
  }
}

