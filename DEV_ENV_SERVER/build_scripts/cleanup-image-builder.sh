#!/usr/bin/env bash
# Version: 1.0.0
# Description: Cleanup script for AWS Image Builder resources
# Purpose: Remove all existing AWS Image Builder resources to prepare for a clean installation

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

# Function to check if a resource exists
resource_exists() {
  local resource_type=$1
  local resource_name=$2
  
  case $resource_type in
    "component")
      aws imagebuilder list-components --filters "name=name,values=$resource_name" | grep -q "$resource_name"
      ;;
    "recipe")
      aws imagebuilder list-image-recipes --filters "name=name,values=$resource_name" | grep -q "$resource_name"
      ;;
    "pipeline")
      aws imagebuilder list-image-pipelines --filters "name=name,values=$resource_name" | grep -q "$resource_name"
      ;;
    "infrastructure")
      aws imagebuilder list-infrastructure-configurations --filters "name=name,values=$resource_name" | grep -q "$resource_name"
      ;;
    "distribution")
      aws imagebuilder list-distribution-configurations --filters "name=name,values=$resource_name" | grep -q "$resource_name"
      ;;
    *)
      return 1
      ;;
  esac
  
  return $?
}

# Function to get resource ARN
get_resource_arn() {
  local resource_type=$1
  local resource_name=$2
  
  case $resource_type in
    "component")
      aws imagebuilder list-components --filters "name=name,values=$resource_name" --query "componentVersionList[0].arn" --output text
      ;;
    "recipe")
      aws imagebuilder list-image-recipes --filters "name=name,values=$resource_name" --query "imageRecipeSummaryList[0].arn" --output text
      ;;
    "pipeline")
      aws imagebuilder list-image-pipelines --filters "name=name,values=$resource_name" --query "imagePipelineList[0].arn" --output text
      ;;
    "infrastructure")
      aws imagebuilder list-infrastructure-configurations --filters "name=name,values=$resource_name" --query "infrastructureConfigurationSummaryList[0].arn" --output text
      ;;
    "distribution")
      aws imagebuilder list-distribution-configurations --filters "name=name,values=$resource_name" --query "distributionConfigurationSummaryList[0].arn" --output text
      ;;
    *)
      return 1
      ;;
  esac
}

# Function to delete a resource
delete_resource() {
  local resource_type=$1
  local resource_name=$2
  
  if resource_exists "$resource_type" "$resource_name"; then
    print_status "$YELLOW" "Deleting $resource_type: $resource_name"
    
    local resource_arn=$(get_resource_arn "$resource_type" "$resource_name")
    
    if [ -n "$resource_arn" ] && [ "$resource_arn" != "None" ]; then
      case $resource_type in
        "component")
          aws imagebuilder delete-component --component-build-version-arn "$resource_arn"
          ;;
        "recipe")
          aws imagebuilder delete-image-recipe --image-recipe-arn "$resource_arn"
          ;;
        "pipeline")
          aws imagebuilder delete-image-pipeline --image-pipeline-arn "$resource_arn"
          ;;
        "infrastructure")
          aws imagebuilder delete-infrastructure-configuration --infrastructure-configuration-arn "$resource_arn"
          ;;
        "distribution")
          aws imagebuilder delete-distribution-configuration --distribution-configuration-arn "$resource_arn"
          ;;
      esac
      
      print_status "$GREEN" "Successfully deleted $resource_type: $resource_name"
    else
      print_status "$RED" "Failed to get ARN for $resource_type: $resource_name"
    fi
  else
    print_status "$YELLOW" "$resource_type $resource_name does not exist, skipping"
  fi
}

# Main cleanup process
print_status "$YELLOW" "Starting cleanup of AWS Image Builder resources..."

# Resource names
RESOURCE_NAME="CITS3007DevEnvironment"

# Delete resources in the correct order (dependencies first)
print_status "$YELLOW" "Deleting image pipelines..."
delete_resource "pipeline" "$RESOURCE_NAME"

print_status "$YELLOW" "Deleting image recipes..."
delete_resource "recipe" "$RESOURCE_NAME"

print_status "$YELLOW" "Deleting components..."
delete_resource "component" "$RESOURCE_NAME"

print_status "$YELLOW" "Deleting infrastructure configurations..."
delete_resource "infrastructure" "$RESOURCE_NAME"

print_status "$YELLOW" "Deleting distribution configurations..."
delete_resource "distribution" "$RESOURCE_NAME"

# Check for any remaining images
print_status "$YELLOW" "Checking for any remaining images..."
IMAGE_ARNS=$(aws imagebuilder list-images --filters "name=name,values=$RESOURCE_NAME" --query "imageVersionList[].arn" --output text)

if [ -n "$IMAGE_ARNS" ]; then
  print_status "$YELLOW" "Deleting remaining images..."
  for IMAGE_ARN in $IMAGE_ARNS; do
    print_status "$YELLOW" "Deleting image: $IMAGE_ARN"
    aws imagebuilder delete-image --image-build-version-arn "$IMAGE_ARN"
  done
else
  print_status "$YELLOW" "No remaining images found"
fi

print_status "$GREEN" "Cleanup completed successfully!" 