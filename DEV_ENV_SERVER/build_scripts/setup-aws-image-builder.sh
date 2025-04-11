#!/usr/bin/env bash
# Version: 1.0.0
# Description: Comprehensive AWS Image Builder setup script
# Purpose: Create and configure all AWS Image Builder resources in one go

set -euo pipefail

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Function to print colored output
print_status() {
  local color=$1
  local message=$2
  echo -e "${color}${message}${NC}"
}

# Function to check if a command exists
command_exists() {
  command -v "$1" >/dev/null 2>&1
}

# Function to check if a resource exists
resource_exists() {
  local resource_type="$1"
  local resource_name="$2"
  local region="$3"
  local account_id="$4"
  local resource_name_lower=$(echo "$resource_name" | tr '[:upper:]' '[:lower:]')
  
  case "$resource_type" in
    "bucket")
      aws s3api head-bucket --bucket "$resource_name" 2>/dev/null
      return $?
      ;;
    "role")
      aws iam get-role --role-name "$resource_name" 2>/dev/null
      return $?
      ;;
    "instance-profile")
      aws iam get-instance-profile --instance-profile-name "$resource_name" 2>/dev/null
      return $?
      ;;
    "infrastructure-config")
      aws imagebuilder list-infrastructure-configurations | grep -i "\"name\": *\"$resource_name\"" >/dev/null 2>&1
      return $?
      ;;
    "distribution-config")
      aws imagebuilder list-distribution-configurations | grep -i "\"name\": *\"$resource_name\"" >/dev/null 2>&1
      return $?
      ;;
    "component")
      aws imagebuilder list-components | grep -i "\"name\": *\"$resource_name\"" >/dev/null 2>&1
      return $?
      ;;
    "recipe")
      aws imagebuilder list-image-recipes | grep -i "\"name\": *\"$resource_name\"" >/dev/null 2>&1
      return $?
      ;;
    "pipeline")
      aws imagebuilder list-image-pipelines | grep -i "\"name\": *\"$resource_name\"" >/dev/null 2>&1
      return $?
      ;;
    *)
      print_status "$RED" "Unknown resource type: $resource_type"
      return 1
      ;;
  esac
}

# Function to validate AWS CLI
validate_aws_cli() {
  print_status "$YELLOW" "Validating AWS CLI..."
  
  if ! command_exists aws; then
    print_status "$RED" "AWS CLI is not installed. Please install it first."
    exit 1
  fi
  
  if ! aws sts get-caller-identity &>/dev/null; then
    print_status "$RED" "AWS credentials are not configured. Please run 'aws configure' first."
    exit 1
  fi
  
  print_status "$GREEN" "AWS CLI validation successful."
}

# Function to create S3 bucket
create_s3_bucket() {
  local bucket_name="$1"
  local region="$2"
  
  print_status "$YELLOW" "Creating S3 bucket for logs: $bucket_name..."
  
  if resource_exists "bucket" "$bucket_name" "$region" "$ACCOUNT_ID"; then
    print_status "$YELLOW" "Bucket $bucket_name already exists."
  else
    aws s3api create-bucket \
      --bucket "$bucket_name" \
      --region "$region" \
      --create-bucket-configuration LocationConstraint="$region"
    
    # Configure bucket for Image Builder logs
    aws s3api put-bucket-policy \
      --bucket "$bucket_name" \
      --policy "{
        \"Version\": \"2012-10-17\",
        \"Statement\": [
          {
            \"Sid\": \"AllowImageBuilder\",
            \"Effect\": \"Allow\",
            \"Principal\": {
              \"Service\": \"imagebuilder.amazonaws.com\"
            },
            \"Action\": \"s3:PutObject\",
            \"Resource\": \"arn:aws:s3:::${bucket_name}/*\"
          }
        ]
      }"
    
    print_status "$GREEN" "S3 bucket created successfully."
  fi
}

