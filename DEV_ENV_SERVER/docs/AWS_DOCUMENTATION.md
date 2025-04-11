# AWS Image Builder Documentation

## Overview
This documentation describes the AWS Image Builder project for CITS3007, which creates a standardized development environment for students. The project uses AWS Image Builder to automate the creation of AMIs that precisely match the original provisioning files.

## Key Goals
1. Create a secure development environment using Ubuntu 20.04
2. Automate the setup process using AWS Image Builder
3. Ensure reproducibility across all student environments
4. Provide a consistent environment for all students

## What Does "Precisely Matching" Mean?

### 1. Package Installation
- Packages must be installed in the exact order specified in the original scripts
- All packages must be installed with `--no-install-recommends` flag
- Package versions must match exactly:
  - LLVM 12.0.0
  - AFL++ 3.14c
  - All other packages at their latest versions as of Ubuntu 20.04

### 2. Network Configuration
- Netplan configuration must be set to use DHCP
- Systemd-resolved must be configured with specific DNS settings
- All network configurations must match the original provisioning files

### 3. Locale Configuration
- System locale must be set to en_AU.UTF-8
- Locale must be properly generated and installed
- Environment variables must be set:
  - LANG=en_AU.UTF-8
  - LC_ALL=en_AU.UTF-8

### 4. Verification Process
- A verification script must be run to ensure all components match
- The script checks:
  - Package installation status
  - Network configuration
  - Locale settings
  - File permissions
  - Service status

### 5. Package Groups
The environment includes several groups of packages:

#### Basic Apps
- `apt-transport-https`
- `ca-certificates`
- `curl`
- `gnupg`
- `lsb-release`
- `software-properties-common`
- `wget`

#### Extra Utils
- `fakeroot`
- `gpg`
- `jq`
- `less`
- `lsof`
- `lynx`
- `netcat-openbsd`
- `procps`
- `pv`
- `openssh-client`
- `screen`
- `sudo`
- `time`

#### Dev Tools
- `build-essential`
- `clang`
- `cmake`
- `gdb`
- `git`
- `llvm`
- `python3`
- `python3-pip`
- `valgrind`
- `afl++-clang`

#### Documentation
- `man-db`
- `manpages`
- `manpages-dev`
- `manpages-posix`
- `manpages-posix-dev`

### 6. Verification Script
The verification script (`verify-provisioning.sh`) checks:
1. Package installation status for all required packages
2. Network configuration in `/etc/netplan/01-netcfg.yaml`
3. DNS configuration in `/etc/systemd/resolved.conf`
4. Locale configuration and environment variables
5. Service status for systemd-resolved

## Golden Rules
1. **Documentation First**: All changes must be documented before implementation
2. **Version Control**: Every change must be versioned and tracked
3. **Verification**: All changes must be verified against the original provisioning files
4. **Testing**: All changes must be tested in a clean environment
5. **Documentation**: All changes must be reflected in the documentation

## Versioning Strategy
- Pre-release versions (0.x.x) indicate development and testing
- Version 1.0.0 represents the first stable release with:
  - All features implemented and working
  - Documentation complete and accurate
  - Verification script passing all checks
  - No known issues or bugs

## Known Issues and Resolutions

### 1. SSM Connection Issues
- **Issue**: Unable to connect to instances via SSM
- **Root Cause**: Missing IAM roles and permissions
- **Resolution**: Added necessary IAM roles and instance profile

### 2. Monitoring Improvements
- **Issue**: Insufficient monitoring of build process
- **Root Cause**: Basic CloudWatch logging
- **Resolution**: Enhanced logging and monitoring

### 3. Package Installation Issues
- **Issue**: Some packages failing to install
- **Root Cause**: Missing dependencies
- **Resolution**: Added explicit dependency installation

### 4. Locale Configuration
- **Issue**: Locale warnings during package installation
- **Root Cause**: Missing en_AU.UTF-8 locale
- **Resolution**: Added locale configuration step

## Implementation Details

### Component Structure
The component file (`cits3007-dev-environment.yaml`) is organized into several steps:

1. **UpdateSystem**
   - Updates package lists
   - Installs basic apps and extra utilities
   - Uses `--no-install-recommends` flag

