# CITS3007 Secure Coding - Group Project
## Oblivionaire Online (OO) - Access Control System (ACS)

This repository contains the materials and deliverables for the CITS3007 Secure Coding group project at The University of Western Australia.

## Project Overview

The project involves developing an Access Control System (ACS) for Oblivionaire Online (OO), a new MMORPG by Enjjin Media. The ACS is responsible for:
- Player authentication
- Role-based access control (RBAC)
- Session management
- Admin and operations access

## Team Information

**Team Name:** 3007-Team-Sixteen

**Group Number:** 16

**Team Members:**
- Stephen Beaver (10423362)
- Kai Fletcher (23808253)
- Prem Patel (23775211)
- Muhammad Qureshi (23976415)
- Kelly Snow (23614821)

## Repository Structure

- `ASSIGNMENT_SPEC.md` - Detailed project specification and requirements
- `phase1_report.md` - Phase 1 planning report
- `Assignment_Material/` - Course materials and lecture notes
- `.github/workflows/` - CI/CD pipeline configuration
- `.gitignore` - Git ignore rules for the project

## Development Environment

### Core Tools
- AWS EC2 Ubuntu 20.04 LTS
- C11 with strict compiler flags
- Git and GitHub for version control
- CI/CD pipeline with GitHub Actions

### Security Tools
- Clang Static Analyser
- Cppcheck
- Valgrind
- AFL++
- Address Sanitiser
- Thread Sanitiser
- Undefined Behaviour Sanitiser

## Project Phases

1. **Phase 1 (Planning)**
   - Due: Wednesday 16 April 2025 (Week 8)
   - Worth: 10 marks
   - Deliverable: Planning report

2. **Phase 2 (Implementation)**
   - Due: Week 11
   - Worth: 40 marks
   - Deliverable: Implementation and report

3. **Phase 3 (Demo/Presentation)**
   - Due: Weeks 11-12
   - Worth: 10 marks
   - Deliverable: Project demonstration and presentation

## Quality Assurance

### Testing Requirements
- Unit tests: >90% coverage
- Integration tests: >80% coverage
- Security tests: >95% coverage
- Memory leak checks
- Fuzzing for input functions

### Code Review Process
- Pull requests require:
  - Passing CI/CD checks
  - Security scan clearance
  - Code review approval
  - Updated documentation

## Academic Integrity

This project must be completed in accordance with the University Academic Integrity Policy. While general principles may be discussed with other students, all submitted work must be the result of your group's own effort.

## License

This project is part of CITS3007 - Secure Coding at The University of Western Australia. All materials are provided for educational purposes.
