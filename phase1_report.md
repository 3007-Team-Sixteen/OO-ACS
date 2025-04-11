# CITS3007 Secure Coding - Group Project Phase 1 Report
## Oblivionaire Online (OO) - Access Control System (ACS)

**Team Name:** 3007-Team-Sixteen

**Group Number:** 16

**Group Members:**
- Stephen Beaver (10423362)
- Kai Fletcher (23808253)
- Prem Patel (23775211)
- Muhammad Qureshi (23976415)
- Kelly Snow (23614821)

Player authentication – Ensuring that only registered players can log in. **Kelly**
wasteland wanderers to elite plutocratic overlords with access to game-altering financial
instruments - **Prem, Kai**
•Session management – Handling login sessions, preventing unauthorized access, and
dealing with connection timeouts or suspicious activity. **Mo**
•Admin and operations access – Providing secure tools for Enjjin's staff to manage
accounts, enforce bans, and troubleshoot authentication issues. **Steve** 

Although Roles have been assigned, as a group we believe that all participants should be conversant in all roles.

How will the group ensure accountability and track progress.

GitHub for deadlines, sprints, Project management.

Meetings - minutes are kept. Assigned roles tracked. Progress is assessed and evaluated.

Version Control Strategy

Agile Strategies in GitHub for versioning.
Ensure merging contributions are managed with Pull Requests.

Pull requests are ideally evaluated but collaborators can merge their own branches if necessary due to time constraints or other factors.

Main Branch -- Feature Branch

Examples of good naming conventions:
/feature-feature-name
/bugfix-bug-name

Find good convetions

**Development Tools**
EC2 Aws Server for dev environment
IDE is whichever the user is comfortable with
CI/CD pipeline setup for Monday
GDB, AFL++Clang - I'll research the others. Ensure choices are well justified.
Cloud Development Pipeline for uniformity.
git and GitHub Repos
Communication tools as already discussed.

**Key Secure Coding Issues**
Ensuring all keys remain unpublished (.gitignore)
Principle of least privileges. As it pertains to linux users.
Clear demarcation between players, ,game administrators, developers, anyone else.
Password hashing pracitces - md5, others?
This is important.
why it is relevant to the project
•how it will be applied during development, and
•how the group will ensure it is effectively used.


**Risk Management and Quality Assurance**
Redundancy and backups. 
Ensure that CI/CD pipeline is robustly configured.
Time Machine Backups
Research windows backups.

**Standards**
C11 standards.
Peer Reviews
Pull requests are ideally evaluated but collaborators can merge their own branches if necessary due to time constraints or other factors.
Find good, explicit, publically available style guides.

**Optional**
Team-16. 


# Phase 1 Report: Project Planning and Setup

## 0. Project Scope

### Core Responsibilities
- **Player Authentication** (Kelly)
  - Ensuring that only registered players can log in
  - Implementing secure login mechanisms
  - Managing player credentials and access control

- **Game Economy Management** (Prem, Kai)
  - Handling player progression from wasteland wanderers to elite plutocratic overlords
  - Managing game-altering financial instruments
  - Implementing secure economic transactions

- **Session Management** (Mo)
  - Handling login sessions
  - Preventing unauthorized access
  - Managing connection timeouts
  - Monitoring suspicious activity

- **Admin and Operations Access** (Steve)
  - Providing secure tools for Enjjin's staff
  - Managing accounts and enforcing bans
  - Troubleshooting authentication issues

### Cross-Training Strategy
Although roles have been assigned, the team believes in cross-training:
- All participants should be conversant in all roles
- Regular knowledge sharing sessions
- Documentation of all processes
- Peer review of critical components

## 1. Team Communication & Responsibilities

### 1.1 Communication Strategy

#### Meeting Schedule
- Weekly: Monday 10:00 at UWA
- Sprint planning: Fortnightly
- Emergency: Discord/WhatsApp

#### Meeting Format
- Primary: Face-to-face sessions in Reid Library study rooms for regular meetings and complex design discussions
- Secondary: Video calls via Discord when in-person meetings are not possible
- Emergency: WhatsApp group chat for urgent communications

#### Communication Tools
- **Discord**: Primary platform for team communication
  - Dedicated channels:
    - #general-discussion
    - #technical-issues
    - #code-reviews
    - #meeting-minutes
  - Voice channels for pair programming sessions
