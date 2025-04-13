# CITS3007 Secure Coding - Group Project
## Oblivionaire Online (OO) - Access Control System (ACS)

This repository contains the materials and deliverables for the CITS3007 Secure Coding group project at The University of Western Australia.

## Project Overview

The project involves developing an Access Control System (ACS) for Oblivionaire Online (OO), a new MMORPG by Enjjin Media. The ACS is responsible for:
- Player authentication and secure login mechanisms
- Role-based access control (RBAC) for managing in-game privileges
- Session management and security monitoring
- Administrative tools for Enjjin's operations staff

## Team Information

**Team Name:** 3007-Team-Sixteen

**Group Number:** 16

**Organization:** 3007-Team-Sixteen

**Team Members:**
- Stephen Beaver (10423362) - Technical Lead & Infrastructure
- Kai Fletcher (23808253) - Testing & Quality Assurance
- Prem Patel (23775211) - RBAC & Financial Controls
- Muhammad Qureshi (23976415) - Session Management & Performance
- Kelly Snow (23614821) - Authentication & Security

## Repository Structure

- `ASSIGNMENT_SPEC.md` - Detailed project specification and requirements
- `phase1_report.md` - Phase 1 planning report
- `Assignment_Material/` - Course materials and lecture notes
  - `lectures/` - Lecture materials and security guidelines
- `docs/` - Project documentation
  - `references/` - Technical standards and guidelines
    - `security_standards/` - Security implementation guidelines
    - `style_guides/` - Coding standards and best practices
- `.github/workflows/` - CI/CD pipeline configuration
- `.gitignore` - Git ignore rules for the project

## Development Environment

### Core Development Tools
- AWS EC2 Ubuntu 20.04 LTS development server
- C11 with strict compiler flags (-std=c11 -pedantic -Wall -Wextra -Werror)
- Git and GitHub for version control
- CI/CD pipeline with GitHub Actions

### Analysis Tools
1. **Static Analysis**
   - Clang Static Analyser (daily runs)
   - Cppcheck (weekly scans)
   - Flawfinder (security checks)
   - Clang-tidy (code quality)

2. **Dynamic Analysis**
   - Valgrind (memory safety)
   - AddressSanitizer (quick checks)
   - ThreadSanitizer (concurrency)
   - UndefinedBehaviourSanitizer

3. **Security Testing**
   - AFL++ (fuzzing)
   - LibFuzzer (unit testing)
   - Regular security reviews

4. **Code Quality**
   - gcov/gcovr (coverage)
   - perf (performance)
   - Callgrind (profiling)

## Project Phases

1. **Phase 1 (Planning)**
   - Due: Wednesday 16 April 2025 (Week 8)
   - Worth: 10 marks
   - Deliverable: Planning report
   - Focus: Team organisation, development strategy, security planning

2. **Phase 2 (Implementation)**
   - Due: Week 11
   - Worth: 40 marks
   - Deliverable: Implementation and report
   - Focus: Core functionality, security implementation, testing

3. **Phase 3 (Demo/Presentation)**
   - Due: Weeks 11-12
   - Worth: 10 marks
   - Deliverable: Project demonstration and presentation
   - Focus: System demonstration, security features, lessons learned

## Quality Assurance

### Testing Requirements
- Unit tests: >90% coverage
- Integration tests: >80% coverage
- Security tests: >95% coverage
- Memory leak checks (zero tolerance)
- Fuzzing for all input functions
- Regular security audits

### Code Review Process
- Pull requests require:
  - Passing CI/CD checks
  - Security scan clearance
  - Code review approval
  - Updated documentation
  - Zero high-priority warnings
  - Zero memory leaks

### Security Standards
- Principle of Least Privilege
- Secure session management
- Strong authentication mechanisms
- Regular security audits
- Comprehensive logging
- Input validation and sanitisation

## Version Control Strategy

### Branch Management
- Main branch protection
- Feature branch workflow
- Pull request process
- Emergency merge procedures

### Naming Conventions
- Feature branches: `feature/ACS-<ticket>-description`
- Bug fixes: `bugfix/ACS-<ticket>-description`
- Security fixes: `security/ACS-<ticket>-description`

## Team Collaboration

### Communication
- Weekly meetings: Monday 10:00 at UWA
- Discord for team communication
- WhatsApp for urgent updates
- GitHub Projects for task tracking

### Documentation
- Regular updates to project documentation
- Security decision records
- Code documentation standards
- Maintenance procedures

## Academic Integrity

This project must be completed in accordance with the University Academic Integrity Policy. While general principles may be discussed with other students, all submitted work must be the result of your group's own effort.

## License

This project is part of CITS3007 - Secure Coding at The University of Western Australia. All materials are provided for educational purposes.

# Oblivionaire Online - Access Control System (OO-ACS)

**Document Status:** Final Draft

**Team Name:** 3007-Team-Sixteen
**Group Number:** 16
**Organization:** 3007-Team-Sixteen