# Function to create IAM role
create_iam_role() {
  local role_name="$1"
  local instance_profile_name="$2"
  
  print_status "$YELLOW" "Creating IAM role: $role_name..."
  
  # Create role
  if resource_exists "role" "$role_name" "$AWS_REGION" "$ACCOUNT_ID"; then
    print_status "$YELLOW" "IAM role $role_name already exists."
  else
    aws iam create-role \
      --role-name "$role_name" \
      --assume-role-policy-document "{
        \"Version\": \"2012-10-17\",
        \"Statement\": [
          {
            \"Effect\": \"Allow\",
            \"Principal\": {
              \"Service\": [
                \"imagebuilder.amazonaws.com\",
                \"ec2.amazonaws.com\"
              ]
            },
            \"Action\": \"sts:AssumeRole\"
          }
        ]
      }"
    
    print_status "$GREEN" "IAM role created successfully."
  fi
  
  # Attach policies
  print_status "$YELLOW" "Attaching policies to IAM role: $role_name..."
  
  # Check if policies are already attached
  if ! aws iam list-attached-role-policies --role-name "$role_name" --query "AttachedPolicies[?PolicyArn=='arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore']" --output text | grep -q "AmazonSSMManagedInstanceCore"; then
    aws iam attach-role-policy \
      --role-name "$role_name" \
      --policy-arn arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore
    print_status "$GREEN" "Attached AmazonSSMManagedInstanceCore policy."
  else
    print_status "$YELLOW" "AmazonSSMManagedInstanceCore policy already attached."
  fi
  
  if ! aws iam list-attached-role-policies --role-name "$role_name" --query "AttachedPolicies[?PolicyArn=='arn:aws:iam::aws:policy/AmazonS3FullAccess']" --output text | grep -q "AmazonS3FullAccess"; then
    aws iam attach-role-policy \
      --role-name "$role_name" \
      --policy-arn arn:aws:iam::aws:policy/AmazonS3FullAccess
    print_status "$GREEN" "Attached AmazonS3FullAccess policy."
  else
    print_status "$YELLOW" "AmazonS3FullAccess policy already attached."
  fi
  
  if ! aws iam list-attached-role-policies --role-name "$role_name" --query "AttachedPolicies[?PolicyArn=='arn:aws:iam::aws:policy/CloudWatchLogsFullAccess']" --output text | grep -q "CloudWatchLogsFullAccess"; then
    aws iam attach-role-policy \
      --role-name "$role_name" \
      --policy-arn arn:aws:iam::aws:policy/CloudWatchLogsFullAccess
    print_status "$GREEN" "Attached CloudWatchLogsFullAccess policy."
  else
    print_status "$YELLOW" "CloudWatchLogsFullAccess policy already attached."
  fi
  
  # Create custom policy for Image Builder
  print_status "$YELLOW" "Creating custom policy for Image Builder..."
  
  aws iam put-role-policy \
    --role-name "$role_name" \
    --policy-name "ImageBuilderCustomPolicy" \
    --policy-document "{
      \"Version\": \"2012-10-17\",
      \"Statement\": [
        {
          \"Effect\": \"Allow\",
          \"Action\": [
            \"ec2:*\",
            \"ssm:*\",
            \"s3:*\",
            \"logs:*\",
            \"imagebuilder:*\"
          ],
          \"Resource\": \"*\"
        },
        {
          \"Effect\": \"Allow\",
          \"Action\": [
            \"iam:PassRole\"
          ],
          \"Resource\": \"arn:aws:iam::${ACCOUNT_ID}:role/*\"
        }
      ]
    }"
  
  print_status "$GREEN" "Custom policy created successfully."
  
  # Create instance profile
  print_status "$YELLOW" "Creating instance profile: $instance_profile_name..."
  
  if resource_exists "instance-profile" "$instance_profile_name" "$AWS_REGION" "$ACCOUNT_ID"; then
    print_status "$YELLOW" "Instance profile $instance_profile_name already exists."
  else
    aws iam create-instance-profile \
      --instance-profile-name "$instance_profile_name"
    
    aws iam add-role-to-instance-profile \
      --instance-profile-name "$instance_profile_name" \
      --role-name "$role_name"
    
    print_status "$GREEN" "Instance profile created successfully."
  fi
}

