#!/bin/bash
# =============================================================================
# Store Linode API Token in Keychain
# =============================================================================
# This script securely stores a Linode API token in the macOS keychain.
# After storing the token, the script deletes itself for security.
#
# Usage:
#   ./store_linode_token.sh <token>
#
# The token is stored in the keychain with:
#   - Service: "linode-api-token"
#   - Account: Current username
#
# Security Note:
#   - The script deletes itself after execution to prevent token exposure
#   - The token is stored securely in the macOS keychain
#   - The token should be passed as a command-line argument, not hardcoded

# Check if token is provided
if [ -z "$1" ]; then
    echo "Usage: $0 <linode-token>"
    exit 1
fi

# Store token in keychain
security add-generic-password -a "$USER" -s "linode-api-token" -w "$1"

echo "Linode token stored in keychain"

# Delete this script for security
SCRIPT_PATH="$(realpath "$0")"
rm "$SCRIPT_PATH" 