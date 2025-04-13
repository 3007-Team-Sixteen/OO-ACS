# Phase 1 Report - Revision Suggestions

## Style Guide Changes
1. Replace Google C++ Style Guide with SEI CERT C Coding Standard
   - Current: Using Google C++ Style Guide adapted for C
   - Suggestion: Switch to SEI CERT C Coding Standard as it's specifically designed for security-critical C applications
   - Action Required: [x] Accept [ ] Reject [ ] Modify
   - Implementation Details:
     - Replace Section 3.4 "Development Standards" in current report
     - Update compiler flags to:
       ```cmake
       set(CMAKE_C_FLAGS "${CMAKE_C_FLAGS} -std=c11 -pedantic -Wall -Wextra -Werror -Wformat=2 -Wformat-security -Wformat-nonliteral -Wstack-protector -Warray-bounds=2 -Wstrict-aliasing=3 -Wstrict-overflow=4 -Wstringop-overflow=4 -Wstringop-truncation -Wvla -Wwrite-strings")
       set(CMAKE_C_FLAGS_DEBUG "${CMAKE_C_FLAGS_DEBUG} -fsanitize=address,undefined")
       ```
     - Coding Style Rules:
       - Indentation: 4 spaces (no tabs)
       - Line length: 80 characters max
       - Function names: snake_case
       - Constants: UPPER_CASE
       - Struct names: PascalCase
       - Local variables: snake_case
       - Comments: Doxygen style
       - Braces: K&R style
     - Update coding standards to align with SEI CERT C guidelines
     - Modify CMakeLists.txt configuration
     - Update pre-commit hooks for style checking
     - Add specific security-focused rules from SEI CERT C
   - Annotations:
     ```text
     Decision made to use SEI CERT C Coding Standard because:
     1. Specifically designed for security-critical applications
     2. C11 compliant (unlike Linux Kernel Style Guide which uses gnu11)
     3. Directly addresses our project's needs (authentication, access control)
     4. More modern and security-focused than MISRA C
     5. Freely available and well-documented
     6. Provides a single, consistent style guide (avoiding mixed standards)
     
     Lecture References:
     - lect01--intro.md: Emphasizes importance of secure coding standards
     - lect09--dev.md: Discusses C11 compliance and compiler flags
     - lect09b--dev.md: Covers development environment setup and standards
     ```

2. Reference Additional Style Guides
   - Action Required: [ ] Accept [x] Reject [ ] Modify
   - Implementation Details:
     - Remove references to other style guides
     - Focus solely on SEI CERT C Coding Standard
   - Annotations:
     ```text
     Rejected: We should use a single, consistent style guide (SEI CERT C) rather than mixing multiple standards.
     This ensures consistency and avoids potential conflicts between different style guides.
     
     Lecture References:
     - lect09--dev.md: Emphasizes importance of consistent coding standards
     - lect-project-tips.md: Recommends focusing on core standards
     ```

## Security Standards
3. Add Australian Context
   - ISM (Information Security Manual) guidelines
   - Reference: https://www.cyber.gov.au/sites/default/files/2025-03/18.%20ISM%20-%20Guidelines%20for%20software%20development%20%28March%202025%29.pdf
   - Action Required: [x] Accept [ ] Reject [ ] Modify
   - Implementation Details:
     - Add new section in security standards
     - Focus on ISM Section 18 controls:
       - ISM-1759: Secure development lifecycle
       - ISM-1760: Secure coding practices
       - ISM-1761: Security testing
       - ISM-1762: Vulnerability management
     - Update security requirements
     - Modify compliance documentation
     - Update testing procedures
   - Annotations:
     ```text
     Decision to use ISM over ASD because:
     1. ISM has specific guidelines for software development
     2. More comprehensive for our needs
     3. Directly addresses secure coding practices
     4. Better alignment with SEI CERT C approach
     
     Lecture References:
     - lect01--intro.md: Discusses importance of security standards
     - lect09--dev.md: Covers secure development practices
     - lect-project-tips.md: Emphasizes practical security implementation
     ```