# Function to create infrastructure configuration
create_infrastructure_config() {
  local infra_config_name="$1"
  local role_name="$2"
  local bucket_name="$3"
  local region="$4"
  
  print_status "$YELLOW" "Creating infrastructure configuration: $infra_config_name..."
  
  if resource_exists "infrastructure-config" "$infra_config_name" "$region" "$ACCOUNT_ID"; then
    print_status "$YELLOW" "Infrastructure configuration $infra_config_name already exists."
    return
  fi
  
  # Get VPC and subnet information
  print_status "$YELLOW" "Getting VPC and subnet information..."
  
  VPC_ID=$(aws ec2 describe-vpcs --filters "Name=isDefault,Values=true" --query "Vpcs[0].VpcId" --output text)
  
  if [ -z "$VPC_ID" ]; then
    print_status "$RED" "Error: No default VPC found."
    exit 1
  fi
  
  SUBNET_ID=$(aws ec2 describe-subnets --filters "Name=vpc-id,Values=$VPC_ID" --query "Subnets[0].SubnetId" --output text)
  
  if [ -z "$SUBNET_ID" ]; then
    print_status "$RED" "Error: No subnet found in VPC $VPC_ID."
    exit 1
  fi
  
  # Check if security group already exists
  SECURITY_GROUP_ID=$(aws ec2 describe-security-groups \
    --filters "Name=group-name,Values=CITS3007ImageBuilderSG" \
    --query "SecurityGroups[0].GroupId" \
    --output text)
  
  if [ -z "$SECURITY_GROUP_ID" ] || [ "$SECURITY_GROUP_ID" == "None" ]; then
    # Create security group
    SECURITY_GROUP_ID=$(aws ec2 create-security-group \
      --group-name "CITS3007ImageBuilderSG" \
      --description "Security group for CITS3007 Image Builder" \
      --vpc-id "$VPC_ID" \
      --query "GroupId" \
      --output text)
    
    # Allow outbound traffic
    aws ec2 authorize-security-group-egress \
      --group-id "$SECURITY_GROUP_ID" \
      --protocol -1 \
      --port -1 \
      --cidr 0.0.0.0/0
    
    # Allow inbound SSH
    aws ec2 authorize-security-group-ingress \
      --group-id "$SECURITY_GROUP_ID" \
      --protocol tcp \
      --port 22 \
      --cidr 0.0.0.0/0
    
    print_status "$GREEN" "Security group created successfully."
  else
    print_status "$YELLOW" "Security group already exists: $SECURITY_GROUP_ID."
  fi
  
  print_status "$YELLOW" "VPC: $VPC_ID, Subnet: $SUBNET_ID, Security Group: $SECURITY_GROUP_ID."
  
  # Create infrastructure configuration
  aws imagebuilder create-infrastructure-configuration \
    --name "$infra_config_name" \
    --description "Infrastructure for CITS3007 development environment" \
    --instance-types "t2.micro" \
    --security-group-ids "$SECURITY_GROUP_ID" \
    --subnet-id "$SUBNET_ID" \
    --instance-profile-name "$role_name" \
    --logging "{\"s3Logs\":{\"s3BucketName\":\"$bucket_name\",\"s3KeyPrefix\":\"logs\"}}"
  
  print_status "$GREEN" "Infrastructure configuration created successfully."
}

# Function to create distribution configuration
create_distribution_config() {
  local dist_config_name="$1"
  local region="$2"
  local account_id="$3"
  
  print_status "$YELLOW" "Creating distribution configuration: $dist_config_name..."
  
  if resource_exists "distribution-config" "$dist_config_name" "$region" "$account_id"; then
    print_status "$YELLOW" "Distribution configuration $dist_config_name already exists."
    return
  fi
  
  aws imagebuilder create-distribution-configuration \
    --name "$dist_config_name" \
    --description "Distribution configuration for CITS3007" \
    --distributions "[{\"region\":\"$region\",\"amiDistributionConfiguration\":{\"name\":\"$dist_config_name-{{ imagebuilder:buildDate }}\",\"description\":\"Development environment for CITS3007\",\"targetAccountIds\":[\"$account_id\"],\"amiTags\":{\"Name\":\"$dist_config_name\"}}}]"
  
  print_status "$GREEN" "Distribution configuration created successfully."
}

# Function to create component
create_component() {
  local component_name="$1"
  local component_file="$2"
  local version="$3"
  local region="$4"
  local account_id="$5"
  
  print_status "$YELLOW" "Creating component: $component_name (version: $version)..."
  
  # Create component with the exact command that worked
  aws imagebuilder create-component \
    --name "$component_name" \
    --semantic-version "$version" \
    --description "Development environment for CITS3007" \
    --platform "Linux" \
    --data "file://$(pwd)/$component_file"
  
  print_status "$GREEN" "Component created successfully."
}

