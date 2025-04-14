#!/bin/bash

# Script to update Ansible inventory files with new server IPs
# Usage: ./update_inventory.sh <environment> <new_ip>

ENV=$1
NEW_IP=$2

if [ -z "$ENV" ] || [ -z "$NEW_IP" ]; then
    echo "Usage: $0 <environment> <new_ip>"
    echo "Environment must be: testing, staging, or production"
    exit 1
fi

if [[ ! "$ENV" =~ ^(testing|staging|production)$ ]]; then
    echo "Invalid environment. Must be: testing, staging, or production"
    exit 1
fi

# Update the main hosts file
HOSTS_FILE="ansible/inventory/hosts"
TEMP_HOSTS=$(mktemp)
while IFS= read -r line; do
    if [[ "$line" =~ ^\[$ENV\]$ ]]; then
        echo "$line" >> "$TEMP_HOSTS"
        echo "${ENV}-server ansible_host=${NEW_IP} ansible_user=root ansible_ssh_private_key_file=/Users/unixthat/.ssh/linodeKey" >> "$TEMP_HOSTS"
        read -r _ # skip the next line
    else
        echo "$line" >> "$TEMP_HOSTS"
    fi
done < "$HOSTS_FILE"
mv "$TEMP_HOSTS" "$HOSTS_FILE"

# Update the environment-specific inventory file
ENV_FILE="ansible/inventory/$ENV"
TEMP_ENV=$(mktemp)
while IFS= read -r line; do
    if [[ "$line" =~ ^\[$ENV\]$ ]]; then
        echo "$line" >> "$TEMP_ENV"
        echo "${ENV}-server ansible_host=${NEW_IP} ansible_user=root ansible_ssh_private_key_file=/Users/unixthat/.ssh/linodeKey" >> "$TEMP_ENV"
        read -r _ # skip the next line
    else
        echo "$line" >> "$TEMP_ENV"
    fi
done < "$ENV_FILE"
mv "$TEMP_ENV" "$ENV_FILE"

echo "Updated IP address for $ENV environment to $NEW_IP"

# Clean up backup files
rm -f ansible/inventory/hosts.bak "ansible/inventory/$ENV.bak" 