4. Add Core Security Concepts
   - Defence in depth
   - CIA triad (Confidentiality, Integrity, Availability)
   - Formal verification (if system is small enough)
   - Principle of least privilege (needs more explicit coverage)
   - Action Required: [x] Accept [ ] Reject [ ] Modify
   - Implementation Details:
     - Update Section 4 "Key Secure Coding Practices"
     - Focus on practical, implementable security measures:
       1. Defence in depth:
          - Basic password authentication using libsodium:
            - Simple to implement and understand
            - Memory-safe operations
            - Well-documented
            - C11 compatible
            - Parameters:
              - Algorithm: Argon2id
              - Memory cost: 64MB
              - Time cost: 3
              - Parallelism: 4
              - Salt length: 16 bytes
              - Hash length: 32 bytes
          - Simple session management:
            - Session timeout: 30 minutes
            - Max concurrent sessions: 3
            - Session token length: 32 bytes
          - Basic RBAC implementation:
            - Roles: player, moderator, admin
            - Permission inheritance
            - Access control lists
       2. CIA triad:
          - Confidentiality: libsodium encryption, basic access control
          - Integrity: Input validation, basic error checking
          - Availability: Simple error handling, basic logging
       3. Formal verification:
          - Unit testing: 80% coverage minimum
          - Input validation: All user inputs
          - Security testing:
            - Static analysis: gcc -fanalyzer
            - Memory safety: Valgrind
            - Basic fuzzing: AFL++
            - Input validation testing
            - Boundary condition testing
            - Automated vulnerability scanning
       4. Principle of least privilege:
          - Simple role-based access
          - Basic permission system
          - Clear documentation of access levels
   - Annotations:
     ```text
     Adjusted to be more appropriate for an undergraduate project:
     1. Focus on implementable security measures
     2. Avoid over-engineering
     3. Prioritize basic security over complex systems
     4. Ensure concepts are teachable and understandable
     5. Balance security requirements with project scope
     6. Using libsodium for cryptography because:
        - Memory-safe operations
        - Simple to use correctly
        - Well-documented
        - C11 compatible
        - Appropriate for project scope
        - Recommended in secure coding practices
     
     Lecture References:
     - lect04--access.md: Covers RBAC and access control principles
     - lect05--validation.md: Discusses input validation and security
     - lect08--crypto.md: Details cryptographic implementations
     - lect08b--crypto.md: Covers password hashing and security
     - lect07--concurrency.md: Addresses session management
     ```

## Development Environment
5. Separate Development Environments
   - Current: Single development environment
   - Suggestion: Implement separate Linode instances managed by Ansible for:
     - Testing
     - Staging
     - Production
   - Action Required: [x] Accept [ ] Reject [ ] Modify
   - Implementation Details:
     - Update Section 3.1 "Development Environment"
     - Infrastructure as Code using Ansible:
       - Environment provisioning
       - Configuration management
       - Security hardening
       - Deployment automation
       - Playbook Structure:
         ```
         ansible/
         ├── inventory/
         │   ├── testing
         │   ├── staging
         │   └── production
         ├── group_vars/
         │   ├── all.yml
         │   ├── testing.yml
         │   ├── staging.yml
         │   └── production.yml
         ├── roles/
         │   ├── common/
         │   ├── security/
         │   ├── application/
         │   └── monitoring/
         └── playbooks/
             ├── site.yml
             ├── testing.yml
             ├── staging.yml
             └── production.yml
         ```
       - GitHub Integration:
         - Store playbooks in GitHub repository
         - Use GitHub Actions for deployment:
           ```yaml
           name: Deploy to Environment
           on:
             push:
               branches: [ main ]
           jobs:
             deploy:
               runs-on: ubuntu-latest
               steps:
                 - uses: actions/checkout@v2
                 - name: Deploy to Testing
                   if: github.ref == 'refs/heads/main'
                   run: |
                     ansible-playbook -i inventory/testing playbooks/testing.yml
           ```
         - GitHub Secrets for credentials:
           - LINODE_API_TOKEN
           - ANSIBLE_VAULT_PASSWORD
           - SSH_PRIVATE_KEY
     - Linode Configuration:
       - Instance Types:
         - Testing: Linode 1GB (Nanode)
         - Staging: Linode 2GB (Standard)
         - Production: Linode 2GB (Standard)
       - Network Configuration:
         - Private networking enabled
         - Firewall rules per environment
         - SSH key authentication only
       - Security groups
       - Backup policies:
         - Daily automated backups
         - 7-day retention
     - Environment Specifications:
       - Testing: Smallest instance type
       - Staging: Medium instance type
       - Production: Medium instance type
   - Annotations:
     ```text
     Moving from AWS to Linode + Ansible because:
     1. Linode:
        - Simpler pricing structure
        - More straightforward for undergraduates
        - Good documentation
        - Sufficient for project scope
     2. Ansible:
        - Configuration as code
        - Reproducible environments
        - Easy to version control
        - Good for team collaboration
     3. Environment separation:
        - Separate instances instead of VPCs
        - Network isolation via Linode features
        - Simpler to manage
        - More cost-effective
     4. GitHub Integration:
        - Version control for playbooks
        - Automated deployments
        - Secure credential management
        - Team collaboration
     
     Lecture References:
     - lect09--dev.md: Discusses development environment setup
     - lect09b--dev.md: Covers infrastructure and deployment
     - lect-project-tips.md: Emphasizes practical implementation
     ```