- **WhatsApp**: Quick updates and urgent communications
- **Google Calendar**: Meeting scheduling and deadline tracking
- **GitHub Projects**: Task tracking and project management
  - Kanban board for task visualisation
  - Issue tracking integrated with code
  - Milestone tracking for deliverables
  - Automated project updates via commits and PRs

### 1.2 Responsibility Allocation

#### Shared Responsibilities & Skills
All team members will contribute across different areas based on their strengths and interests. Key areas include:

1. **Project Coordination**
   - Sprint planning and task tracking
   - Meeting facilitation and note-taking
   - Progress monitoring
   - Documentation maintenance
   
2. **Security Implementation**
   - Threat modelling and security reviews
   - RBAC design and implementation
   - Security testing and validation
   - Security documentation
   
3. **Development**
   - Code architecture and implementation
   - Code reviews
   - Technical documentation
   - Development standards compliance
   
4. **Quality Assurance**
   - Test strategy and implementation
   - CI/CD pipeline management
   - Performance testing
   - Security testing

5. **Infrastructure Management**
   - AWS environment maintenance
   - Development environment setup
   - Security configuration
   - Backup and recovery procedures

Initial task assignments will be based on:
- Individual preferences and experience
- Balanced workload distribution
- Opportunities for skill development
- Peer learning and knowledge sharing

#### Task Distribution Strategy
Rather than fixed roles, we will:
- Rotate responsibilities to build shared understanding
- Pair program on complex features
- Cross-train on critical components
- Encourage skill development in new areas

#### Task Distribution Matrix
| Area of Responsibility | Primary Contributors | Supporting Contributors |
|----------------------|---------------------|----------------------|
| Authentication System | Kelly Snow | All team members |
| RBAC Implementation | Prem Patel, Kai Fletcher | All team members |
| Session Management | Muhammad Qureshi | All team members |
| Admin Tools | Stephen Beaver | All team members |
| Security Testing | All team members | All team members |
| User Interface | All team members | All team members |

### 1.3 Progress Tracking & Accountability

- **Daily Updates**: Team members post daily progress in Discord #status channel
- **Weekly Reviews**: Progress assessment during weekly meetings
- **Burndown Charts**: Track velocity and remaining work
- **Peer Reviews**: Code review requirements before merging
- **Documentation Updates**: Regular wiki updates tracking decisions and progress

### 1.4 Meeting & Participation Expectations

#### Attendance Policy
- **Meeting Notification**
  - Members must confirm attendance 24 hours before scheduled meetings
  - Unavoidable absences must be communicated at least 2 hours before meeting
  - Emergency absences should be notified as soon as possible via WhatsApp

#### No-Show Protocol
1. **First Instance**
   - Team lead will contact member via WhatsApp
   - Member must provide catch-up plan within 24 hours
   - Missed work to be redistributed if critical path affected

2. **Second Instance**
   - Formal discussion in next team meeting
   - Written explanation required
   - Adjustment of responsibilities if needed
   - Development of catch-up plan with specific deadlines

3. **Persistent Issues**
   - Meeting with unit coordinator
   - Formal documentation of attendance issues
   - Potential reassignment of critical path tasks
   - Review of team member's role and responsibilities

#### Contribution Monitoring
- **Weekly Contribution Review**
  - Code commits and pull requests
  - Documentation updates
  - Meeting participation
  - Task completion rate

- **Intervention Triggers**
  - Missing two consecutive meetings without notice
  - No code commits for one week without explanation
  - Consistently late or incomplete deliverables
  - Non-responsive for > 24 hours during critical sprints

#### Support Measures
- Pair programming sessions for struggling members
- Flexible meeting times for legitimate scheduling conflicts
- Recording of important meetings for async review
- Regular 1-on-1 check-ins if performance issues arise

#### Escalation Path
1. **Team-Level Resolution**
   - Direct communication with member
   - Team meeting discussion
   - Workload adjustment if needed

2. **Unit Coordinator Involvement**
   - If team-level resolution fails
   - Documentation of issues and attempted resolutions
   - Formal meeting with coordinator and member

3. **Final Measures**
   - Reassignment of critical responsibilities
   - Adjustment of project scope if necessary
   - Documentation of impact on project timeline

## 2. Version Control Strategy

