#!/bin/bash

# Script to update Ansible inventory files and SSH config with new server IPs
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
        echo "${ENV}-server ansible_host=oo-acs-${ENV} ansible_user=root" >> "$TEMP_HOSTS"
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
        echo "${ENV}-server ansible_host=oo-acs-${ENV} ansible_user=root" >> "$TEMP_ENV"
        read -r _ # skip the next line
    else
        echo "$line" >> "$TEMP_ENV"
    fi
done < "$ENV_FILE"
mv "$TEMP_ENV" "$ENV_FILE"

# Update SSH config
SSH_CONFIG="$HOME/.ssh/config"
TEMP_SSH=$(mktemp)
IN_HOST_BLOCK=0
UPDATED=0

while IFS= read -r line || [ -n "$line" ]; do
    if [[ "$line" =~ ^Host[[:space:]]+oo-acs-$ENV$ ]]; then
        IN_HOST_BLOCK=1
        UPDATED=1
        echo "$line" >> "$TEMP_SSH"
    elif [[ "$line" =~ ^Host[[:space:]] ]]; then
        IN_HOST_BLOCK=0
        echo "$line" >> "$TEMP_SSH"
    elif [ $IN_HOST_BLOCK -eq 1 ]; then
        if [[ "$line" =~ ^[[:space:]]*HostName ]]; then
            echo "    HostName $NEW_IP" >> "$TEMP_SSH"
        elif [[ "$line" =~ ^[[:space:]]*IdentityFile ]]; then
            echo "    IdentityFile $HOME/.ssh/oo-acs-$ENV" >> "$TEMP_SSH"
        elif [[ ! "$line" =~ ^[[:space:]]*(StrictHostKeyChecking|UserKnownHostsFile) ]]; then
            echo "$line" >> "$TEMP_SSH"
        fi
    else
        echo "$line" >> "$TEMP_SSH"
    fi
done < "$SSH_CONFIG"

# If the host block wasn't found, add it
if [ $UPDATED -eq 0 ]; then
    echo "" >> "$TEMP_SSH"
    echo "Host oo-acs-$ENV" >> "$TEMP_SSH"
    echo "    HostName $NEW_IP" >> "$TEMP_SSH"
    echo "    User root" >> "$TEMP_SSH"
    echo "    IdentityFile $HOME/.ssh/oo-acs-$ENV" >> "$TEMP_SSH"
fi

mv "$TEMP_SSH" "$SSH_CONFIG"
chmod 600 "$SSH_CONFIG"

echo "Updated IP address for $ENV environment to $NEW_IP in both inventory and SSH config"

# Clean up backup files
rm -f ansible/inventory/hosts.bak "ansible/inventory/$ENV.bak" 