## Testing Framework
6. Testing Framework Concerns
   - Question feasibility of 90% unit test coverage
   - Consider C-specific testing frameworks
   - Note potential C11 compliance issues with Google Test
   - Action Required: [x] Accept [ ] Reject [ ] Modify
   - Implementation Details:
     - Update Section 3.4 "Testing Requirements"
     - Testing Framework: Unity
       - C-specific testing framework
       - Simple to use and understand
       - C11 compliant
       - Good documentation
       - Integrates with Valgrind and gcc analyzer
     - Test Coverage Requirements:
       - Critical components: 80% minimum
         - Authentication system (lect08--crypto.md)
         - Session management (lect07--concurrency.md)
         - Access control (lect04--access.md)
       - Non-critical components: 60% minimum
       - Security-critical paths: 100%
     - Test Categories (based on lectures):
       1. Memory Safety (lect02--memory.md, lect03--memory2.md):
          - Memory allocation/deallocation
          - Buffer overflows
          - Memory leaks
       2. Input Validation (lect05--validation.md):
          - User input sanitization
          - Boundary conditions
          - Format strings
       3. Access Control (lect04--access.md):
          - RBAC implementation
          - Permission checks
          - Session validation
       4. Cryptography (lect08--crypto.md):
          - PBKDF2 implementation
          - Key management
          - Random number generation
     - Test Structure:
       ```c
       #include "unity.h"
       #include <valgrind/memcheck.h>
       
       void setUp(void) {
           // Setup code
       }
       
       void tearDown(void) {
           // Cleanup code
       }
       
       void test_memory_safety(void) {
           // Memory safety tests
           TEST_ASSERT_EQUAL(0, VALGRIND_COUNT_LEAKS());
       }
       
       void test_input_validation(void) {
           // Input validation tests
           TEST_ASSERT_EQUAL(0, validate_input("valid input"));
           TEST_ASSERT_EQUAL(-1, validate_input("invalid input"));
       }
       
       int main(void) {
           UNITY_BEGIN();
           RUN_TEST(test_memory_safety);
           RUN_TEST(test_input_validation);
           return UNITY_END();
       }
       ```
     - Integration with Development Tools:
       - Valgrind for memory analysis
       - gcc -fanalyzer for static analysis
       - AFL++ for fuzzing
     - GitHub Actions CI/CD:
       ```yaml
       name: CI/CD Pipeline
       on:
         push:
           branches: [ main, develop ]
         pull_request:
           branches: [ main, develop ]
       jobs:
         build:
           runs-on: ubuntu-latest
           steps:
             - uses: actions/checkout@v2
             - name: Build
               run: |
                 mkdir build && cd build
                 cmake ..
                 make
         test:
           runs-on: ubuntu-latest
           needs: build
           steps:
             - uses: actions/checkout@v2
             - name: Run Tests
               run: |
                 cd build
                 ctest --output-on-failure
         analyze:
           runs-on: ubuntu-latest
           needs: test
           steps:
             - uses: actions/checkout@v2
             - name: Static Analysis
               run: |
                 gcc -fanalyzer -c src/*.c
             - name: Memory Analysis
               run: |
                 valgrind --leak-check=full ./build/tests/unit_tests
       ```
   - Annotations:
     ```text
     Decision to use Unity testing framework because:
     1. C-specific (unlike Google Test which is C++)
     2. Simple to use and understand
     3. C11 compliant
     4. Good documentation
     5. Appropriate for undergraduate project
     6. Aligns with lecture content on:
        - Memory safety (lect02, lect03)
        - Access control (lect04)
        - Input validation (lect05)
        - Cryptography (lect08)
        - Development practices (lect09)
     
     Adjusted test coverage requirements to be more realistic:
     1. 80% for critical components
     2. 60% for non-critical components
     3. 100% for security-critical paths
     
     Test categories based on lecture content to ensure comprehensive coverage
     of secure coding principles taught in the unit.
     
     GitHub Actions provides:
     1. Automated testing pipeline
     2. Continuous integration
     3. Quality checks
     4. Security scanning
     5. Team collaboration
     ```