### 2.1 Repository Hosting
- Platform: GitHub Enterprise
- Private repository with branch protection
- Repository Structure:
  ```
  oo-acs/
  ├── src/
  │   ├── auth/
  │   ├── rbac/
  │   ├── session/
  │   └── admin/
  ├── tests/
  ├── docs/
  └── tools/
  ```

### 2.2 Branching Strategy
- GitFlow workflow with the following branches:
  - `main`: Production-ready code
  - `develop`: Integration branch
  - `feature/*`: New features
  - `bugfix/*`: Bug fixes
  - `security/*`: Security-related changes
  - `release/*`: Release preparation

### 2.3 Merge Process
1. Feature branches created from `develop`
2. Pull Request (PR) required for all changes
3. PR Requirements:
   - Passing CI/CD checks
   - Security scan clearance
   - Code review approval from at least one team member
   - Up-to-date documentation
4. Squash merging to maintain clean history

### 2.4 Version Control Policies

#### Commit Message Convention
```
<type>(<scope>): <subject>

<body>

<footer>
```
Types:
- feat: New feature
- fix: Bug fix
- sec: Security update
- docs: Documentation
- test: Testing
- refactor: Code refactoring

#### Branch Naming Convention
- `feature/ACS-<ticket>-description`
- `bugfix/ACS-<ticket>-description`
- `security/ACS-<ticket>-description`

## 3. Development Tools

### 3.1 Development Environment
- **AWS EC2 Development Instance**
  - Instance Type: Ubuntu 20.04 LTS (matching CITS3007 development environment)
  - Purpose:
    - Consistent development environment for all team members
    - Replica of CITS3007 development environment
    - Automated provisioning using provided scripts
  
- **Environment Setup**
  - Automated setup scripts from CITS3007:
    - `provision-01.sh`: Basic system setup and utilities
    - `provision-02.sh`: Development tools and environment configuration
  - Additional security tools:
    - AFL++ for fuzzing
    - Clang tools for static analysis
    - Valgrind for memory analysis
    - GDB for debugging
    - Splint for static analysis

### 3.2 Development Tools
- **IDE**: Individual choice with security-focused configuration
  - Common security extensions:
    - Static analysis tools
    - Memory leak detection
    - Code coverage tools
    - Security scanning
  - Required configurations:
    - C11 compliance
    - Warning levels set to maximum
    - Security-focused linting rules

### 3.3 Security Tools
1. **Static Analysis**
   - Clang Static Analyser
   - Cppcheck
   - Splint
   - Coverity Scan (weekly)

2. **Dynamic Analysis**
   - Valgrind
   - AFL++
   - Address Sanitiser
   - Thread Sanitiser
   - Undefined Behaviour Sanitiser

3. **Security Analysis**
   - Password Hashing: Argon2id
     - Implementation: libsodium's crypto_pwhash
     - Parameters:
       - Memory cost: 64MB
       - Time cost: 3
       - Parallelism: 4
     - Justification:
       - Winner of Password Hashing Competition
       - Memory-hard function resistant to GPU/ASIC attacks
       - Configurable parameters for security/performance balance
       - Built-in salt generation and storage

4. **Code Coverage**
   - Gcov for coverage analysis
   - Gcovr for coverage reporting
   - Integration with CI/CD pipeline

### 3.4 Development Standards

#### Language Standards
- **C11 Compliance**
  - Strict adherence to ISO/IEC 9899:2011 (C11) standard
  - Compiler flags: `-std=c11 -pedantic -Wall -Wextra -Werror`
  - No compiler-specific extensions unless explicitly required

#### Code Formatting
- **Style Guide**: Google C++ Style Guide (adapted for C)
  - 2 spaces for indentation
  - Maximum line length: 80 characters
  - Function names: `snake_case`
  - Constants and macros: `UPPER_CASE`
  - Struct names: `PascalCase`
  - Local variables: `snake_case`

#### Security Standards
- **CERT C Secure Coding Standard**
  - INT30-C: Ensure operations on unsigned integers cannot wrap
  - STR31-C: Guarantee null termination for string operations
  - MEM35-C: Allocate sufficient memory for an object
  - ERR33-C: Detect and handle errors
  
- **MISRA C:2012 Guidelines**
  - Mandatory rules compliance required
  - Advisory rules evaluated per case
  - Deviations must be documented and reviewed

