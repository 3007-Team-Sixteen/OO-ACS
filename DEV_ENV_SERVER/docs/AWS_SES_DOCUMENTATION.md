# AWS SES Email Configuration

## Overview
This document describes the process of sending student credentials via AWS Simple Email Service (SES). The goal is to securely deliver SSH access credentials to students while avoiding spam filters.

## Prerequisites
1. AWS SES must be set up in the ap-southeast-2 region
2. Sender email address (steebea@gmail.com) must be verified with SES
3. Student email addresses must be in the format studentnumber@student.uwa.edu.au

## Security Considerations
1. Email content includes:
   - Username
   - Student number
   - Server IP address
   - SSH connection instructions
   - PEM key as an attachment

2. Security measures:
   - PEM keys are sent as base64-encoded attachments
   - Instructions include proper file permissions (chmod 400)
   - Each student receives only their own credentials
   - Emails are sent via AWS SES to avoid spam filters

## Process Flow
1. Verify sender email with AWS SES
2. For each student:
   - Create MIME message with proper headers
   - Attach their PEM key
   - Send via AWS SES
   - Confirm delivery

## Implementation
The process is automated via the `scripts/send-credentials.sh` script, which:
1. Verifies the sender email with SES
2. Reads student information from arrays
3. Creates properly formatted MIME messages
4. Sends emails using the AWS SES API

## Verification
After sending:
1. Check AWS SES console for delivery status
2. Verify students can access their accounts
3. Monitor for any bounces or complaints

## Troubleshooting
1. If emails are not received:
   - Check SES sending limits
   - Verify sender email status
   - Check for bounces in SES console
2. If attachments are corrupted:
   - Verify base64 encoding
   - Check MIME boundaries
3. If spam filtered:
   - Check SES reputation
   - Verify DKIM/SPF records 