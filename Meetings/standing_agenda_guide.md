# OO-ACS Meeting Agenda Guide (Based on Phase 1 Report)

**Purpose:** This document provides a standing agenda structure and discussion points for regular team meetings, ensuring alignment with the planning, standards, and processes defined in the Phase 1 report.

**Frequency:** Intended primarily for the Weekly Monday meeting, but sections can be referenced during Standups if specific issues arise.

---

## Standard Meeting Preliminaries

*   **Attendees & Apologies:** (Record)
*   **Review Previous Action Items:** (Track status: Done / In Progress / Blocked)

---

## Phase 1 Report - Discussion Points Checklist

*(Note: Not every point needs detailed discussion every week. Use as a checklist to ensure key areas are considered based on current project activities.)*

**1. Team Communication & Responsibilities (Ref: Report Sec 1)**
    *   Communication Flow: Any issues with Discord/Signal usage? Is information reaching everyone?
    *   Meeting Schedule: Does the current schedule (Weekly + Standups) work? Any adjustments needed?
    *   Progress Tracking: Is the Kanban/GitHub Projects board up-to-date? Are standup updates effective?
    *   Role Clarity: Any confusion or overlap in roles/responsibilities based on current tasks?
    *   Participation/Concerns: Any issues with attendance or contribution to address (per protocol 1.3)?

**2. Version Control Strategy (Ref: Report Sec 2)**
    *   Branching: Is the `main`/`develop`/`feature` strategy being followed correctly?
    *   Pull Requests: Are PRs being created, reviewed, and merged promptly? Any bottlenecks?
    *   Security: Are commits being signed (GPG)? Are branch protection rules effective?

**3. Development Environment (Ref: Report Sec 3.1)**
    *   Instance Status: Current status/health of the Testing Linode instance?
    *   Ansible Automation: Any issues encountered with the Ansible playbooks? Any updates needed?
    *   Repository Access: Any problems with Deploy Keys or cloning the repository?
    *   Environment Parity: Any concerns about differences between local dev environments and the target Linode environment?
    *   Staging/Production Prep: Blockers or next steps for setting up these environments?

**4. Development & Coding Standards (Ref: Report Sec 3.2)**
    *   Coding Standard (SEI CERT C): Any questions or challenges applying CERT C rules to current code?
    *   Compiler Flags: Are the secure flags being used consistently in builds? Any unexpected warnings/errors?
    *   Coding Style: Are we adhering to the defined style guide (indentation, naming, comments)?

**5. Security Standards (Ref: Report Sec 3.3)**
    *   General Check: Are current development tasks considering relevant security standards (CIA, C11, MISRA, OWASP, etc.)?
    *   Specific Issues: Any specific security standard implementation challenges encountered this week?
    *   Documented Deviations: Do we need to formally document any deviations from standards for specific reasons?

**6. Security Tools (Ref: Report Sec 3.4)**
    *   Static Analysis (gcc -fanalyzer): Review any significant findings.
    *   Memory Analysis (Valgrind): Discuss results from recent Valgrind runs.
    *   Testing Framework (Unity): Status of unit test implementation and coverage.
    *   GitHub Security: Review Dependabot alerts. Status of commit signing usage.
    *   Cryptography (libsodium): Any issues implementing password hashing or other crypto functions?

**7. Key Secure Coding Practices (Ref: Report Sec 4)**
    *   Memory Safety: Discuss any tricky memory allocation/deallocation patterns encountered.
    *   Input Validation: Review implementation for current features. Are all inputs validated?
    *   Access Control: Discuss RBAC design/implementation progress and challenges.
    *   Error Handling: Is error handling consistent and secure (avoiding info disclosure)?

**8. Risk Management & Quality Assurance (Ref: Report Sec 5)**
    *   Risk Assessment: Any new risks identified? Updates on mitigating existing risks.
    *   QA / Testing Status: Progress on unit tests, security tests. Any testing blockers?
    *   Timeline Check: Are we on track according to the implementation timeline (5.3)? Any potential delays?

**9. Git-Based Tracking & Quality Control (Ref: Report Sec 6)**
    *   Commit Quality: Review recent commit messages and granularity.
    *   PR Quality: Review quality of descriptions, checklists, review comments.
    *   CI/CD: (Future) Status and results from automated checks.
    *   Documentation: Is code/process documentation keeping pace with development?

---

## Standard Meeting Wrap-up

*   **Summarize Key Decisions & Discussions:**
*   **Consolidate New Action Items:** (Assign Owner & Due Date)
*   **Confirm Next Meeting:** (Date, Time, Type) 