## Supply Chain Security
7. Add Supply Chain Security
   - Software Bill of Materials (SBOM)
   - Library management
   - Open source vs proprietary library tracking
   - Action Required: [x] Accept [ ] Reject [ ] Modify
   - Implementation Details:
     - Add basic dependency tracking section
     - Focus on essential, educational aspects:
       1. Simple Dependency Documentation:
          - Maintain a basic README.md section listing:
            - Core libraries used (OpenSSL, Valgrind)
            - Version numbers
            - Purpose of each dependency
          - Example:
            ```markdown
            ## Dependencies
            - OpenSSL 3.0.0: Cryptographic functions
            - Valgrind 3.18.1: Memory analysis
            - Unity: Unit testing framework
            ```
       2. Basic Library Management:
          - Use system package manager for core dependencies
          - Document any custom modifications
          - Keep track of security updates
          - GitHub Dependabot Integration:
            ```yaml
            version: 2
            updates:
              - package-ecosystem: "github-actions"
                directory: "/"
                schedule:
                  interval: "weekly"
              - package-ecosystem: "pip"
                directory: "/"
                schedule:
                  interval: "weekly"
            ```
       3. Simple Version Control:
          - Document library versions in CMakeLists.txt
          - Example:
            ```cmake
            # Core Dependencies
            find_package(OpenSSL 3.0.0 REQUIRED)
            find_package(Valgrind 3.18.1 REQUIRED)
            ```
     - Add basic security notes:
       - Document known vulnerabilities
       - Track security updates
       - Note any custom security patches
   - Annotations:
     ```text
     Simplified approach for undergraduate project:
     1. Focus on essential documentation
     2. Keep tracking simple and maintainable
     3. Use existing tools and practices
     4. Emphasize learning value
     5. Avoid over-engineering
     
     Lecture References:
     - lect09--dev.md: Emphasizes practical development approaches
     - lect-project-tips.md: Recommends keeping things simple and manageable
     
     Decision to implement basic supply chain security because:
     1. Teaches important security concepts
     2. Practical for project scope
     3. Provides good learning experience
     4. Aligns with secure coding principles
     5. Appropriate for undergraduate level
     
     Note: Full SBOM and complex tracking systems are overkill for this project.
     Focus is on understanding basic supply chain security concepts rather than
     implementing complex systems.
     
     GitHub Dependabot provides:
     1. Automated dependency updates
     2. Security vulnerability alerts
     3. Version tracking
     4. Update scheduling
     5. Team notifications
     ```

## Security Programs
8. Add Security Programs
   - Security vulnerability program
   - Bug bounty program
   - Black box penetration testing
   - Action Required: [x] Accept [ ] Reject [ ] Modify
   - Implementation Details:
     - Add new section for security programs
     - Focus on practical, educational aspects:
       1. Basic Security Testing:
          - Automated security scanning:
            - Static analysis: gcc -fanalyzer
              - Enable all analyzers: -fanalyzer -fanalyzer-call-summaries
              - Enable verbose output: -fanalyzer-verbose-edges
            - Memory safety: Valgrind
              - Full memory checking: --leak-check=full
              - Show reachable blocks: --show-reachable=yes
              - Track origins: --track-origins=yes
            - Basic fuzzing: AFL++
              - Timeout: 1000ms
              - Memory limit: 50MB
              - Dictionary: custom.dict
          - Input validation testing:
            - Buffer overflow tests: ±1 byte boundaries
            - Integer overflow tests: INT_MAX, INT_MIN
            - Format string tests: %n, %s, %x
          - Boundary condition testing:
            - Array bounds: 0, size-1, size
            - String lengths: 0, max-1, max
            - Integer ranges: min, max, overflow
          - Memory leak detection:
            - Track all allocations
            - Verify proper cleanup
            - Check for double frees
       2. Security Documentation:
          - Document known vulnerabilities:
            - CVE references
            - Impact assessment
            - Mitigation steps
          - Track security updates:
            - Weekly security scans
            - Monthly vulnerability reviews
            - Quarterly security audits
          - Note any custom security patches:
            - Patch version
            - Issue description
            - Implementation details
          - Maintain security checklist:
            - Memory safety
            - Input validation
            - Error handling
            - Documentation
       3. Basic Security Review Process:
          - Code review checklist:
            - Memory safety:
              - Proper allocation/deallocation
              - Buffer overflow prevention
              - Memory leak prevention
            - Input validation:
              - Sanitization rules
              - Length checks
              - Type validation
            - Error handling:
              - Error codes
              - Logging
              - Recovery procedures
          - Security-focused testing:
            - Daily static analysis
            - Weekly memory checks
            - Monthly fuzzing runs
          - Regular security audits:
            - Quarterly full review
            - Monthly partial review
            - Weekly quick check
     - Update development process:
       ```markdown
       ## Security Process
       1. Development:
          - Follow secure coding guidelines:
            - CERT C rules
            - Memory safety
            - Input validation
          - Use memory-safe operations:
            - Bounds checking
            - Safe string functions
            - Proper cleanup
          - Implement proper input validation:
            - Length checks
            - Type validation
            - Sanitization
       2. Testing:
          - Run static analysis:
            - gcc -fanalyzer
            - Valgrind
            - AFL++
          - Check memory safety:
            - Leak detection
            - Buffer overflow
            - Use-after-free
          - Test boundary conditions:
            - Edge cases
            - Invalid inputs
            - Error conditions
       3. Review:
          - Security checklist review:
            - Memory safety
            - Input validation
            - Error handling
          - Documentation verification:
            - Function headers
            - Security notes
            - Usage examples
          - Test coverage check:
            - Critical paths
            - Error handling
            - Edge cases
       ```
   - Annotations:
     ```text
     Simplified approach for undergraduate project:
     1. Focus on practical security measures
     2. Use existing tools and practices
     3. Emphasize learning value
     4. Keep documentation simple
     5. Avoid over-engineering
     
     Lecture References:
     - lect02--memory.md: Covers memory safety and security
     - lect03--memory2.md: Discusses secure memory practices
     - lect05--validation.md: Addresses input validation
     - lect06--analysis.md: Covers static analysis
     - lect09--dev.md: Discusses development practices
     
     Decision to implement basic security programs because:
     1. Teaches important security concepts
     2. Practical for project scope
     3. Provides good learning experience
     4. Uses existing tools and practices
     5. Appropriate for undergraduate level
     
     Note: Full vulnerability programs and bug bounties are overkill for this project.
     Focus is on understanding basic security practices and using appropriate tools.
     ```

