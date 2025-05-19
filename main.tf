provider "aws" {
  alias  = "default"
  region = var.common_region
}

# Providers per dedicated region (dynamically created using for_each)
provider "aws" {
  for_each = {
    for user in var.participants : user.username => user.dedicated_region
  }

  alias  = each.key
  region = each.value
}

module "iam_and_ec2" {
  source = "./modules/user_env"
  for_each = {
    for user in var.participants : user.username => user
  }

  username         = each.value.username
  dedicated_region = each.value.dedicated_region
  common_region    = var.common_region
  ec2_instance_type = var.ec2_instance_type
  ami_lookup_name  = var.ami_lookup_name

  providers = {
    aws.dedicated = aws[each.key]
    aws.common    = aws.default
  }
}

