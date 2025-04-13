# OO-ACS Coding Style Guide

## Formatting

### Indentation and Spacing
- Use 4 spaces for indentation
- No trailing whitespace
- One blank line between functions
- One space after keywords (if, for, while)
- No space between function name and parentheses

### Line Length and Wrapping
- Maximum line length: 80 characters
- Break long lines at logical points
- Align wrapped parameters with opening parenthesis

### Braces
- Opening brace on same line as control statement
- Closing brace on own line
- Always use braces for control structures

## Naming Conventions

### Functions
- snake_case for function names
- Descriptive verbs indicating action
- Prefix with module name for non-static functions

### Variables
- snake_case for variable names
- No Hungarian notation
- Descriptive nouns indicating purpose
- Single letter counters only in short loops

### Constants and Macros
- UPPER_SNAKE_CASE for constants and macros
- Prefix macros with module name

### Types
- snake_case with _t suffix for types
- snake_case with _s suffix for structs

## Documentation

### Function Headers
```c
/**
 * Brief description of function
 *
 * @param name Description of parameter
 * @return Description of return value
 *
 * @note Any special notes about usage
 */
```

### File Headers
```c
/**
 * @file filename.c
 * @brief Purpose of the file
 *
 * Detailed description if needed
 */
```

## Error Handling

- Check all function return values
- Use consistent error codes
- Document error conditions
- Clean up resources on error paths

## Memory Management

- Free all allocated memory
- Check malloc/calloc return values
- Use consistent allocation patterns
- Document ownership transfer

## Example

```c
/**
 * @file auth_login.c
 * @brief User authentication functions
 */

#include "auth.h"

/**
 * Validates user credentials
 *
 * @param username User login name
 * @param password User password
 * @return AUTH_SUCCESS on success, error code on failure
 */
auth_result_t auth_validate_credentials(const char *username,
                                      const char *password)
{
    if (username == NULL || password == NULL) {
        return AUTH_ERROR_INVALID_PARAM;
    }

    auth_context_t *ctx = auth_create_context();
    if (ctx == NULL) {
        return AUTH_ERROR_MEMORY;
    }

    auth_result_t result = auth_check_password(ctx, username, password);
    auth_free_context(ctx);

    return result;
}
``` 