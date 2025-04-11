# AWS Image Builder for CITS3007

This repository contains scripts and documentation for setting up and managing AWS Image Builder for the CITS3007 Secure Coding course.

## Overview

The project aims to create a secure development environment for CITS3007 Secure Coding using AWS Image Builder. The environment is based on Ubuntu 20.04 LTS and includes all the necessary development tools for secure coding.

## Key Goals

1. Create a secure development environment for CITS3007 Secure Coding
2. Must be UBUNTU 20.0.4. MUST BE PROVISIONED PRECISELY PER THE LIBVIRT AND VIRTBOX IMAGES.
3. Automate the setup process using AWS Image Builder
4. Ensure reproducibility of the environment
5. Document the entire process for future reference
6. Provide a consistent environment for all students

## Golden Rules

1. **NEVER GUESS A COMMAND. IF UNSURE, CHECK THE DOCS. IF THE DOC DOESN'T EXIST, CREATE THE DOCUMENT. THEN CHECK IT.**
2. Always verify command syntax before execution
3. Document all attempts, successes, and failures
4. Keep track of resource ARNs and IDs
5. Clean up resources when no longer needed

## Scripts

The repository contains the following scripts:

### 1. setup-image-builder.sh

Sets up the AWS Image Builder environment, including:
- S3 bucket for logs
- IAM role with necessary permissions
- Infrastructure configuration
- Component creation

### 2. create-image-recipe.sh

Creates an image recipe for the CITS3007 development environment.

### 3. create-image-builder-pipeline.sh

Creates an image pipeline for building the CITS3007 development environment.

### 4. monitor-image-build.sh

Monitors the progress of an image build.

### 5. cleanup-image-builder.sh

Cleans up AWS Image Builder resources.

### 6. download-aws-docs.sh

Downloads AWS documentation for reference.

## Components

The repository contains the following components:

### 1. cits3007-dev-environment.yaml

Defines the CITS3007 development environment, including:
- Basic development tools
- Clang and LLVM
- AFL (American Fuzzy Lop)
- Valgrind
- GDB
- Splint
- Python3 and pip
- gcov and lcov

## JSON Configuration Files

The repository contains the following JSON configuration files:

### 1. create-image-recipe.json

Defines the image recipe for the CITS3007 development environment.

### 2. role-policy.json

Defines the IAM role policy for the CITS3007 Image Builder.

### 3. trust-policy.json

Defines the trust policy for the CITS3007 Image Builder.

### 4. bucket-policy.json

Defines the S3 bucket policy for the CITS3007 Image Builder logs.

## Documentation

The repository contains the following documentation:

### 1. AWS_DOCUMENTATION.md

Comprehensive documentation of the AWS Image Builder setup and usage.

## Usage

1. Configure AWS CLI with appropriate credentials
2. Run `./scripts/setup-image-builder.sh` to set up the AWS Image Builder environment
3. Run `./scripts/create-image-recipe.sh` to create the image recipe
4. Run `./scripts/create-image-builder-pipeline.sh` to create the image pipeline
5. Monitor the image build progress using `./scripts/monitor-image-build.sh`
6. Clean up resources using `./scripts/cleanup-image-builder.sh` when done

## Troubleshooting

Refer to the AWS_DOCUMENTATION.md file for troubleshooting information. 