## Additional Security Practices
9. Add Security Practices
    - Signed commits
    - More explicit code review process
    - RSS feed monitoring for standards updates
    - Action Required: [x] Accept [ ] Reject [ ] Modify
    - Implementation Details:
      - Update version control policies:
        1. GitHub Commit Signing:
           - GPG key setup and GitHub integration:
             ```bash
             # Generate GPG key
             gpg --full-generate-key
             # Export public key
             gpg --armor --export <key-id> > public-key.asc
             # Add key to GitHub:
             # 1. Go to Settings -> SSH and GPG keys
             # 2. Click "New GPG key"
             # 3. Paste public key
             # Configure Git for GitHub
             git config --global user.signingkey <key-id>
             git config --global commit.gpgsign true
             ```
           - GitHub commit signing workflow:
             ```bash
             # Sign commits
             git commit -S -m "feat(auth): add password hashing"
             # Push to GitHub
             git push origin main
             # Verify signatures on GitHub:
             # 1. Go to repository
             # 2. Click on commits
             # 3. Look for "Verified" badge
             ```
           - GitHub branch protection:
             - Require signed commits
             - Require pull request reviews
             - Require status checks
             - Require linear history
        2. GitHub Code Review Process:
           - Pre-commit hooks:
             ```bash
             #!/bin/sh
             # Run static analysis
             gcc -fanalyzer -c $1
             # Check memory safety
             valgrind --leak-check=full ./$1
             # Verify documentation
             doxygen -g
             ```
           - GitHub Pull Request template:
             ```markdown
             ## Description
             [Description of changes]
             
             ## Security Checklist
             - [ ] Memory safety verified
             - [ ] Input validation complete
             - [ ] Error handling implemented
             - [ ] Documentation updated
             - [ ] Tests added/updated
             
             ## Review Checklist
             - [ ] Code follows style guide
             - [ ] Security requirements met
             - [ ] Tests pass
             - [ ] Documentation complete
             ```
           - Review workflow:
             ```markdown
             1. Create feature branch
             2. Make changes
             3. Create pull request
             4. Run automated checks
             5. Manual review by team member
             6. Address feedback
             7. Merge if approved
             ```
        3. GitHub Security Monitoring:
           - Enable GitHub Security Alerts:
             - Go to repository Settings
             - Enable Dependabot alerts
             - Enable Code scanning alerts
           - Weekly security updates:
             - Review GitHub security alerts
             - Check Dependabot updates
             - Review code scanning results
             - Update documentation
             - Apply patches if needed
      - Update development workflow:
        ```markdown
        ## GitHub Development Workflow
        1. Code Changes:
           - Create feature branch
           - Make changes
           - Run local tests
           - Sign commits
           - Push to GitHub
        2. Code Review:
           - Create pull request
           - Run automated checks
           - Manual review
           - Address feedback
           - Update documentation
        3. Integration:
           - Merge changes
           - Run full test suite
           - Update security docs
           - Monitor security alerts
        ```
    - Annotations:
      ```text
      GitHub-specific approach for undergraduate project:
      1. Focus on practical security measures
      2. Use GitHub's built-in security features
      3. Emphasize learning value
      4. Keep documentation simple
      5. Avoid over-engineering
      
      Lecture References:
      - lect09--dev.md: Discusses development practices and workflows
      - lect09b--dev.md: Covers version control and code review
      - lect-project-tips.md: Emphasizes practical implementation
      - lect01--intro.md: Covers secure coding principles
      
      Decision to implement GitHub-specific practices because:
      1. Teaches important security concepts
      2. Practical for project scope
      3. Provides good learning experience
      4. Uses GitHub's security features
      5. Appropriate for undergraduate level
      
      Note: Focus is on understanding basic security practices rather than
      implementing complex systems. The approach is simplified but still
      maintains good security practices appropriate for the project scope.
      ```