#### Static Analysis
- Enforced through CI/CD pipeline:
  - Clang Static Analyser
  - Cppcheck
  - Splint
  - Coverity Scan (weekly full codebase analysis)

#### Memory Safety
- Mandatory use of:
  - Bounds checking for all array operations
  - Safe string functions (`strncpy`, `strncat`, etc.)
  - Memory leak detection (Valgrind in CI pipeline)
  - Buffer overflow prevention techniques

#### Documentation
- **Function Documentation**
  ```c
  /**
   * @brief Brief description
   * @param param1 Description of param1
   * @return Description of return value
   * @throws Description of error conditions
   * @note Any special considerations
   */
  ```
- **Security-Critical Code**
  - Threat model references
  - Security assumptions
  - Input validation requirements
  - Error handling expectations

#### Testing Requirements
- Unit tests: >90% coverage
- Integration tests: >80% coverage
- Security tests: >95% coverage
- Memory leak checks
- Fuzzing for input functions

#### Code Review Checklist
1. C11 compliance verification
2. Security requirements adherence
3. Error handling completeness
4. Memory management correctness
5. Input validation thoroughness
6. Documentation completeness

#### Environment Enforcement
- Compiler settings in `CMakeLists.txt`:
  ```cmake
  set(CMAKE_C_FLAGS "${CMAKE_C_FLAGS} -std=c11 -pedantic -Wall -Wextra -Werror")
  set(CMAKE_C_FLAGS_DEBUG "${CMAKE_C_FLAGS_DEBUG} -fsanitize=address,undefined")
  ```
- Pre-commit hooks for:
  - Style checking
  - Static analysis
  - Documentation validation

### 3.5 Environment Management
- **Instance Lifecycle**
  - Creation: AWS CLI commands for instance launch
  - Configuration: Automated setup script
  - Maintenance: Regular updates and security patches
  - Backup: AMI snapshots for environment preservation

- **Resource Monitoring**
  - AWS CloudWatch for instance metrics
  - System logging and monitoring
  - Performance tracking

- **Access Management**
  - Team member SSH key distribution
  - AWS IAM roles and permissions
  - Security group management

## 4. Key Secure Coding Practices

### 4.1 Input Validation and Sanitization
**Relevance**: Critical for preventing injection attacks in authentication and admin operations.

**Implementation**:
- Schema validation for all API endpoints
- Parameterized queries for database operations
- Content security policies for admin interface
- Regular expression validation for user inputs

**Enforcement**:
- Automated testing of input validation
- Security scanning in CI/CD pipeline
- Code review checklist items
- Regular security audits

### 4.2 Session Management
**Relevance**: Essential for maintaining secure user sessions and preventing unauthorized access.

**Implementation**:
- Secure session token generation
- Token rotation policies
- Session timeout controls
- Anti-CSRF measures

**Enforcement**:
- Session security testing suite
- Automated session handling tests
- Regular penetration testing
- Security headers verification

### 4.3 Access Control
**Relevance**: Core functionality for RBAC implementation and privilege management.

**Implementation**:
- Role-based access control (RBAC)
- Principle of least privilege
- Permission verification middleware
- Audit logging

**Enforcement**:
- Access control unit tests
- Role hierarchy validation
- Permission matrix testing
- Regular access control audits

## 5. Risk Management & Quality Assurance

### 5.1 Risk Management

#### Technical Risks
1. **AWS Infrastructure**
   - Mitigation: Regular AMI backups
   - Contingency: Multi-zone failover

2. **Security Vulnerabilities**
   - Mitigation: Regular audits
   - Contingency: Incident response plan

3. **Performance Issues**
   - Mitigation: Resource monitoring
   - Contingency: Instance upgrades

4. **Data Loss**
   - Risk: Instance failure, accidental deletion, corruption
   - Mitigation: 
     - Regular backups
     - Version control for all code and configurations
     - AMI snapshots
   - Contingency: Disaster recovery procedures

#### Operational Risks
1. **Team Access**
   - Risk: SSH key management, AWS permission issues
   - Mitigation: 
     - Documented access procedures
     - Regular access review
     - Backup access methods
   - Contingency: Alternative access protocols

