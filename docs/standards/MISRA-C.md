# MISRA C:2012 Guidelines

## Overview
Implementation of MISRA C:2012 guidelines for secure C programming.

## Sources
- Official MISRA C:2012 Standard available through [MISRA](https://www.misra.org.uk)
- Current version: MISRA C:2012 with Amendment 1 (2016)

## Key Guidelines

### Environment
- [Source Document](https://www.misra.org.uk)
- [Implementation Guidelines](development/environment.md)
- Critical Rules:
  - Rule 1.1: The program shall contain no violations of the standard C syntax and constraints
  - Rule 1.2: Language extensions should not be used
  - Rule 1.3: There shall be no occurrence of undefined or critical unspecified behavior
  - Rule 1.4: Emergent language features shall not be used

### Language Extensions
- [Source Document](https://www.misra.org.uk)
- [Implementation Guidelines](development/extensions.md)
- Critical Rules:
  - Rule 2.1: A project shall not contain unreachable code
  - Rule 2.2: There shall be no dead code
  - Rule 2.3: A project should not contain unused type declarations
  - Rule 2.4: A project should not contain unused tag declarations
  - Rule 2.5: A project should not contain unused macro declarations
  - Rule 2.6: A project should not contain unused declarations

### Documentation
- [Source Document](https://www.misra.org.uk)
- [Implementation Guidelines](development/documentation.md)
- Critical Rules:
  - Rule 3.1: All usage of assembler shall be documented
  - Rule 3.2: All usage of implementation-defined behavior shall be documented
  - Rule 3.3: The character set and the corresponding encoding should be documented

### Character Sets
- [Source Document](https://www.misra.org.uk)
- [Implementation Guidelines](development/character-sets.md)
- Critical Rules:
  - Rule 4.1: Octal and hexadecimal escape sequences shall be terminated
  - Rule 4.2: Trigraphs should not be used

### Identifiers
- [Source Document](https://www.misra.org.uk)
- [Implementation Guidelines](development/identifiers.md)
- Critical Rules:
  - Rule 5.1: External identifiers shall be distinct
  - Rule 5.2: Identifiers declared in the same scope and name space shall be distinct
  - Rule 5.3: An identifier declared in an inner scope shall not hide an identifier declared in an outer scope
  - Rule 5.4: Macro identifiers shall be distinct
  - Rule 5.5: Identifiers shall be distinct from macro names

### Types
- [Source Document](https://www.misra.org.uk)
- [Implementation Guidelines](development/types.md)
- Critical Rules:
  - Rule 6.1: Bit-fields shall only be declared with an appropriate type
  - Rule 6.2: Single-bit named bit fields shall not be of a signed type
  - Rule 6.3: Typedefs that indicate size and signedness should be used in place of the basic types

### Literals
- [Source Document](https://www.misra.org.uk)
- [Implementation Guidelines](development/literals.md)
- Critical Rules:
  - Rule 7.1: Octal constants shall not be used
  - Rule 7.2: A "u" or "U" suffix shall be applied to all integer constants that are represented in an unsigned type
  - Rule 7.3: The lowercase character "l" shall not be used in a literal suffix

### Declarations and Definitions
- [Source Document](https://www.misra.org.uk)
- [Implementation Guidelines](development/declarations.md)
- Critical Rules:
  - Rule 8.1: Functions shall have prototype declarations and the prototype shall be visible at both the function definition and call
  - Rule 8.2: Function types shall be in prototype form with named parameters
  - Rule 8.3: All declarations of an object or function shall use the same names and type qualifiers
  - Rule 8.4: A compatible declaration shall be visible when an object or function with external linkage is defined
  - Rule 8.5: An external object or function shall be declared in one and only one file
  - Rule 8.6: An identifier with external linkage shall have exactly one external definition
  - Rule 8.7: Functions and objects should not be defined with external linkage if they are referenced in only one translation unit
  - Rule 8.8: The static storage class specifier shall be used in all declarations of objects and functions that have internal linkage
  - Rule 8.9: An object should be defined at block scope if its identifier only appears in a single function
  - Rule 8.10: An inline function shall be declared with the static storage class
  - Rule 8.11: When an array with external linkage is declared, its size should be explicitly specified
  - Rule 8.12: When an array is declared, its size shall be explicitly specified
  - Rule 8.13: A pointer should point to a const-qualified type whenever possible
  - Rule 8.14: The restrict type qualifier shall not be used

## Implementation Status
- [ ] Environment Rules
- [ ] Language Extensions Rules
- [ ] Documentation Rules
- [ ] Character Sets Rules
- [ ] Identifiers Rules
- [ ] Types Rules
- [ ] Literals Rules
- [ ] Declarations and Definitions Rules

## Deviations
- Document any deviations from MISRA C:2012 requirements
- Justification for each deviation
- Alternative security measures implemented 