## Recent Security Publications
10. Add Recent Security Publications
    - Reference: https://www.cisa.gov/sites/default/files/2024-10/safe-software-deployment-how-software-manufacturers-can-ensure-reliability-for-customers-508c.pdf
    - Action Required: [x] Accept [ ] Reject [ ] Modify
    - Implementation Details:
      - Add new section for CISA guidelines
      - Focus on practical, implementable aspects:
        1. Secure Development Lifecycle:
           - Development Environment:
             - Use Linode instances (as per section 5)
             - Implement Ansible automation
             - Follow GitHub security practices
           - Code Quality:
             - Use SEI CERT C standard (as per section 1)
             - Implement Unity testing (as per section 6)
             - Follow secure coding practices
           - Security Testing:
             - Static analysis with gcc -fanalyzer
             - Memory safety with Valgrind
             - Input validation testing
        2. Deployment Security:
           - Environment Separation:
             - Testing instance
             - Staging instance
             - Production instance
           - Access Control:
             - RBAC implementation
             - Session management
             - Authentication system
           - Monitoring:
             - GitHub security alerts
             - Dependabot updates
             - Code scanning results
        3. Documentation Requirements:
           - Security Documentation:
             - Known vulnerabilities
             - Security updates
             - Custom patches
           - Development Documentation:
             - Code style guide
             - Testing procedures
             - Deployment process
           - User Documentation:
             - Security features
             - Best practices
             - Troubleshooting
      - Update development process:
        ```markdown
        ## CISA-Compliant Development Process
        1. Planning:
           - Security requirements
           - Resource allocation
           - Timeline estimation
        2. Development:
           - Secure coding practices
           - Regular testing
           - Documentation updates
        3. Testing:
           - Unit tests
           - Security tests
           - Performance tests
        4. Deployment:
           - Environment setup
           - Security configuration
           - Monitoring setup
        ```
    - Annotations:
      ```text
      Decision to incorporate CISA guidelines because:
      1. Provides practical security guidance
      2. Aligns with our project scope
      3. Complements existing security measures
      4. Educational value for undergraduates
      5. Focuses on implementable practices
      
      Lecture References:
      - lect09--dev.md: Discusses development practices
      - lect09b--dev.md: Covers deployment and security
      - lect-project-tips.md: Emphasizes practical implementation
      - lect01--intro.md: Covers secure coding principles
      
      Implementation approach:
      1. Integrate with existing security measures
      2. Focus on practical aspects
      3. Use existing tools and practices
      4. Maintain educational value
      5. Keep documentation simple
      
      Note: We're implementing a simplified version of the CISA guidelines
      appropriate for an undergraduate project, focusing on the core principles
      that are most relevant to our scope and educational goals.
      ```

