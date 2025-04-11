#!/bin/bash

# AWS Image Builder Build Monitor Script for CITS3007
# This script follows the golden rule: NEVER GUESS A COMMAND. IF UNSURE, CHECK THE DOCS.

# Version information
SCRIPT_VERSION="0.5.0"
COMPONENT_VERSION="0.5.0"
IMAGE_RECIPE_VERSION="0.5.0"

set -e  # Exit on error

# Configuration
REGION="ap-southeast-2"
ACCOUNT_ID=$(aws sts get-caller-identity --query Account --output text)
IMAGE_RECIPE_NAME="cits3007-dev-environment"
S3_BUCKET_NAME="cits3007-image-builder-logs-${ACCOUNT_ID}"
LOG_GROUP_NAME="/aws/imagebuilder/cits3007-dev-environment"
LAST_TOKEN=""

# Logging function
log() {
    echo "[$(date '+%Y-%m-%d %H:%M:%S')] $1"
}

# Error handling function
handle_error() {
    log "ERROR: $1"
    exit 1
}

# Get CloudWatch logs
get_cloudwatch_logs() {
    local build_version=$1
    local build_id=$2
    local log_stream_name="${build_version}/${build_id}"
    local token_arg=""
    
    if [ -n "$LAST_TOKEN" ]; then
        token_arg="--next-token $LAST_TOKEN"
    fi
    
    # Get log events
    local log_output=$(aws logs get-log-events \
        --log-group-name "$LOG_GROUP_NAME" \
        --log-stream-name "$log_stream_name" \
        $token_arg \
        --region "$REGION" 2>/dev/null)
    
    if [ $? -eq 0 ]; then
        # Extract and store the next token
        LAST_TOKEN=$(echo "$log_output" | jq -r '.nextForwardToken')
        
        # Print log messages
        echo "$log_output" | jq -r '.events[] | "\(.timestamp) \(.message)"' 2>/dev/null | while read -r timestamp message; do
            if [ -n "$message" ]; then
                log "CloudWatch: $message"
            fi
        done
    else
        log "No CloudWatch logs available yet"
    fi
}

# Get the latest image build version ARN
get_latest_image_build_arn() {
    aws imagebuilder list-images \
        --filters "name=name,values=${IMAGE_RECIPE_NAME}" \
        --query "imageVersionList[0].arn" \
        --output text
}

# Get the build status
get_build_status() {
    local image_build_arn=$1
    aws imagebuilder get-image \
        --image-build-version-arn "$image_build_arn" \
        --query "image.state.status" \
        --output text
}

# Get the build progress
get_build_progress() {
    local image_build_arn=$1
    aws imagebuilder get-image \
        --image-build-version-arn "$image_build_arn" \
        --query "image.buildType" \
        --output text
}

# Get the output resources (AMI ID)
get_output_resources() {
    local image_build_arn=$1
    aws imagebuilder get-image \
        --image-build-version-arn "$image_build_arn" \
        --query "image.outputResources.amis[*].image" \
        --output text
}

# Get the failure reason if build failed
get_failure_reason() {
    local image_build_arn=$1
    aws imagebuilder get-image \
        --image-build-version-arn "$image_build_arn" \
        --query "image.state.reason" \
        --output text
}

# Get the build logs
get_build_logs() {
    local image_build_arn=$1
    local build_id=$(echo "$image_build_arn" | awk -F'/' '{print $NF}')
    
    # List log files
    aws s3 ls "s3://${S3_BUCKET_NAME}/logs/${IMAGE_RECIPE_NAME}/${IMAGE_RECIPE_VERSION}/${build_id}/" || return 1
    
    # Download the build log
    aws s3 cp "s3://${S3_BUCKET_NAME}/logs/${IMAGE_RECIPE_NAME}/${IMAGE_RECIPE_VERSION}/${build_id}/build.log" . || return 1
    
    # Display the last 20 lines of the build log
    tail -n 20 build.log
}

# Main monitoring loop
log "Starting build monitoring..."

# Check if image build version ARN is provided as an argument
if [ -n "$1" ]; then
    IMAGE_BUILD_ARN=$1
    log "Using provided image build ARN: $IMAGE_BUILD_ARN"
else
    # Get the latest image build version ARN
    IMAGE_BUILD_ARN=$(get_latest_image_build_arn)
    
    if [ -z "$IMAGE_BUILD_ARN" ] || [ "$IMAGE_BUILD_ARN" == "None" ]; then
        handle_error "No image build found. Please start a build first or provide an image build ARN."
    fi
    
    log "Using latest image build ARN: $IMAGE_BUILD_ARN"
fi

# Extract build version and ID from ARN
BUILD_VERSION=$(echo "$IMAGE_BUILD_ARN" | awk -F'/' '{print $(NF-1)}')
BUILD_ID=$(echo "$IMAGE_BUILD_ARN" | awk -F'/' '{print $NF}')

log "Monitoring image build: $IMAGE_BUILD_ARN"
log "Press Ctrl+C to stop monitoring"
log "----------------------------------------"

# Monitor the build status
while true; do
    STATUS=$(get_build_status "$IMAGE_BUILD_ARN")
    PROGRESS=$(get_build_progress "$IMAGE_BUILD_ARN")
    
    log "Status: $STATUS, Progress: $PROGRESS"
    
    case $STATUS in
        "PENDING")
            log "Build is pending..."
            get_cloudwatch_logs "$BUILD_VERSION" "$BUILD_ID"
            ;;
        "BUILDING")
            log "Build is in progress..."
            get_build_logs "$IMAGE_BUILD_ARN" || log "No S3 logs available yet"
            get_cloudwatch_logs "$BUILD_VERSION" "$BUILD_ID"
            ;;
        "TESTING")
            log "Build is being tested..."
            get_build_logs "$IMAGE_BUILD_ARN" || log "No S3 logs available yet"
            get_cloudwatch_logs "$BUILD_VERSION" "$BUILD_ID"
            ;;
        "DISTRIBUTING")
            log "Build is being distributed..."
            get_cloudwatch_logs "$BUILD_VERSION" "$BUILD_ID"
            ;;
        "COMPLETED")
            log "Build completed successfully!"
            AMI_ID=$(get_output_resources "$IMAGE_BUILD_ARN")
            log "AMI ID: $AMI_ID"
            get_build_logs "$IMAGE_BUILD_ARN" || log "No S3 logs available yet"
            get_cloudwatch_logs "$BUILD_VERSION" "$BUILD_ID"
            break
            ;;
        "FAILED")
            log "Build failed!"
            FAILURE_REASON=$(get_failure_reason "$IMAGE_BUILD_ARN")
            log "Failure reason: $FAILURE_REASON"
            get_build_logs "$IMAGE_BUILD_ARN" || log "No S3 logs available yet"
            get_cloudwatch_logs "$BUILD_VERSION" "$BUILD_ID"
            break
            ;;
        "CANCELLED")
            log "Build was cancelled!"
            get_cloudwatch_logs "$BUILD_VERSION" "$BUILD_ID"
            break
            ;;
        *)
            log "Unknown status: $STATUS"
            get_cloudwatch_logs "$BUILD_VERSION" "$BUILD_ID"
            ;;
    esac
    
    # Wait for 30 seconds before checking again
    sleep 30
done

log "----------------------------------------"
log "Build monitoring completed." 