# CITS3007 Development Environment Access Instructions

## Important Security Notes
- **NEVER** share your PEM key with anyone
- **NEVER** commit your PEM key to version control
- If you suspect your key has been compromised, contact the unit coordinator immediately
- Each student has their own unique environment - do not try to access others' environments

## Setup Instructions

### 1. Save Your PEM Key
1. Create the SSH directory if it doesn't exist:
   ```bash
   mkdir -p ~/.ssh
   ```
2. Save your PEM key (sent via email) to:
   ```bash
   ~/.ssh/cits3007-<username>.pem
   ```
   Replace `<username>` with your username (e.g., kelly, mo, prem, etc.)

### 2. Set Correct Permissions
```bash
chmod 400 ~/.ssh/cits3007-<username>.pem
```

### 3. Configure SSH
1. Open or create your SSH config file:
   ```bash
   nano ~/.ssh/config
   ```
2. Add the following configuration (replace `<username>` with your username):
   ```
   Host cits3007-dev-<username>
       HostName 3.27.135.116
       User ubuntu
       IdentityFile ~/.ssh/cits3007-<username>.pem
       StrictHostKeyChecking no
   ```

### 4. Connect to Your Environment
```bash
ssh cits3007-dev-<username>
```

## Troubleshooting

### Permission Denied
If you see "Permission denied (publickey)", check:
1. PEM key file permissions (should be 400)
2. PEM key file location matches your SSH config
3. You're using the correct username (ubuntu)
4. Your key pair is properly associated with the instance

### Connection Refused/Timeout
1. Check your internet connection
2. Verify the HostName in your SSH config (3.27.135.116)
3. Wait a few minutes and try again
4. Check if the instance is running:
   ```bash
   aws ec2 describe-instances --instance-ids i-0789a541d68fa0edf --query "Reservations[*].Instances[*].{PublicIP:PublicIpAddress,State:State.Name}" --output table
   ```

### Instance Not Running
If the instance is stopped or terminated:
1. Contact the unit coordinator
2. Provide your username and the error message
3. The instance will be restarted with your configuration

### Other Issues
Contact the unit coordinator with:
1. Your username
2. The exact error message
3. Steps you've taken to troubleshoot
4. The output of `ssh -v cits3007-dev-<username>`

## Environment Details

### Pre-installed Tools
- Build essentials (gcc, make, etc.)
- LLVM 12.0.0
- AFL++ 3.14c
- Python 3
- GDB and Valgrind
- Git
- Man pages and documentation

### Working Directory
Your home directory (`~`) is persistent between sessions. Keep your work there.

### Updates and Maintenance
The environment is maintained by the teaching staff. Do not modify system-level configurations.

## Getting Help
- Post in the #technical-help channel for general issues
- Email the unit coordinator for account-specific problems
- Include your username and error messages in all support requests
- For AWS-specific issues, include:
  - Instance ID: i-0789a541d68fa0edf
  - AMI ID: ami-0a995589e3e6e94b6
  - Region: ap-southeast-2 