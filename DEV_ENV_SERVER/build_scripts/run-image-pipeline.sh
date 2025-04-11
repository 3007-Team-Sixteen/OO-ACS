#!/usr/bin/env bash
# Version: 1.0.0
# Description: Run AWS Image Builder image pipeline
# Purpose: Run the image pipeline for the CITS3007 development environment

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
PIPELINE_NAME="CITS3007DevEnvironment"

# Function to run image pipeline
run_image_pipeline() {
  print_status "$YELLOW" "Running image pipeline $PIPELINE_NAME..."
  
  # Start the pipeline
  BUILD_ID=$(aws imagebuilder start-image-pipeline-execution \
    --image-pipeline-arn "arn:aws:imagebuilder:${AWS_REGION}:$(aws sts get-caller-identity --query Account --output text):imagePipeline/${PIPELINE_NAME}" \
    --query "imageBuildVersionArn" \
    --output text)
  
  print_status "$GREEN" "Pipeline started successfully with build ID: $BUILD_ID"
  
  # Monitor the build
  print_status "$YELLOW" "Monitoring build progress..."
  
  while true; do
    STATUS=$(aws imagebuilder get-image-build-version \
      --image-build-version-arn "$BUILD_ID" \
      --query "image.state.status" \
      --output text)
    
    case "$STATUS" in
      "PENDING")
        print_status "$YELLOW" "Build is pending..."
        ;;
      "BUILDING")
        print_status "$YELLOW" "Build is in progress..."
        ;;
      "TESTING")
        print_status "$YELLOW" "Build is being tested..."
        ;;
      "DISTRIBUTING")
        print_status "$YELLOW" "Build is being distributed..."
        ;;
      "INTEGRATED")
        print_status "$GREEN" "Build completed successfully!"
        break
        ;;
      "AVAILABLE")
        print_status "$GREEN" "Build is available!"
        break
        ;;
      "FAILED")
        print_status "$RED" "Build failed!"
        exit 1
        ;;
      "CANCELLED")
        print_status "$RED" "Build was cancelled!"
        exit 1
        ;;
      *)
        print_status "$RED" "Unknown build status: $STATUS"
        exit 1
        ;;
    esac
    
    sleep 60
  done
  
  # Get the AMI ID
  AMI_ID=$(aws imagebuilder get-image-build-version \
    --image-build-version-arn "$BUILD_ID" \
    --query "image.outputResources.amis[0].image" \
    --output text)
  
  print_status "$GREEN" "Build completed successfully!"
  print_status "$GREEN" "AMI ID: $AMI_ID"
}

# Main process
print_status "$YELLOW" "Starting image pipeline execution..."

# Run image pipeline
run_image_pipeline

print_status "$GREEN" "Image pipeline execution completed successfully!"
print_status "$YELLOW" "You can now launch an EC2 instance using the AMI ID: $AMI_ID" 