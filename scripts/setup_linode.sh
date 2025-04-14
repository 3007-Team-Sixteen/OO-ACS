#!/bin/bash
# =============================================================================
# Linode Instance Setup Script
# =============================================================================
# This script creates a new Linode instance and configures it for the OO-ACS project.
# It requires the Linode CLI to be installed and configured with an API token.
#
# Usage:
#   ./setup_linode.sh
#
# Prerequisites:
#   - Linode CLI installed and configured
#   - LINODE_TOKEN environment variable set
#   - SSH public key available at ~/.ssh/id_ed25519.pub
#
# The script will:
#   1. Create a new Linode instance (g6-nanode-1)
#   2. Wait for the instance to be ready
#   3. Update the Ansible inventory with the new instance IP
#
# Security:
#   - Generates a random root password
#   - Configures SSH key authentication
#   - Tags the instance for identification

# Check if LINODE_TOKEN is set
if [ -z "$LINODE_TOKEN" ]; then
    echo "Please set your LINODE_TOKEN environment variable"
    exit 1
fi

# Explicitly set LINODE_CLI_TOKEN for the CLI
export LINODE_CLI_TOKEN=$LINODE_TOKEN

# Create Linode instance
echo "Creating Linode instance..."
INSTANCE_ID=$(linode-cli linodes create \
    --type g6-nanode-1 \
    --region us-east \
    --image linode/ubuntu20.04 \
    --root_pass "$(openssl rand -base64 32)" \
    --authorized_keys "$(cat ~/.ssh/id_ed25519.pub)" \
    --label "oo-acs-testing" \
    --tags "testing,oo-acs" \
    --json | jq -r '.[0].id')

# Wait for instance to be running
echo "Waiting for instance to be ready..."
while [ "$(linode-cli linodes view $INSTANCE_ID --json | jq -r '.[0].status')" != "running" ]; do
    sleep 5
done

# Get instance IP
IP_ADDRESS=$(linode-cli linodes view $INSTANCE_ID --json | jq -r '.[0].ipv4[0]')

# Update Ansible inventory
echo "Updating Ansible inventory..."
cat > ansible/inventory/testing << EOF
[testing]
testing.oo-acs ansible_host=$IP_ADDRESS ansible_user=root

[all:vars]
ansible_python_interpreter=/usr/bin/python3
EOF

echo "Instance IP: $IP_ADDRESS"
echo "Setup complete! Wait a few minutes for the system to finish booting before running Ansible." 