#!/usr/bin/env bash
# Version: 1.0.0
# Description: Create AWS Image Builder image recipe
# Purpose: Create the image recipe for the CITS3007 development environment

set -x
set -euo pipefail

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
NC='\033[0m' # No Color

# Function to print colored output
print_status() {
  local color=$1
  local message=$2
  echo -e "${color}${message}${NC}"
}

# Configuration
AWS_REGION="ap-southeast-2"
ACCOUNT_ID=$(aws sts get-caller-identity --query Account --output text)
RECIPE_NAME="CITS3007DevEnvironment"
VERSION="1.0.0"
COMPONENT_NAME="CITS3007DevEnvironment"
COMPONENT_VERSION="1.0.0"

# Function to create image recipe
create_image_recipe() {
  print_status "$YELLOW" "Creating image recipe $RECIPE_NAME version $VERSION..."
  
  # Get component ARN
  COMPONENT_ARN="arn:aws:imagebuilder:${AWS_REGION}:${ACCOUNT_ID}:component/${COMPONENT_NAME}/${COMPONENT_VERSION}/1"
  
  # Create image recipe
  aws imagebuilder create-image-recipe \
    --name "$RECIPE_NAME" \
    --semantic-version "$VERSION" \
    --description "Development environment for CITS3007" \
    --platform "Linux" \
    --base-image "arn:aws:imagebuilder:${AWS_REGION}:aws:image/ubuntu-base-20/x86/x64/standard/base" \
    --components "[{\"componentArn\":\"${COMPONENT_ARN}\"}]" \
    --working-directory "/tmp" \
    --block-device-mappings "[{\"deviceName\":\"/dev/sda1\",\"ebs\":{\"volumeSize\":20,\"volumeType\":\"gp2\",\"deleteOnTermination\":true}}]"
  
  print_status "$GREEN" "Image recipe created successfully"
}

# Main process
print_status "$YELLOW" "Starting image recipe creation..."

# Create image recipe
create_image_recipe

print_status "$GREEN" "Image recipe creation completed successfully!"
print_status "$YELLOW" "Next step: Create the image pipeline using: ./scripts/create-image-pipeline.sh" 