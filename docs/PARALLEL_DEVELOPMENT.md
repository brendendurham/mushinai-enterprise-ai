# Parallel Development with Git Worktrees

This repository is configured for parallel development using Git worktrees, as recommended in the [Claude Code documentation](https://docs.anthropic.com/en/docs/claude-code/tutorials#run-parallel-claude-code-sessions-with-git-worktrees).

## Worktree Structure

We have set up the following worktrees for parallel development:

```
/Users/mushinai/workspace/projects/
├── mushinai-enterprise-ai/          # Main repository (main branch)
├── mushinai-api-development/        # API development (feature/api-development)
├── mushinai-ml-development/         # ML/AI development (feature/ml-development)
└── mushinai-frontend-development/   # Frontend development (feature/frontend-development)
```

## Agent Responsibilities

### 1. API Development Agent
**Worktree**: `mushinai-api-development`
**Branch**: `feature/api-development`

Responsibilities:
- RESTful API implementation
- GraphQL API development
- Authentication and authorization services
- API documentation and testing
- Database schema and migrations

Key directories:
- `/api/rest/`
- `/api/graphql/`
- `/services/auth/`
- `/docs/api/`

### 2. ML Development Agent
**Worktree**: `mushinai-ml-development`
**Branch**: `feature/ml-development`

Responsibilities:
- Machine learning model development
- ML pipelines and workflows
- Model training and evaluation
- Data processing and augmentation
- Model deployment infrastructure

Key directories:
- `/ml/models/`
- `/ml/pipelines/`
- `/ml/datasets/`
- `/services/analytics/`

### 3. Frontend Development Agent
**Worktree**: `mushinai-frontend-development`
**Branch**: `feature/frontend-development`

Responsibilities:
- Web dashboard development
- Mobile application development
- UI/UX implementation
- Frontend testing and optimization
- Client-side state management

Key directories:
- `/web/dashboard/`
- `/web/client/`
- `/web/mobile/`
- `/src/integrations/`

## Workflow Guidelines

### 1. Starting a New Session
When starting a new Claude Code session for a specific domain:

```bash
# For API development
cd /Users/mushinai/workspace/projects/mushinai-api-development

# For ML development
cd /Users/mushinai/workspace/projects/mushinai-ml-development

# For Frontend development
cd /Users/mushinai/workspace/projects/mushinai-frontend-development
```

### 2. Synchronizing Changes
```bash
# Fetch latest changes from main
git fetch origin main

# Merge or rebase your feature branch
git merge origin/main
# or
git rebase origin/main
```

### 3. Creating Pull Requests
Each worktree should create PRs to the main branch:

```bash
# Push your feature branch
git push -u origin feature/your-feature-name

# Create PR using GitHub CLI
gh pr create --base main --title "Your PR title" --body "Description"
```

### 4. Switching Between Worktrees
```bash
# List all worktrees
git worktree list

# Navigate to a specific worktree
cd /Users/mushinai/workspace/projects/mushinai-api-development
```

## Best Practices

1. **Isolation**: Each agent works in their own worktree to avoid conflicts
2. **Regular Syncs**: Frequently sync with the main branch to stay updated
3. **Small PRs**: Create small, focused pull requests for easier review
4. **Communication**: Document cross-team dependencies in issues
5. **Testing**: Ensure all tests pass before creating PRs

## Managing Worktrees

### Adding a New Worktree
```bash
cd /Users/mushinai/workspace/projects/mushinai-enterprise-ai
git worktree add ../mushinai-new-feature -b feature/new-feature
```

### Removing a Worktree
```bash
# Remove the worktree
git worktree remove /path/to/worktree

# Clean up stale worktree references
git worktree prune
```

### Listing Worktrees
```bash
git worktree list
```

## Integration Points

When working across domains, use these integration patterns:

1. **API Contracts**: Define clear API interfaces in `/docs/api/`
2. **Shared Types**: Maintain type definitions in `/src/core/types/`
3. **Common Utils**: Share utilities in `/src/core/utils/`
4. **Configuration**: Centralize config in `/src/core/config/`

## Continuous Integration

Each feature branch triggers its own CI pipeline:
- API tests run for `feature/api-*` branches
- ML tests run for `feature/ml-*` branches
- Frontend tests run for `feature/frontend-*` branches

All tests must pass before merging to main.

---

This setup enables efficient parallel development while maintaining code quality and integration standards.