2. **AWS Limits**
   - Risk: vCPU limits, service quotas, API rate limits
   - Mitigation: 
     - Proactive limit requests
     - Resource usage monitoring
     - Alternative instance type planning
   - Contingency: Temporary workarounds with available resources

3. **Cost Management**
   - Risk: Unexpected AWS charges, resource waste
   - Mitigation: 
     - Budget monitoring
     - Instance scheduling
     - Resource tagging
   - Contingency: Cost optimization strategies

4. **Team Member Unavailability**
   - Risk: Knowledge silos, access dependencies
   - Mitigation: 
     - Cross-training on AWS operations
     - Documented procedures
     - Shared access protocols
   - Contingency: Task redistribution plan

### 5.2 Quality Assurance

#### Code Quality Standards
- Google C++ Style Guide (adapted for C)
- CERT C Secure Coding Standard
- MISRA C:2012 Guidelines

#### Quality Control Measures
1. **Automated Testing**
   - Unit tests (90% coverage minimum)
   - Integration tests
   - Security tests
   - Performance tests

2. **Code Review Process**
   - Security-focused checklist
   - Performance impact analysis
   - Documentation review
   - Test coverage verification

3. **Static Analysis**
   - Clang Static Analyser
   - Cppcheck
   - Splint
   - Coverity Scan

4. **Dynamic Analysis**
   - Valgrind
   - AFL++
   - Address Sanitiser
   - Thread Sanitiser
   - Undefined Behaviour Sanitiser

5. **Security Analysis**
   - STRIDE threat modeling
   - Security scanning
   - Penetration testing
   - Vulnerability assessment

6. **Performance Analysis**
   - Profiling with perf
   - Load testing
   - Resource monitoring
   - Bottleneck identification 

### 5.3 Backup Policies

#### Time Machine Backup Policy
1. **Configuration**
   - Backup frequency: Hourly
   - Retention period: 30 days
   - Backup location: External encrypted drive
   - Encryption: FileVault 2 enabled

2. **Verification Procedures**
   - Daily verification of backup integrity
   - Weekly test restore of random files
   - Monthly full system restore test
   - Automated backup health monitoring

3. **Security Measures**
   - Encrypted backups using AES-256
   - Secure backup location with restricted access
   - Regular backup rotation
   - Offsite backup copy maintained

#### Windows Backup Policy
1. **Configuration**
   - Backup tool: Windows Backup and Restore
   - Backup frequency: Daily
   - Retention period: 30 days
   - Backup location: Network drive with encryption

2. **Verification Procedures**
   - Automated backup verification
   - Weekly integrity checks
   - Monthly restore testing
   - Backup health monitoring

3. **Security Measures**
   - BitLocker encryption for backup storage
   - Access control lists for backup locations
   - Regular backup rotation
   - Offsite backup copy maintained

### 5.4 CI/CD Pipeline Documentation

#### Pipeline Configuration
1. **Build Stage**
   ```yaml
   build:
     - Install dependencies
     - Compile with security flags (-std=c11 -pedantic -Wall -Wextra -Werror)
     - Run static analysis (Clang Static Analyzer, Cppcheck)
     - Generate documentation
   ```

2. **Test Stage**
   ```yaml
   test:
     - Run unit tests (Google Test)
     - Run integration tests
     - Run security tests (AFL++, LibFuzzer)
     - Generate coverage report (gcov/gcovr)
   ```

3. **Analysis Stage**
   ```yaml
   analysis:
     - Run Valgrind for memory analysis
     - Run AddressSanitizer
     - Run ThreadSanitizer
     - Run Clang Static Analyzer
     - Run Cppcheck
   ```

4. **Security Stage**
   ```yaml
   security:
     - Run AFL++ fuzzing
     - Run LibFuzzer tests
     - Check for common vulnerabilities
     - Verify security headers
     - Scan for sensitive data
   ```

#### Integration with Security Tools
1. **Static Analysis Integration**
   - Clang Static Analyzer (daily)
   - Cppcheck (weekly)
   - Zero high-priority warnings

2. **Dynamic Analysis Integration**
   - Valgrind (memory safety)
   - AddressSanitizer (quick checks)
   - ThreadSanitizer (concurrency)
   - Zero memory leaks

3. **Security Analysis Integration**
   - AFL++ (fuzzing)
   - LibFuzzer (unit testing)
   - Regular security reviews