2. **InstallDevTools**
   - Installs development tools
   - Installs documentation packages
   - Configures build environment

3. **ConfigureLocale**
   - Installs locales package
   - Generates en_AU.UTF-8 locale
   - Sets system default locale
   - Configures environment variables

4. **ConfigureNetwork**
   - Creates netplan configuration
   - Configures systemd-resolved
   - Applies network settings

5. **Cleanup**
   - Removes package lists
   - Cleans apt cache
   - Verifies installations

### Component YAML Structure
The component YAML file follows this structure:
```yaml
name: CITS3007-DevEnvironment
description: Development environment for CITS3007 with all required packages and configurations
version: 1.0.0
schemaVersion: 1.0
phases:
  - name: build
    steps:
      - name: StepName
        action: ExecuteBash
        inputs:
          commands:
            - |
              #!/usr/bin/env bash
              # Script content here
```

### Bash Script Standards
Each bash script in the component follows these standards:
1. **Shebang Line**: `#!/usr/bin/env bash`
2. **Header Comments**: Include version, description, and purpose
3. **Error Handling**: Use `set -x` for verbose output and `set -euo pipefail` for strict error handling
4. **Command Documentation**: Each command is documented with comments
5. **Golden Rule Compliance**: All commands are verified against documentation

### Verification Process
1. Run the verification script
2. Check all package installations
3. Verify network configuration
4. Confirm locale settings
5. Validate service status

### Verification Script Details
The verification script (`verify-provisioning.sh`) performs the following checks:

1. **Package Verification**:
   ```bash
   # Check if a package is installed
   dpkg -l | grep -q "^ii  package-name"
   ```

2. **Network Configuration**:
   ```bash
   # Check netplan configuration
   grep -q "dhcp4: true" /etc/netplan/01-netcfg.yaml
   ```

3. **Locale Settings**:
   ```bash
   # Check locale settings
   grep -q "LANG=en_AU.UTF-8" /etc/environment
   grep -q "LC_ALL=en_AU.UTF-8" /etc/environment
   ```

4. **Service Status**:
   ```bash
   # Check service status
   systemctl is-active --quiet systemd-resolved
   ```

## AWS CLI Reference Commands

### Image Builder
```bash
# Create component
aws imagebuilder create-component \
  --name "CITS3007DevEnvironment" \
  --semantic-version "1.0.0" \
  --description "Development environment for CITS3007" \
  --platform "Linux" \
  --data file://components/cits3007-dev-environment.yaml

# Create recipe
aws imagebuilder create-image-recipe \
  --name "CITS3007DevEnvironment" \
  --semantic-version "1.0.0" \
  --description "Development environment for CITS3007" \
  --components '[{"componentArn":"arn:aws:imagebuilder:region:account:component/component-name/1.0.0"}]' \
  --working-directory "/tmp" \
  --block-device-mappings '[{"deviceName":"/dev/sda1","ebs":{"volumeSize":20,"volumeType":"gp2"}}]'

# Create infrastructure configuration
aws imagebuilder create-infrastructure-configuration \
  --name "CITS3007DevEnvironment" \
  --description "Infrastructure for CITS3007 development environment" \
  --instance-types "t2.micro" \
  --security-group-ids "sg-xxxxxxxx" \
  --subnet-id "subnet-xxxxxxxx" \
  --instance-profile-name "CITS3007ImageBuilderRole"

# Create distribution configuration
aws imagebuilder create-distribution-configuration \
  --name "CITS3007DevEnvironment" \
  --description "Distribution configuration for CITS3007" \
  --distributions '[{"region":"ap-southeast-2","amiDistributionConfiguration":{"name":"CITS3007DevEnvironment-{{ imagebuilder:buildDate }}","description":"Development environment for CITS3007","targetAccountIds":["123456789012"],"amiTags":{"Name":"CITS3007DevEnvironment"}}}]'

# Create image pipeline
aws imagebuilder create-image-pipeline \
  --name "CITS3007DevEnvironment" \
  --description "Pipeline for CITS3007 development environment" \
  --image-recipe-arn "arn:aws:imagebuilder:region:account:imagerecipe/recipe-name/1.0.0" \
  --infrastructure-configuration-arn "arn:aws:imagebuilder:region:account:infrastructureconfiguration/config-name" \
  --distribution-configuration-arn "arn:aws:imagebuilder:region:account:distributionconfiguration/config-name" \
  --schedule-expression "cron(0 0 1 * ? *)" \
  --status "ENABLED"
```

