# CITS3007 Secure Coding - Group Project Phase 1 Report
## Oblivionaire Online (OO) - Access Control System (ACS)

**Group Number:** 16

**Group Members:**
- Stephen Charles Beaver (10423362)
- Kai William Fletcher (23808253)
- Prem Bipinchandra Patel (23775211)
- Muhammad Daniyal Qureshi (23976415)
- Kelly Snow (23614821)

Player authentication – Ensuring that only registered players can log in. **Kelly**
wasteland wanderers to elite plutocratic overlords with access to game-altering financial
instruments - **Prem, Kai**
•Session management – Handling login sessions, preventing unauthorized access, and
dealing with connection timeouts or suspicious activity. **Mo**
•Admin and operations access – Providing secure tools for Enjjin’s staff to manage
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


## 1. Team Communication & Responsibilities

### 1.1 Communication Strategy

#### Meeting Schedule
- Weekly team meetings every [Day] at [Time] (Perth time)
- Additional ad-hoc meetings as needed for critical issues or blockers
- Sprint planning meetings every two weeks to align on goals and progress

#### Meeting Format
- Primary: Face-to-face sessions in Reid Library study rooms for regular meetings and complex design discussions
- Secondary: Video calls via Discord when in-person meetings are not possible
- Emergency: WhatsApp group chat for urgent communications

#### Communication Tools
- **Discord**: Primary platform for team communication
  - Dedicated channels for:
    - #general-discussion
    - #technical-issues
    - #code-reviews
    - #meeting-minutes
  - Voice channels for pair programming sessions
- **WhatsApp**: Quick updates and urgent communications
- **Google Calendar**: Meeting scheduling and deadline tracking
- **GitHub Projects**: Task tracking and project management
  - Kanban board for task visualization
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
   - Threat modeling and security reviews
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

5. **A fifth thing**

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
| Authentication System | TBD based on interest/experience | All team members |
| RBAC Implementation | TBD based on interest/experience | All team members |
| Session Management | TBD based on interest/experience | All team members |
| Admin Tools | TBD based on interest/experience | All team members |
| Security Testing | TBD based on interest/experience | All team members |
| User Interface | TBD based on interest/experience | All team members |

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
   - Code review approval from 2 team members
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
  - Instance Type: c5.4xlarge (transitioning to c6i.metal pending AWS limit increase)
  - Operating System: Ubuntu 22.04 LTS
  - Purpose:
    - Consistent development environment for all team members
    - Sufficient resources for running test environments
    - Support for hardware virtualization (pending c6i.metal)
  
- **Environment Setup**
  - Automated setup script (`setup.sh`) for environment configuration:
    - Locale configuration (en_AU.UTF-8)
    - System updates and security patches
    - Development tools and dependencies
    - KVM/QEMU virtualization stack
    - Vagrant with libvirt provider
  
- **Access Control**
  - AWS Security Groups for instance protection
  - SSH key-based authentication
  - Proper file permissions and user group management

### 3.2 Local Development Tools
- **IDE**: Visual Studio Code
  - Chosen for:
    - Remote SSH development support for EC2 instance
    - Extensive security-focused extensions
    - Built-in Git integration
    - Cross-platform compatibility

### 3.3 Required Extensions
1. **Remote Development**
   - Remote - SSH
   - Remote Explorer
   - Remote - Containers
   - Settings Sync

2. **Security and Linting**
   - SonarLint
   - ESLint
   - Security Audit
   - GitLens

3. **Collaboration**
   - Live Share
   - GitHub Pull Requests

### 3.4 Development Standards

#### Language Standards
- **C11 Compliance**
  - Strict adherence to ISO/IEC 9899:2011 (C11) standard
  - Compiler flags: `-std=c11 -pedantic -Wall -Wextra -Werror`
  - No compiler-specific extensions unless explicitly required
  - References: 
    - ISO/IEC 9899:2011 Programming Languages - C
    - CERT C Coding Standard (2016 Edition)

#### Code Formatting
- **Style Guide**: Based on Linux kernel coding style with modifications
  - 4 spaces for indentation (no tabs)
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
  - Clang Static Analyzer
  - Cppcheck
  - SonarQube with C/C++ plugin
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
- Unit test coverage > 90%
- Integration test coverage > 80%
- Security test coverage > 95%
- Fuzzing for all input-handling functions
- Memory leak checks in test suite

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
1. **AWS Infrastructure Issues**
   - Risk: Instance termination, availability zone issues, or service limits
   - Mitigation: Regular AMI backups, documented setup process
   - Contingency: Multi-zone failover plan, alternative instance types identified

2. **Development Environment Consistency**
   - Risk: Environment drift between team members or from production
   - Mitigation: Automated setup scripts, version-controlled configurations
   - Contingency: Regular environment validation and updates

3. **Security Vulnerabilities**
   - Risk: Unauthorized access, data breaches, AWS credential exposure
   - Mitigation: 
     - Security groups with minimal required access
     - Regular security audits and updates
     - Secure credential management
   - Contingency: Incident response plan, quick-fix protocols

4. **Performance Issues**
   - Risk: Resource constraints, network latency, virtualization overhead
   - Mitigation: 
     - Resource monitoring and scaling
     - Performance testing under load
     - AWS optimization best practices
   - Contingency: Instance type upgrades, performance tuning

5. **Data Loss**
   - Risk: Instance failure, accidental deletion, corruption
   - Mitigation: 
     - Regular backups
     - Version control for all code and configurations
     - AMI snapshots
   - Contingency: Disaster recovery procedures

#### Operational Risks
1. **Team Member Access**
   - Risk: SSH key management, AWS permission issues
   - Mitigation: 
     - Documented access procedures
     - Regular access review
     - Backup access methods
   - Contingency: Alternative access protocols

2. **AWS Service Limits**
   - Risk: vCPU limits, service quotas, API rate limits
   - Mitigation: 
     - Proactive limit increase requests
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
- Airbnb JavaScript Style Guide
- OWASP Secure Coding Guidelines
- Google C++ Style Guide

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
   - SonarQube analysis
   - Security vulnerability scanning
   - Dependency checking
   - Style guide enforcement 