4. **Code Quality Integration**
   - Clang-tidy (style)
   - Flawfinder (security)
   - Style consistency

### 5.5 Style Guides

#### C Code Style Guide
- **Primary Guide**: Google C++ Style Guide (adapted for C)
  - Link: https://google.github.io/styleguide/cppguide.html
  - Adaptations for C:
    - Function naming: `snake_case`
    - Struct naming: `PascalCase`
    - Constants: `UPPER_CASE`
    - Local variables: `snake_case`

#### Security Standards
- **CERT C Secure Coding Standard**
  - Link: https://wiki.sei.cmu.edu/confluence/display/c/SEI+CERT+C+Coding+Standard
  - Key rules:
    - INT30-C: Ensure operations on unsigned integers cannot wrap
    - STR31-C: Guarantee null termination for string operations
    - MEM35-C: Allocate sufficient memory for an object
    - ERR33-C: Detect and handle errors

- **MISRA C:2012 Guidelines**
  - Link: https://www.misra.org.uk/misra-c/
  - Implementation:
    - Mandatory rules compliance required
    - Advisory rules evaluated per case
    - Deviations must be documented and reviewed

#### Documentation Standards
- **Doxygen Style Guide**
  - Link: https://www.doxygen.nl/manual/docblocks.html
  - Implementation:
    ```c
    /**
     * @brief Brief description
     * @param param1 Description of param1
     * @return Description of return value
     * @throws Description of error conditions
     * @note Any special considerations
     */
    ```

#### Testing Standards
- **Google Test Framework**
  - Link: https://google.github.io/googletest/
  - Implementation:
    - Unit test structure
    - Test naming conventions
    - Test documentation requirements
    - Coverage requirements

#### Version Control Standards
- **Conventional Commits**
  - Link: https://www.conventionalcommits.org/
  - Implementation:
    ```
    <type>(<scope>): <subject>
    
    <body>
    
    <footer>
    ```
  - Types:
    - feat: New feature
    - fix: Bug fix
    - sec: Security update
    - docs: Documentation
    - test: Testing
    - refactor: Code refactoring 

### 5.6 Development Timeline

#### Phase 1 (Current)
- Week 1: Project setup
- Week 2: Environment config
- Week 3: Security implementation
- Week 4: Testing and docs

#### Phase 2 (Tentative)
- Week 1: Core functionality
- Week 2: Security features
- Week 3: Testing
- Week 4: Final docs

#### Buffer Time
- 1 week contingency per phase
- Regular progress reviews
- Flexible task allocation
- Priority-based scheduling

### 5.7 Security Implementation Details

#### RBAC Implementation
1. **Role Hierarchy**
   ```c
   typedef enum {
       ROLE_PLAYER,
       ROLE_MODERATOR,
       ROLE_ADMIN,
       ROLE_SYSTEM
   } role_t;
   ```

2. **Permission Management**
   ```c
   typedef struct {
       role_t role;
       permission_t permissions;
       time_t valid_until;
   } access_token_t;
   ```

#### Session Management
1. **Token Generation**
   ```c
   typedef struct {
       char token[TOKEN_LENGTH];
       time_t issued_at;
       time_t expires_at;
       char session_id[SESSION_ID_LENGTH];
   } session_token_t;
   ```

2. **Security Measures**
   - Token rotation every 15 minutes
   - Concurrent session limit: 3
   - Session timeout: 30 minutes
   - IP-based session validation

#### Authentication System
1. **Password Policies**
   - Minimum length: 12 characters
   - Required character types: 3
   - Maximum age: 90 days
   - History: 5 previous passwords

2. **Account Recovery**
   - Security questions: 3 required
   - Recovery email verification
   - Temporary password expiration: 24 hours
   - Failed attempts limit: 5

### 5.8 Quality Metrics

#### Code Quality
- Cyclomatic complexity: < 10
- Function length: < 50 lines
- Comment density: > 20%
- Duplication: < 5%

#### Security Metrics
- Static analysis warnings: 0
- Memory leaks: 0
- Buffer overflows: 0
- Race conditions: 0

#### Testing Metrics
- Unit test coverage: > 90%
- Integration test coverage: > 80%
- Security test coverage: > 95%
- Performance test pass rate: 100%

### 5.9 Documentation Requirements