## Reference Codebases
11. Add Reference Codebases
    - curl
    - OpenSSH
    - FreeRADIUS (as RBAC system reference)
    - Action Required: [x] Accept [ ] Reject [ ] Modify
    - Implementation Details:
      - Add reference codebases section
      - Study and document practices:
        1. curl:
           - Memory management patterns
           - Error handling
           - Input validation
           - Security headers
        2. OpenSSH:
           - Authentication flow
           - Session management
           - Access control
           - Secure communication
        3. FreeRADIUS:
           - RBAC implementation
           - Permission management
           - User authentication
           - Session handling
      - Incorporate relevant patterns:
        ```c
        // Example patterns from reference codebases
        // Memory management (from curl)
        void *safe_malloc(size_t size) {
            void *ptr = malloc(size);
            if (!ptr) {
                log_error("Memory allocation failed");
                return NULL;
            }
            return ptr;
        }
        
        // Error handling (from OpenSSH)
        int handle_error(int error_code) {
            switch (error_code) {
                case AUTH_ERROR:
                    log_auth_error();
                    return -1;
                case SESSION_ERROR:
                    log_session_error();
                    return -1;
                default:
                    log_generic_error();
                    return -1;
            }
        }
        
        // RBAC implementation (from FreeRADIUS)
        typedef struct {
            role_t role;
            permission_t *permissions;
            size_t num_permissions;
        } user_roles_t;
        ```
      - Update development guidelines:
        - Memory management best practices
        - Error handling patterns
        - Security implementation patterns
        - Documentation standards
    - Annotations:
      ```text
      Decision to use reference codebases because:
      1. Proven security implementations
      2. Well-documented patterns
      3. Industry standard practices
      4. Educational value
      5. Practical examples
      
      Lecture References:
      - lect02--memory.md: Covers memory management
      - lect03--memory2.md: Discusses secure memory practices
      - lect04--access.md: Addresses RBAC implementation
      - lect05--validation.md: Covers input validation
      - lect07--concurrency.md: Discusses session management
      
      Implementation approach:
      1. Study reference implementations
      2. Document relevant patterns
      3. Adapt to project scope
      4. Maintain security standards
      5. Keep documentation clear
      ```

## Report Structure
12. Enhance Report Structure
    For each proposal/tool/standard, explicitly address:
    - Why it is relevant to the project
    - How it will be applied during development
    - How the group will ensure it is effectively used
    - Action Required: [x] Accept [ ] Reject [ ] Modify
    - Implementation Details:
      - Restructure entire report:
        1. Introduction:
           - Project overview
           - Security requirements
           - Implementation goals
        2. Development Environment:
           - Tools and standards
           - Security measures
           - Testing framework
        3. Implementation Details:
           - Authentication system
           - RBAC implementation
           - Session management
           - Admin tools
        4. Security Measures:
           - Memory safety
           - Input validation
           - Access control
           - Error handling
        5. Testing and Validation:
           - Unit testing
           - Security testing
           - Performance testing
        6. Documentation:
           - Code documentation
           - Security documentation
           - User documentation
      - Add explicit sections for each tool/standard:
        ```markdown
        ## Tool/Standard Name
        1. Relevance:
           - Why it's needed
           - Security benefits
           - Implementation goals
        2. Application:
           - How to implement
           - Integration points
           - Usage guidelines
        3. Effectiveness:
           - Verification methods
           - Monitoring
           - Maintenance
        ```
      - Update documentation format:
        - Clear section headers
        - Consistent formatting
        - Detailed examples
        - Security notes
      - Modify review process:
        - Documentation review
        - Security review
        - Implementation review
    - Annotations:
      ```text
      Decision to enhance report structure because:
      1. Improves clarity
      2. Ensures completeness
      3. Facilitates review
      4. Maintains consistency
      5. Supports implementation
      
      Lecture References:
      - lect09--dev.md: Discusses development practices
      - lect09b--dev.md: Covers documentation
      - lect-project-tips.md: Emphasizes clear documentation
      
      Implementation approach:
      1. Clear structure
      2. Consistent format
      3. Detailed sections
      4. Practical examples
      5. Security focus
      ```

## Practical Implementation
13. Add Practical Implementation Focus
    - More focus on actual implementation feasibility
    - Consider system size in relation to proposed measures
    - Balance security requirements with practical development
    - Action Required: [x] Accept [ ] Reject [ ] Modify
    - Implementation Details:
      - Add feasibility analysis:
        1. System Size:
           - Estimated lines of code: 5000-10000
           - Core components: 4
           - Security features: 6
           - Test coverage: 80%
        2. Resource Requirements:
           - Development time: 8 weeks
           - Team size: 5 members
           - Infrastructure: 3 Linode instances
           - Tools: Standard development tools
        3. Implementation Constraints:
           - C11 compliance
           - Memory safety
           - Security requirements
           - Performance needs
      - Update project planning:
        ```markdown
        ## Implementation Timeline
        1. Week 1-2: Core Setup
           - Development environment
           - Basic infrastructure
           - Security tools
        2. Week 3-4: Core Features
           - Authentication
           - RBAC
           - Session management
        3. Week 5-6: Security Features
           - Memory safety
           - Input validation
           - Access control
        4. Week 7-8: Testing & Documentation
           - Unit testing
           - Security testing
           - Documentation
        ```
      - Modify resource allocation:
        - Development: 60%
        - Testing: 20%
        - Documentation: 20%
      - Add practical constraints documentation:
        - Time constraints
        - Resource limitations
        - Security requirements
        - Performance needs
    - Annotations:
      ```text
      Decision to focus on practical implementation because:
      1. Ensures feasibility
      2. Balances requirements
      3. Manages resources
      4. Maintains quality
      5. Supports delivery
      
      Lecture References:
      - lect09--dev.md: Discusses practical development
      - lect09b--dev.md: Covers implementation
      - lect-project-tips.md: Emphasizes practical approach
      
      Implementation approach:
      1. Realistic planning
      2. Resource management
      3. Quality focus
      4. Security balance
      5. Documentation emphasis
      ```