### SSM
```bash
# Start session
aws ssm start-session --target i-1234567890abcdef0

# Run command
aws ssm send-command \
  --instance-ids "i-1234567890abcdef0" \
  --document-name "AWS-RunShellScript" \
  --parameters 'commands=["echo Hello World"]'
```

## Troubleshooting

### Common Issues
1. **SSM Connection Issues**
   - Check IAM roles and permissions
   - Verify instance profile
   - Check security group settings

2. **Package Installation Failures**
   - Check package availability
   - Verify dependencies
   - Check network connectivity

3. **Network Configuration Issues**
   - Verify netplan configuration
   - Check systemd-resolved status
   - Validate DNS settings

4. **Locale Issues**
   - Check locale generation
   - Verify environment variables
   - Check package installation

### Resolution Steps
1. Check CloudWatch logs for errors
2. Verify component configuration
3. Run verification script
4. Check system logs
5. Verify network connectivity

### Build Process Monitoring
To monitor the build process:

1. **Check Build Status**:
   ```bash
   aws imagebuilder get-image --image-build-version-arn <image-build-version-arn>
   ```

2. **View Build Logs**:
   ```bash
   aws s3 cp s3://<bucket-name>/logs/<component-name>/<version>/<build-number>/build.log .
   ```

3. **Monitor Instance Status**:
   ```bash
   aws ec2 describe-instances --instance-ids <instance-id>
   ```

### Resource Cleanup
To clean up resources:

1. **Delete Image**:
   ```bash
   aws imagebuilder delete-image --image-build-version-arn <image-build-version-arn>
   ```

2. **Delete Image Recipe**:
   ```bash
   aws imagebuilder delete-image-recipe --image-recipe-arn <image-recipe-arn>
   ```

3. **Delete Component**:
   ```bash
   aws imagebuilder delete-component --component-build-version-arn <component-build-version-arn>
   ```

4. **Delete Infrastructure Configuration**:
   ```bash
   aws imagebuilder delete-infrastructure-configuration --infrastructure-configuration-arn <infrastructure-configuration-arn>
   ```

5. **Delete Distribution Configuration**:
   ```bash
   aws imagebuilder delete-distribution-configuration --distribution-configuration-arn <distribution-configuration-arn>
   ```

6. **Delete Image Pipeline**:
   ```bash
   aws imagebuilder delete-image-pipeline --image-pipeline-arn <image-pipeline-arn>
   ```

## IAM Role Requirements

### Required Policies
1. **AWS Managed Policies**:
   - `AmazonSSMManagedInstanceCore`
   - `AmazonS3FullAccess`
   - `AmazonCloudWatchLogsFullAccess`
   - `AmazonImageBuilderFullAccess`

2. **Custom Policy**:
   ```json
   {
       "Version": "2012-10-17",
       "Statement": [
           {
               "Effect": "Allow",
               "Action": [
                   "ec2:*",
                   "ssm:*",
                   "s3:*",
                   "logs:*",
                   "imagebuilder:*"
               ],
               "Resource": "*"
           },
           {
               "Effect": "Allow",
               "Action": [
                   "iam:PassRole"
               ],
               "Resource": "arn:aws:iam::<account-id>:role/*"
           }
       ]
   }
   ```

### Trust Relationship
```json
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Principal": {
                "Service": [
                    "imagebuilder.amazonaws.com",
                    "ec2.amazonaws.com"
                ]
            },
            "Action": "sts:AssumeRole"
        }
    ]
}
```

## Conclusion
This documentation provides a comprehensive guide for creating and managing the CITS3007 development environment using AWS Image Builder. By following these guidelines, you can ensure that the environment precisely matches the original provisioning files and provides a consistent experience for all students.