#### Code Documentation
1. **Function Headers**
   ```c
   /**
    * @brief Brief description
    * @param param1 Description of param1
    * @return Description of return value
    * @throws Description of error conditions
    * @note Any special considerations
    * @security Security implications
    * @performance Performance considerations
    */
   ```

2. **Security Documentation**
   - Threat model references
   - Security assumptions
   - Input validation requirements
   - Error handling expectations

#### Project Documentation
1. **Architecture Decisions**
   - Decision context
   - Alternatives considered
   - Security implications
   - Performance impact

2. **Security Policies**
   - Access control rules
   - Session management
   - Password policies
   - Audit requirements

## 6. Reference Documentation

### Style Guides and Standards
1. **Google C++ Style Guide (adapted for C)**
   - Link: https://google.github.io/styleguide/cppguide.html
   - Used for: Code formatting, naming conventions, and general coding practices

2. **CERT C Secure Coding Standard**
   - Link: https://wiki.sei.cmu.edu/confluence/display/c/SEI+CERT+C+Coding+Standard
   - Key rules implemented:
     - INT30-C: Ensure operations on unsigned integers cannot wrap
     - STR31-C: Guarantee null termination for string operations
     - MEM35-C: Allocate sufficient memory for an object
     - ERR33-C: Detect and handle errors

3. **MISRA C:2012 Guidelines**
   - Link: https://www.misra.org.uk/misra-c/
   - Used for: Mandatory and advisory coding rules compliance

4. **Doxygen Documentation Style**
   - Link: https://www.doxygen.nl/manual/docblocks.html
   - Used for: Code documentation format and standards

### Testing Frameworks
1. **Google Test Framework**
   - Link: https://google.github.io/googletest/
   - Used for: Unit testing structure and implementation

### Version Control Standards
1. **Conventional Commits**
   - Link: https://www.conventionalcommits.org/
   - Used for: Commit message formatting and standardization

### Security Tools Documentation
1. **AFL++ (American Fuzzy Lop)**
   - Link: https://github.com/AFLplusplus/AFLplusplus
   - Used for: Fuzzing and security testing

2. **Clang Static Analyzer**
   - Link: https://clang-analyzer.llvm.org/
   - Used for: Static code analysis

3. **Cppcheck**
   - Link: https://cppcheck.sourceforge.io/
   - Used for: Static analysis of C/C++ code

4. **Valgrind**
   - Link: https://valgrind.org/
   - Used for: Memory debugging and profiling

5. **Coverity Scan**
   - Link: https://scan.coverity.com/
   - Used for: Static analysis and security scanning

### Development Tools
1. **GDB (GNU Debugger)**
   - Link: https://www.gnu.org/software/gdb/
   - Used for: Debugging and code analysis

2. **Gcov/Gcovr**
   - Link: https://gcc.gnu.org/onlinedocs/gcc/Gcov.html
   - Used for: Code coverage analysis

3. **Splint**
   - Link: https://splint.org/
   - Used for: Static analysis of C programs

### AWS Documentation
1. **AWS EC2 Documentation**
   - Link: https://docs.aws.amazon.com/ec2/
   - Used for: Development environment setup and management

2. **AWS IAM Documentation**
   - Link: https://docs.aws.amazon.com/IAM/
   - Used for: Access management and security

### CI/CD Tools
1. **GitHub Actions**
   - Link: https://docs.github.com/en/actions
   - Used for: Continuous integration and deployment

2. **CMake Documentation**
   - Link: https://cmake.org/documentation/
   - Used for: Build system configuration

### Security Standards
1. **STRIDE Threat Modeling**
   - Link: https://docs.microsoft.com/en-us/azure/security/develop/threat-modeling-tool-threats
   - Used for: Security threat analysis

2. **OWASP Security Guidelines**
   - Link: https://owasp.org/www-project-secure-coding-practices-quick-reference-guide/
   - Used for: Secure coding practices

### Backup Solutions
1. **Time Machine Documentation**
   - Link: https://support.apple.com/en-us/HT201250
   - Used for: macOS backup configuration

2. **Windows Backup and Restore**
   - Link: https://support.microsoft.com/en-us/windows/backup-and-restore-in-windows-10-352091d2-bb9d-3ea3-ed18-52ef2b88cbef
   - Used for: Windows backup configuration
