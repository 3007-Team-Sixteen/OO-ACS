#!/bin/bash

# Create wiki directory structure
mkdir -p wiki/{standards,development,security,testing,reference,project}

# Create main wiki pages
cat > wiki/Home.md << 'EOL'
# OO-ACS Wiki

Welcome to the OO-ACS (Oblivionaire Online - Access Control System) wiki. This wiki contains comprehensive documentation for the project.

## Quick Links
- [Standards Documentation](standards/Home)
- [Development Guide](development/Home)
- [Security Documentation](security/Home)
- [Testing Documentation](testing/Home)
- [Reference Materials](reference/Home)
- [Project Documentation](project/Home)

## Getting Started
- [Development Setup](development/Setup)
- [Security Guidelines](security/Guidelines)
- [Testing Procedures](testing/Procedures)

## Project Information
- [Architecture Overview](project/Architecture)
- [API Reference](project/API)
- [User Guides](project/User-Guides)
EOL

# Create standards documentation
cat > wiki/standards/Home.md << 'EOL'
# Standards Documentation

This section contains all standards and guidelines used in the project.

## Security Standards
- [ISM Guidelines](security/ISM)
- [CISA Publications](security/CISA)
- [NIST Guidelines](security/NIST)
- [OWASP Standards](security/OWASP)

## Development Standards
- [SEI CERT C](development/SEI-CERT)
- [MISRA C:2012](development/MISRA)
- [C11 Standard](development/C11)

## Testing Standards
- [Unity Testing](testing/Unity)
- [Security Testing](testing/Security)
- [Performance Testing](testing/Performance)

## Reference Materials
- [curl Patterns](reference/curl)
- [OpenSSH Patterns](reference/OpenSSH)
- [FreeRADIUS Patterns](reference/FreeRADIUS)
EOL

# Create development documentation
cat > wiki/development/Home.md << 'EOL'
# Development Documentation

This section contains development guidelines and procedures.

## Development Standards
- [Coding Standards](Standards)
- [Memory Management](Memory-Management)
- [Error Handling](Error-Handling)
- [Thread Safety](Thread-Safety)

## Tools and Environment
- [Development Setup](Setup)
- [Build System](Build-System)
- [Debugging](Debugging)
- [Profiling](Profiling)

## Architecture
- [System Design](Architecture)
- [API Design](API-Design)
- [Data Structures](Data-Structures)
- [Algorithms](Algorithms)
EOL

# Create security documentation
cat > wiki/security/Home.md << 'EOL'
# Security Documentation

This section contains security guidelines and procedures.

## Security Standards
- [CIA Triad](CIA-Triad)
- [STRIDE Model](STRIDE)
- [Cryptographic Standards](Cryptography)
- [Access Control](Access-Control)

## Implementation
- [Authentication](Authentication)
- [Session Management](Session-Management)
- [RBAC Implementation](RBAC)
- [Security Testing](Security-Testing)

## Tools and Procedures
- [Static Analysis](Static-Analysis)
- [Dynamic Analysis](Dynamic-Analysis)
- [Penetration Testing](Penetration-Testing)
- [Incident Response](Incident-Response)
EOL

# Create testing documentation
cat > wiki/testing/Home.md << 'EOL'
# Testing Documentation

This section contains testing procedures and guidelines.

## Testing Standards
- [Unit Testing](Unit-Testing)
- [Integration Testing](Integration-Testing)
- [Security Testing](Security-Testing)
- [Performance Testing](Performance-Testing)

## Tools and Procedures
- [Testing Framework](Framework)
- [Test Coverage](Coverage)
- [Continuous Integration](CI)
- [Test Automation](Automation)

## Test Cases
- [Authentication Tests](Authentication-Tests)
- [Session Tests](Session-Tests)
- [RBAC Tests](RBAC-Tests)
- [Performance Tests](Performance-Tests)
EOL

# Create reference documentation
cat > wiki/reference/Home.md << 'EOL'
# Reference Documentation

This section contains reference materials and patterns.

## Codebases
- [curl Patterns](curl)
- [OpenSSH Patterns](OpenSSH)
- [FreeRADIUS Patterns](FreeRADIUS)

## Patterns
- [Memory Management](Memory-Management)
- [Error Handling](Error-Handling)
- [Thread Safety](Thread-Safety)
- [Security](Security)

## Standards
- [C11 Standard](C11)
- [POSIX](POSIX)
- [Cryptographic Standards](Cryptography)
EOL

# Create project documentation
cat > wiki/project/Home.md << 'EOL'
# Project Documentation

This section contains project-specific documentation.

## Project Information
- [Architecture](Architecture)
- [API Reference](API)
- [User Guides](User-Guides)
- [Development Guides](Development-Guides)

## Processes
- [Development Process](Development-Process)
- [Code Review](Code-Review)
- [Documentation](Documentation)
- [Release Process](Release-Process)

## Infrastructure
- [Development Environment](Development-Environment)
- [Testing Environment](Testing-Environment)
- [Production Environment](Production-Environment)
- [Monitoring](Monitoring)
EOL

echo "Wiki structure created. Please review and commit the changes." 