# Function to create image recipe
create_image_recipe() {
  local recipe_name="$1"
  local component_name="$2"
  local version="$3"
  local region="$4"
  local account_id="$5"
  
  print_status "$YELLOW" "Creating image recipe: $recipe_name..."
  
  if resource_exists "recipe" "$recipe_name" "$region" "$account_id"; then
    print_status "$YELLOW" "Image recipe $recipe_name already exists."
    return
  fi
  
  # Get component ARN - using the correct format with /1 suffix
  local component_name_lower=$(echo "$component_name" | tr '[:upper:]' '[:lower:]')
  COMPONENT_ARN="arn:aws:imagebuilder:${region}:${account_id}:component/${component_name_lower}/${version}/1"
  
  # Get latest Ubuntu 20.04 AMI ID
  PARENT_IMAGE=$(aws ec2 describe-images --owners amazon --filters "Name=name,Values=ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*" --query 'sort_by(Images,&CreationDate)[-1].ImageId' --output text)
  
  # Create image recipe with the exact format that worked
  aws imagebuilder create-image-recipe \
    --name "$recipe_name" \
    --semantic-version "$version" \
    --description "Development environment for CITS3007" \
    --parent-image "$PARENT_IMAGE" \
    --components "[{\"componentArn\":\"${COMPONENT_ARN}\"}]" \
    --working-directory "/tmp" \
    --block-device-mappings "[{\"deviceName\":\"/dev/sda1\",\"ebs\":{\"volumeSize\":20,\"volumeType\":\"gp2\",\"deleteOnTermination\":true}}]" \
    --tags "Name=${recipe_name},Version=${version}"
  
  print_status "$GREEN" "Image recipe created successfully."
}

# Function to create image pipeline
create_image_pipeline() {
  local pipeline_name="$1"
  local recipe_name="$2"
  local infra_config_name="$3"
  local dist_config_name="$4"
  local version="$5"
  local region="$6"
  local account_id="$7"
  
  print_status "$YELLOW" "Creating image pipeline: $pipeline_name..."
  
  if resource_exists "pipeline" "$pipeline_name" "$region" "$account_id"; then
    print_status "$YELLOW" "Image pipeline $pipeline_name already exists."
    return
  fi
  
  # Get ARNs with correct format
  local recipe_name_lower=$(echo "$recipe_name" | tr '[:upper:]' '[:lower:]')
  local infra_config_name_lower=$(echo "$infra_config_name" | tr '[:upper:]' '[:lower:]')
  local dist_config_name_lower=$(echo "$dist_config_name" | tr '[:upper:]' '[:lower:]')
  
  RECIPE_ARN="arn:aws:imagebuilder:${region}:${account_id}:image-recipe/${recipe_name_lower}/${version}"
  INFRA_CONFIG_ARN="arn:aws:imagebuilder:${region}:${account_id}:infrastructure-configuration/${infra_config_name_lower}"
  DIST_CONFIG_ARN="arn:aws:imagebuilder:${region}:${account_id}:distribution-configuration/${dist_config_name_lower}"
  
  # Create image pipeline with the exact format that worked
  aws imagebuilder create-image-pipeline \
    --name "$pipeline_name" \
    --description "Development environment pipeline for CITS3007" \
    --image-recipe-arn "$RECIPE_ARN" \
    --infrastructure-configuration-arn "$INFRA_CONFIG_ARN" \
    --distribution-configuration-arn "$DIST_CONFIG_ARN" \
    --image-tests-configuration "{\"imageTestsEnabled\":true,\"timeoutMinutes\":60}" \
    --schedule "{\"pipelineExecutionStartCondition\":\"EXPRESSION_MATCH_AND_DEPENDENCY_UPDATES_AVAILABLE\",\"scheduleExpression\":\"cron(0 0 ? * SUN *)\"}" \
    --status "ENABLED"
  
  print_status "$GREEN" "Image pipeline created successfully."
}

