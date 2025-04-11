#!/usr/bin/env bash
# Version: 1.0.0
# Description: Create AWS Image Builder component
# Purpose: Create the component for the CITS3007 development environment

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
COMPONENT_NAME="CITS3007DevEnvironment"
VERSION="1.0.0"
COMPONENT_FILE="components/cits3007-dev-environment.yaml"

# Function to create component
create_component() {
  print_status "$YELLOW" "Creating component $COMPONENT_NAME version $VERSION..."
  
  # Check if component file exists
  if [ ! -f "$COMPONENT_FILE" ]; then
    print_status "$RED" "Error: Component file $COMPONENT_FILE not found"
    exit 1
  fi
  
  # Create component
  aws imagebuilder create-component \
    --name "$COMPONENT_NAME" \
    --semantic-version "$VERSION" \
    --description "Development environment for CITS3007" \
    --platform "Linux" \
    --data "file://$COMPONENT_FILE"
  
  print_status "$GREEN" "Component created successfully"
}

# Main process
print_status "$YELLOW" "Starting component creation..."

# Create component
create_component

print_status "$GREEN" "Component creation completed successfully!"
print_status "$YELLOW" "Next step: Create the image recipe using: ./scripts/create-image-recipe.sh" 