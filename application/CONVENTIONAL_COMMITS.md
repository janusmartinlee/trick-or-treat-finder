# Conventional Commits

This project follows the [Conventional Commits](https://www.conventionalcommits.org/) specification for automatic semantic versioning.

## Commit Message Format

```
<type>[optional scope]: <description>

[optional body]

[optional footer(s)]
```

## Types

- **feat**: A new feature (triggers MINOR version bump)
- **fix**: A bug fix (triggers PATCH version bump)
- **docs**: Documentation only changes
- **style**: Changes that do not affect the meaning of the code
- **refactor**: A code change that neither fixes a bug nor adds a feature
- **perf**: A code change that improves performance
- **test**: Adding missing tests or correcting existing tests
- **chore**: Changes to the build process or auxiliary tools

## Breaking Changes

Add `BREAKING CHANGE:` in the footer or `!` after the type to trigger a MAJOR version bump.

## Examples

```bash
feat: add flag emojis to language selection
fix: resolve deprecated RadioListTile usage
feat!: implement new authentication system
docs: update README with setup instructions
test: add unit tests for preferences use case
chore: update Flutter dependencies
```

## Automatic Versioning

- `feat:` → **1.1.0** (minor)
- `fix:` → **1.0.1** (patch) 
- `feat!:` or `BREAKING CHANGE:` → **2.0.0** (major)