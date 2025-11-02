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

### 5. Code Structure
- Feature/domain concept organization
- Key dependencies and their direction
- Interface boundaries
- Component responsibilities and interactions

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

## Design Principles

### Primary Focus
- Strong separation of concerns between layers and components
- High cohesion within modules (things that change together stay together)
- Clear boundaries between bounded contexts
- Domain logic isolation from infrastructure concerns

### Secondary Considerations
- Pragmatic approach to implementation details
- Focus on behavior correctness over code aesthetics
- Performance considerations where relevant
- Flutter/Dart idioms where they don't conflict with primary concerns

### Code Organization Philosophy
- Group by feature/domain concept rather than technical layer
- Keep related code close together
- Minimize dependencies between modules
- Infrastructure code should depend on domain, never vice versa

### Testing Priorities
- Focus on behavior and integration tests
- Unit tests for complex domain logic
- Less emphasis on test aesthetics, more on coverage of critical paths
- Tests should validate boundaries between contexts