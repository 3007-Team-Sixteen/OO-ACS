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

**Team Members:**
- Stephen Beaver (10423362) - Administrative Tools
- Kai Fletcher (23808253) - RBAC Implementation
- Prem Patel (23775211) - RBAC Implementation
- Muhammad Qureshi (23976415) - Session Management
- Kelly Snow (23614821) - Player Authentication

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
