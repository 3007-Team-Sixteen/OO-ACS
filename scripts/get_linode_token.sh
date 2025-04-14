#!/bin/zsh
# =============================================================================
# Get Linode API Token from Keychain
# =============================================================================
# This script retrieves the Linode API token from the macOS keychain and exports
# it as an environment variable. It is designed to be sourced from .zprofile.
#
# Usage:
#   source get_linode_token.sh
#
# The token is stored in the keychain with:
#   - Service: "linode-api-token"
#   - Account: Current username
#
# If the token is not found, a warning is displayed but the script continues
# to allow for cases where the token might be set elsewhere.

# Get token from keychain
export LINODE_TOKEN=$(security find-generic-password -s "linode-api-token" -a "$USER" -w 2>/dev/null)

# Check if token was found
if [ -z "$LINODE_TOKEN" ]; then
    echo "Warning: Linode API token not found in keychain"
    # Don't exit with error as this might be sourced in .zprofile
fi 