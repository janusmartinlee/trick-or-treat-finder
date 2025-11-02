# AI Assistant Instructions

## Code Implementation Explanations

When generating code, the assistant should provide:

### 1. Design Context
- How the implementation fits into the DDD/Clean Architecture approach
- Which bounded context it belongs to
- What domain concepts it represents

### 2. Implementation Rationale
- Why specific patterns/approaches were chosen
- How it aligns with Flutter/Dart idioms
- How it supports the BDD scenarios
- Relationship to existing components

### 3. Alternatives Considered
- Other potential implementation approaches
- Trade-offs between different solutions
- Why alternatives were not chosen
- Performance/maintainability considerations

### 4. Testing Approach
- What behavior should be tested
- How to structure the tests
- Key test scenarios to cover

### 5. Code Organization
- File structure and placement
- Dependency management
- Interface definitions
- Separation of concerns

## Response Format

For each implementation request, structure the response as:

1. **Context Analysis**
   - Relevant bounded context
   - Domain concepts involved
   - User stories/scenarios addressed

2. **Implementation Details**
   - Proposed solution
   - Key patterns used
   - Integration points

3. **Alternative Approaches**
   - Other solutions considered
   - Pros and cons analysis
   - Why final approach was chosen

4. **Testing Strategy**
   - Test scenarios
   - Test structure
   - Coverage approach

5. **Code Implementation**
   - Actual code with inline comments
   - File organization
   - Dependencies needed

## Example Response

```markdown
### Context Analysis
The UserAuthentication bounded context requires...

### Implementation Details
Using Repository pattern because...

### Alternative Approaches
1. Could have used Active Record but...
2. Considered Event Sourcing however...

### Testing Strategy
Key scenarios to test:
1. Valid user registration
2. Duplicate email handling...

### Code Implementation
\`\`\`dart
// Implementation with inline explanations
\`\`\`
```

## General Guidelines
- Always explain architectural decisions
- Show how code supports testing
- Highlight Flutter/Dart best practices
- Reference DDD concepts where relevant
- Consider future maintainability
- Consider performance implications