# Function to run image pipeline
run_image_pipeline() {
  local pipeline_name="$1"
  local region="$2"
  local account_id="$3"
  
  print_status "$YELLOW" "Running image pipeline: $pipeline_name..."
  
  # Convert pipeline name to lowercase
  local pipeline_name_lower=$(echo "$pipeline_name" | tr '[:upper:]' '[:lower:]')
  
  # Start the pipeline
  BUILD_ID=$(aws imagebuilder start-image-pipeline-execution \
    --image-pipeline-arn "arn:aws:imagebuilder:${region}:${account_id}:image-pipeline/${pipeline_name_lower}" \
    --query "imageBuildVersionArn" \
    --output text)
  
  print_status "$GREEN" "Pipeline started successfully with build ID: $BUILD_ID"
  
  # Monitor the build
  print_status "$YELLOW" "Monitoring build progress..."
  
  while true; do
    STATUS=$(aws imagebuilder get-image \
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
  AMI_ID=$(aws imagebuilder get-image \
    --image-build-version-arn "$BUILD_ID" \
    --query "image.outputResources.amis[0].image" \
    --output text)
  
  print_status "$GREEN" "Build completed successfully!"
  print_status "$GREEN" "AMI ID: $AMI_ID"
}

# Function to get resource ARN
get_resource_arn() {
  local resource_type="$1"
  local resource_name="$2"
  local region="$3"
  local account_id="$4"
  
  case "$resource_type" in
    "infrastructure-config")
      aws imagebuilder list-infrastructure-configurations --query "infrastructureConfigurationSummaryList[?name=='$resource_name'].arn" --output text
      ;;
    "distribution-config")
      aws imagebuilder list-distribution-configurations --query "distributionConfigurationSummaryList[?name=='$resource_name'].arn" --output text
      ;;
    "component")
      aws imagebuilder list-components --query "componentVersionList[?name=='$resource_name'].arn" --output text
      ;;
    "recipe")
      aws imagebuilder list-image-recipes --query "imageRecipeSummaryList[?name=='$resource_name'].arn" --output text
      ;;
    "pipeline")
      aws imagebuilder list-image-pipelines --query "imagePipelineList[?name=='$resource_name'].arn" --output text
      ;;
    *)
      echo ""
      ;;
  esac
}

# Function to delete existing resources
cleanup_resources() {
  local pipeline_name="$1"
  local recipe_name="$2"
  local component_name="$3"
  local infra_config_name="$4"
  local dist_config_name="$5"
  local region="$6"
  local account_id="$7"
  local version="$8"

  print_status "$YELLOW" "Cleaning up existing resources..."

  # Delete image pipeline if it exists
  if resource_exists "pipeline" "$pipeline_name" "$region" "$account_id"; then
    print_status "$YELLOW" "Deleting image pipeline: $pipeline_name"
    local pipeline_name_lower=$(echo "$pipeline_name" | tr '[:upper:]' '[:lower:]')
    local pipeline_arn="arn:aws:imagebuilder:${region}:${account_id}:image-pipeline/${pipeline_name_lower}"
    aws imagebuilder delete-image-pipeline --image-pipeline-arn "$pipeline_arn"
    print_status "$GREEN" "Successfully deleted pipeline: $pipeline_name"
    sleep 5
  fi

  # Delete image recipe if it exists
  if resource_exists "recipe" "$recipe_name" "$region" "$account_id"; then
    print_status "$YELLOW" "Deleting image recipe: $recipe_name"
    local recipe_name_lower=$(echo "$recipe_name" | tr '[:upper:]' '[:lower:]')
    local recipe_arn="arn:aws:imagebuilder:${region}:${account_id}:image-recipe/${recipe_name_lower}/${version}"
    aws imagebuilder delete-image-recipe --image-recipe-arn "$recipe_arn"
    print_status "$GREEN" "Successfully deleted recipe: $recipe_name"
    sleep 5
  fi

  # Delete component if it exists
  print_status "$YELLOW" "Deleting component: $component_name"
  # Convert component name to lowercase
  local component_name_lower=$(echo "$component_name" | tr '[:upper:]' '[:lower:]')
  # Delete the component with the exact command that worked
  aws imagebuilder delete-component --component-build-version-arn "arn:aws:imagebuilder:${region}:${account_id}:component/${component_name_lower}/1.0.0/1"
  print_status "$GREEN" "Successfully deleted component version: ${component_name_lower}/1.0.0/1"
  sleep 5

  # Verify component is deleted
  local component_exists=$(aws imagebuilder list-components --filters "[{\"name\":\"name\",\"values\":[\"$component_name\"]}]" --query "componentVersionList[].componentBuildVersionArn" --output text)
  if [ ! -z "$component_exists" ]; then
    print_status "$RED" "Failed to delete component. Please delete it manually."
    exit 1
  else
    print_status "$GREEN" "Component cleanup verified successfully."
  fi

  # Delete infrastructure configuration if it exists
  if resource_exists "infrastructure-config" "$infra_config_name" "$region" "$account_id"; then
    print_status "$YELLOW" "Deleting infrastructure configuration: $infra_config_name"
    local infra_config_arn=$(get_resource_arn "infrastructure-config" "$infra_config_name" "$region" "$account_id")
    if [ ! -z "$infra_config_arn" ]; then
      aws imagebuilder delete-infrastructure-configuration --infrastructure-configuration-arn "$infra_config_arn"
      sleep 5
    fi
  fi

  # Delete distribution configuration if it exists
  if resource_exists "distribution-config" "$dist_config_name" "$region" "$account_id"; then
    print_status "$YELLOW" "Deleting distribution configuration: $dist_config_name"
    local dist_config_arn=$(get_resource_arn "distribution-config" "$dist_config_name" "$region" "$account_id")
    if [ ! -z "$dist_config_arn" ]; then
      aws imagebuilder delete-distribution-configuration --distribution-configuration-arn "$dist_config_arn"
      sleep 5
    fi
  fi

  print_status "$GREEN" "Cleanup completed successfully!"
}