## Documentation
14. Add Additional Documentation References
    - ISM Guidelines for software development
    - Recent security publications from major agencies
    - Secure Design Foundations documentation
    - Action Required: [x] Accept [ ] Reject [ ] Modify
    - Implementation Details:
      - Update Section 6 "Reference Documentation":
        1. Security Standards:
           - ISM Guidelines
           - CISA Publications
           - NIST Guidelines
           - OWASP Standards
        2. Development Standards:
           - SEI CERT C
           - MISRA C
           - C11 Standard
           - Secure Coding Practices
        3. Testing Standards:
           - Unit Testing
           - Security Testing
           - Performance Testing
           - Documentation Standards
      - Add new references:
        ```markdown
        ## Additional References
        1. Security Standards:
           - ISM Guidelines: [link]
           - CISA Publications: [link]
           - NIST Guidelines: [link]
           - OWASP Standards: [link]
        2. Development Standards:
           - SEI CERT C: [link]
           - MISRA C: [link]
           - C11 Standard: [link]
           - Secure Coding: [link]
        3. Testing Standards:
           - Unit Testing: [link]
           - Security Testing: [link]
           - Performance Testing: [link]
           - Documentation: [link]
        ```
      - Modify documentation structure:
        - Clear organization
        - Easy navigation
        - Quick reference
        - Detailed sections
      - Update compliance requirements:
        - Security standards
        - Development standards
        - Testing standards
        - Documentation standards
    - Annotations:
      ```text
      Decision to add documentation references because:
      1. Improves completeness
      2. Supports implementation
      3. Ensures compliance
      4. Facilitates review
      5. Maintains standards
      
      Lecture References:
      - lect09--dev.md: Discusses documentation
      - lect09b--dev.md: Covers standards
      - lect-project-tips.md: Emphasizes documentation
      
      Implementation approach:
      1. Comprehensive coverage
      2. Clear organization
      3. Easy reference
      4. Regular updates
      5. Security focus
      ```

## General Feedback
15. Overall Assessment
    - Report is "comprehensive AF"
    - More strict than many production systems
    - If system is small, implementation is doable
    - Action Required: [x] Accept [ ] Reject [ ] Modify
    - Implementation Details:
      - Review and adjust scope:
        1. Core Features:
           - Authentication system
           - RBAC implementation
           - Session management
           - Admin tools
        2. Security Features:
           - Memory safety
           - Input validation
           - Access control
           - Error handling
        3. Testing Requirements:
           - Unit testing: 80%
           - Security testing: 100%
           - Performance testing: Pass
      - Update project timeline:
        ```markdown
        ## Revised Timeline
        1. Week 1-2: Setup
           - Environment
           - Tools
           - Standards
        2. Week 3-5: Core Implementation
           - Features
           - Security
           - Testing
        3. Week 6-7: Enhancement
           - Optimization
           - Documentation
           - Review
        4. Week 8: Finalization
           - Testing
           - Documentation
           - Submission
        ```
      - Modify resource requirements:
        - Development: 50%
        - Security: 30%
        - Testing: 20%
      - Adjust implementation strategy:
        - Focus on core features
        - Prioritize security
        - Maintain quality
        - Document thoroughly
    - Annotations:
      ```text
      Decision to adjust implementation because:
      1. Ensures feasibility
      2. Maintains quality
      3. Balances requirements
      4. Supports delivery
      5. Achieves goals
      
      Lecture References:
      - lect09--dev.md: Discusses implementation
      - lect09b--dev.md: Covers project management
      - lect-project-tips.md: Emphasizes practical approach
      
      Implementation approach:
      1. Focused scope
      2. Quality emphasis
      3. Security priority
      4. Practical timeline
      5. Clear documentation
      ``` 