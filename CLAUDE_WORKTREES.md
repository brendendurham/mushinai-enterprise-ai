# Claude Code Worktree Setup

This repository uses Git worktrees to enable parallel development with multiple Claude Code agents, as described in the [official documentation](https://docs.anthropic.com/en/docs/claude-code/tutorials#run-parallel-claude-code-sessions-with-git-worktrees).

## Quick Start

### API Development
```bash
# Navigate to API worktree
cd /Users/mushinai/workspace/projects/mushinai-api-development

# Start your Claude Code session here
# You'll be working on the feature/api-development branch
```

### ML Development
```bash
# Navigate to ML worktree
cd /Users/mushinai/workspace/projects/mushinai-ml-development

# Start your Claude Code session here
# You'll be working on the feature/ml-development branch
```

### Frontend Development
```bash
# Navigate to Frontend worktree
cd /Users/mushinai/workspace/projects/mushinai-frontend-development

# Start your Claude Code session here
# You'll be working on the feature/frontend-development branch
```

## Worktree Locations

| Purpose | Directory | Branch |
|---------|-----------|--------|
| Main | `/Users/mushinai/workspace/projects/mushinai-enterprise-ai` | `main` |
| API | `/Users/mushinai/workspace/projects/mushinai-api-development` | `feature/api-development` |
| ML | `/Users/mushinai/workspace/projects/mushinai-ml-development` | `feature/ml-development` |
| Frontend | `/Users/mushinai/workspace/projects/mushinai-frontend-development` | `feature/frontend-development` |

## Benefits

1. **No Conflicts**: Each agent works in isolation
2. **Parallel Development**: Multiple features can progress simultaneously
3. **Clear Ownership**: Each domain has its own workspace
4. **Easy Integration**: Changes merge back to main through PRs

## Commands

```bash
# List all worktrees
git worktree list

# Create a new worktree
git worktree add ../my-new-feature -b feature/my-new-feature

# Remove a worktree
git worktree remove ../my-old-feature
```

For detailed documentation, see [docs/PARALLEL_DEVELOPMENT.md](docs/PARALLEL_DEVELOPMENT.md).