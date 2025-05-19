output "user_details" {
  value = merge(
    {
      for username, mod in module.iam_and_ec2_ireland : username => {
        iam_username       = mod.username
        initial_password   = mod.initial_password
        access_key_id      = mod.access_key
        secret_access_key  = mod.secret_key
        dedicated_region   = mod.dedicated_region
        ec2_public_ip      = mod.ec2_public_ip
        ssh_private_key    = "${path.root}/pem_keys/${username}.pem"
      }
    },
    {
      for username, mod in module.iam_and_ec2_london : username => {
        iam_username       = mod.username
        initial_password   = mod.initial_password
        access_key_id      = mod.access_key
        secret_access_key  = mod.secret_key
        dedicated_region   = mod.dedicated_region
        ec2_public_ip      = mod.ec2_public_ip
        ssh_private_key    = "${path.root}/pem_keys/${username}.pem"
      }
    },
    {
      for username, mod in module.iam_and_ec2_paris : username => {
        iam_username       = mod.username
        initial_password   = mod.initial_password
        access_key_id      = mod.access_key
        secret_access_key  = mod.secret_key
        dedicated_region   = mod.dedicated_region
        ec2_public_ip      = mod.ec2_public_ip
        ssh_private_key    = "${path.root}/pem_keys/${username}.pem"
      }
    }
  )
  sensitive = true
}

