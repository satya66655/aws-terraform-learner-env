#!/bin/bash

echo "Generating credentials from terraform output..."

mkdir -p output
mkdir -p pem_keys

terraform output -json user_details > output/user_details.json

jq -r 'to_entries[] | [.value.iam_username, .value.initial_password, .value.access_key_id, .value.secret_access_key, .value.dedicated_region, .value.ec2_public_ip, .value.ssh_private_key] | @csv' output/user_details.json \
  > output/user_creds.csv

echo "Extracting PEM keys..."
jq -r 'to_entries[] | [.key, .value.ssh_private_key] | @tsv' output/user_details.json | while IFS=$'\t' read -r user key; do
  echo "$key" > pem_keys/${user}.pem
  chmod 400 pem_keys/${user}.pem
done

echo "Saved credentials to output/user_creds.csv and pem_keys/"

