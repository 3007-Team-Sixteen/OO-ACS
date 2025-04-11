#!/usr/bin/env bash
# Version: 1.0.0
# Description: Create AWS Image Builder image pipeline
# Purpose: Create the image pipeline for the CITS3007 development environment

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
PIPELINE_NAME="CITS3007DevEnvironment"
VERSION="1.0.0"
RECIPE_NAME="CITS3007DevEnvironment"
RECIPE_VERSION="1.0.0"
INFRA_CONFIG_NAME="CITS3007DevEnvironment"
DIST_CONFIG_NAME="CITS3007DevEnvironment"

# Function to create image pipeline
create_image_pipeline() {
  print_status "$YELLOW" "Creating image pipeline $PIPELINE_NAME version $VERSION..."
  
  # Get recipe ARN
  RECIPE_ARN="arn:aws:imagebuilder:${AWS_REGION}:${ACCOUNT_ID}:imageRecipe/${RECIPE_NAME}/${RECIPE_VERSION}"
  
  # Get infrastructure configuration ARN
  INFRA_CONFIG_ARN="arn:aws:imagebuilder:${AWS_REGION}:${ACCOUNT_ID}:infrastructure-configuration/${INFRA_CONFIG_NAME}"
  
  # Get distribution configuration ARN
  DIST_CONFIG_ARN="arn:aws:imagebuilder:${AWS_REGION}:${ACCOUNT_ID}:distribution-configuration/${DIST_CONFIG_NAME}"
  
  # Create image pipeline
  aws imagebuilder create-image-pipeline \
    --name "$PIPELINE_NAME" \
    --description "Development environment pipeline for CITS3007" \
    --image-recipe-arn "$RECIPE_ARN" \
    --infrastructure-configuration-arn "$INFRA_CONFIG_ARN" \
    --distribution-configuration-arn "$DIST_CONFIG_ARN" \
    --image-tests-configuration "{\"imageTestsEnabled\":true,\"timeoutMinutes\":60}" \
    --schedule "{\"pipelineExecutionStartCondition\":\"EXPRESSION_MATCH_AND_DEPENDENCY_UPDATES_AVAILABLE\",\"scheduleExpression\":\"cron(0 0 ? * SUN *)\"}" \
    --status "ENABLED"
  
  print_status "$GREEN" "Image pipeline created successfully"
}

# Main process
print_status "$YELLOW" "Starting image pipeline creation..."

# Create image pipeline
create_image_pipeline

print_status "$GREEN" "Image pipeline creation completed successfully!"
print_status "$YELLOW" "Next step: Run the pipeline using: ./scripts/run-image-pipeline.sh" 