**Group Members:**
- Stephen Beaver (10423362) - Technical Lead & Infrastructure
- Kai Fletcher (23808253) - Testing & Quality Assurance
- Prem Patel (23775211) - RBAC & Financial Controls
- Muhammad Qureshi (23976415) - Session Management & Performance
- Kelly Snow (23614821) - Authentication & Security

## Project Overview
OO-ACS is a secure access control system for Oblivionaire Online MMORPG, providing robust authentication, role-based access control, and session management for both players and administrative staff.

## Repository Structure
```
oo-acs/
├── src/
│   ├── auth/      # Authentication system
│   ├── rbac/      # Role-based access control
│   ├── session/   # Session management
│   └── admin/     # Administrative tools
├── tests/         # Test suite
├── docs/          # Documentation
└── tools/         # Development tools
```

## Development Standards
- **Coding Standard**: SEI CERT C Coding Standard
- **Compiler**: GCC with C11 compliance
- **Compiler Flags**:
  ```cmake
  set(CMAKE_C_FLAGS "${CMAKE_C_FLAGS} -std=c11 -pedantic -Wall -Wextra -Werror -Wformat=2 -Wformat-security -Wformat-nonliteral -Wstack-protector -Warray-bounds=2 -Wstrict-aliasing=3 -Wstrict-overflow=4 -Wstringop-overflow=4 -Wstringop-truncation -Wvla -Wwrite-strings")
  set(CMAKE_C_FLAGS_DEBUG "${CMAKE_C_FLAGS_DEBUG} -fsanitize=address,undefined")
  ```
- **Testing Framework**: Unity
- **Static Analysis**: GCC -fanalyzer, Valgrind
- **Security Testing**: AFL++ fuzzing

## Development Environment
- **Linode Instances**:
  - Testing: Linode 1GB (Nanode)
  - Staging: Linode 2GB (Standard)
  - Production: Linode 2GB (Standard)

## Prerequisites
- GCC 11.0 or later
- CMake 3.20 or later
- libsodium 1.0.18 or later
- OpenSSL 3.0.0 or later
- Valgrind 3.18.1 or later

## Building the Project
```bash
# Clone the repository
git clone https://github.com/3007-team-sixteen/oo-acs.git
cd oo-acs

# Create build directory
mkdir build && cd build

# Configure with CMake
cmake ..

# Build the project
make

# Run tests
ctest --output-on-failure
```

## Security Features
- **Authentication System**
  - Argon2id password hashing via libsodium
  - Multi-factor authentication
  - Account recovery procedures
  - Session management

- **RBAC Implementation**
  - Hierarchical role system
  - Financial instrument access control
  - Permission inheritance
  - Audit logging

- **Security Measures**
  - Memory-safe operations
  - Input validation
  - Secure error handling
  - Automated security testing

## Testing Requirements
- Critical components: 80% minimum coverage
- Non-critical components: 60% minimum coverage
- Security-critical paths: 100% coverage
- Memory safety checks
- Input validation tests
- Performance testing

## Version Control
- **Branch Strategy**
  - `main`: Production-ready code
  - `develop`: Integration branch
  - `feature/*`: New features
  - `bugfix/*`: Bug fixes
  - `security/*`: Security-related changes

- **Security Measures**
  - GitHub commit signing with GPG keys
  - Branch protection rules
  - Required pull request reviews
  - Automated security checks

## Contributing
1. Create a feature branch from `develop`
2. Make your changes following our coding standards
3. Run all tests and security checks
4. Submit a pull request with required documentation
5. Address review comments

## Documentation
All project documentation is maintained in the `docs` directory, organized as follows:

```
docs/
├── standards/           # Coding standards and guidelines
│   ├── SEI-CERT-C.md   # SEI CERT C Coding Standard
│   ├── MISRA-C.md      # MISRA C:2012 Guidelines
│   └── C11-Standard.md # C11 Standard Implementation
├── testing/            # Testing framework and procedures
├── development/        # Development guidelines and patterns
├── security/          # Security documentation and procedures
├── project/           # Project management documentation
├── reference/         # Reference materials and resources
├── Home.md           # Documentation home page
└── documentation_requirements.md
```

Documentation is version controlled and maintained in markdown format. Each section contains detailed guidelines, implementation details, and reference materials specific to its domain.

## Development Standards
- C11 Standard compliance
- SEI CERT C Coding Standard
- MISRA C:2012 Guidelines
- OWASP Security Guidelines
- STRIDE Threat Modeling

## Security Standards
- CIA Triad Implementation
- ISM Guidelines
- CISA Guidelines
- NIST Guidelines

## Testing Standards
- Unity Testing Framework
- Static Analysis (gcc -fanalyzer)
- Memory Safety (Valgrind)
- Security Testing
- Performance Testing

## Reference Codebases
- curl: Memory management patterns
- OpenSSH: Authentication and session management
- FreeRADIUS: RBAC implementation

## Getting Started
[Development setup instructions will be added here]

## Contributing
[Contribution guidelines will be added here]

## License
[License information will be added here]
