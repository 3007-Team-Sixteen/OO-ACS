# CITS3007 Development Environment for UTM (Apple Silicon)

This repository contains the configuration and scripts needed to run the CITS3007 development environment using UTM on Apple Silicon Macs.

## Prerequisites

1. Install UTM from the Mac App Store
2. Install Vagrant:
   ```bash
   brew install vagrant
   ```

## Setup Instructions

1. Run the setup script:
   ```bash
   ./setup.sh
   ```
   This will:
   - Download the Ubuntu 20.04 base image
   - Copy the provisioning scripts
   - Create the UTM configuration

2. Open UTM and import the configuration:
   - Open UTM
   - Click "Import"
   - Select the `cits3007.utm/config.plist` file

3. Start the VM in UTM

4. Once the VM is running, apply the provisioning:
   ```bash
   ./apply-provisioning.sh
   ```

## Environment Details

- Base Image: Ubuntu 20.04 (generic/ubuntu2004 version 4.1.0)
- Architecture: x86_64 (emulated)
- Memory: 8GB
- CPU: 4 cores
- Storage: 60GB

## Development Tools

The environment includes:
- gcc and GNU make
- clang and related tools
- gdb for debugging
- valgrind for memory checking
- Various development utilities

## Notes

- The environment is configured to use x86_64 emulation to ensure compatibility with the original CITS3007 environment
- Shared folders are enabled for easy file transfer between host and guest
- Network is configured in shared mode for internet access