# Add progress visualization
show_progress() {
    local status=$1
    local progress=$2
    echo -ne "\rStatus: $status | Progress: $progress"
}

# Main function
main() {
  print_status "$BLUE" "Starting AWS Image Builder setup..."
  
  # Validate AWS CLI
  validate_aws_cli
  
  # Get AWS account ID
  ACCOUNT_ID=$(aws sts get-caller-identity --query Account --output text)
  
  # Configuration
  AWS_REGION="ap-southeast-2"
  VERSION="1.0.0"
  
  # Resource names
  BUCKET_NAME="cits3007-image-builder-logs-${ACCOUNT_ID}"
  ROLE_NAME="CITS3007ImageBuilderRole"
  INSTANCE_PROFILE_NAME="CITS3007ImageBuilderRole"
  INFRA_CONFIG_NAME="CITS3007DevEnvironment"
  DIST_CONFIG_NAME="CITS3007DevEnvironment"
  COMPONENT_NAME="CITS3007DevEnvironment"
  RECIPE_NAME="CITS3007DevEnvironment"
  PIPELINE_NAME="CITS3007DevEnvironment"
  COMPONENT_FILE="components/cits3007-dev-environment.yaml"

  # Clean up existing resources
  cleanup_resources "$PIPELINE_NAME" "$RECIPE_NAME" "$COMPONENT_NAME" "$INFRA_CONFIG_NAME" "$DIST_CONFIG_NAME" "$AWS_REGION" "$ACCOUNT_ID" "$VERSION"
  
  # Create resources
  create_s3_bucket "$BUCKET_NAME" "$AWS_REGION"
  create_iam_role "$ROLE_NAME" "$INSTANCE_PROFILE_NAME"
  create_infrastructure_config "$INFRA_CONFIG_NAME" "$ROLE_NAME" "$BUCKET_NAME" "$AWS_REGION"
  create_distribution_config "$DIST_CONFIG_NAME" "$AWS_REGION" "$ACCOUNT_ID"
  create_component "$COMPONENT_NAME" "$COMPONENT_FILE" "$VERSION" "$AWS_REGION" "$ACCOUNT_ID"
  create_image_recipe "$RECIPE_NAME" "$COMPONENT_NAME" "$VERSION" "$AWS_REGION" "$ACCOUNT_ID"
  create_image_pipeline "$PIPELINE_NAME" "$RECIPE_NAME" "$INFRA_CONFIG_NAME" "$DIST_CONFIG_NAME" "$VERSION" "$AWS_REGION" "$ACCOUNT_ID"
  
  # Ask if user wants to run the pipeline
  read -p "Do you want to run the image pipeline now? (y/n): " RUN_PIPELINE
  
  if [[ "$RUN_PIPELINE" == "y" || "$RUN_PIPELINE" == "Y" ]]; then
    run_image_pipeline "$PIPELINE_NAME" "$AWS_REGION" "$ACCOUNT_ID"
  else
    print_status "$YELLOW" "You can run the pipeline later using:"
    print_status "$YELLOW" "aws imagebuilder start-image-pipeline-execution --image-pipeline-arn arn:aws:imagebuilder:${AWS_REGION}:${ACCOUNT_ID}:imagePipeline/${PIPELINE_NAME}"
  fi
  
  print_status "$GREEN" "AWS Image Builder setup completed successfully!"
}

# Run main function
main

# Add config file support
CONFIG_FILE="monitor-build.config"
if [ -f "$CONFIG_FILE" ]; then
    source "$CONFIG_FILE"
fi

# Add log rotation and cleanup
TEMP_DIR=$(mktemp -d)
trap 'rm -rf "$TEMP_DIR"' EXIT 