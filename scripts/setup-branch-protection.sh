#!/bin/bash

# Script to set up branch protection rules for the main branch
# Run this script with: bash scripts/setup-branch-protection.sh

echo "Setting up branch protection for main branch..."

# Check if gh CLI is installed
if ! command -v gh &> /dev/null; then
    echo "GitHub CLI (gh) is not installed. Please install it first."
    echo "Visit: https://cli.github.com/manual/installation"
    exit 1
fi

# Check if user is authenticated
if ! gh auth status &> /dev/null; then
    echo "Please authenticate with GitHub CLI first:"
    echo "Run: gh auth login"
    exit 1
fi

# Set up branch protection rules using JSON input
gh api \
  --method PUT \
  -H "Accept: application/vnd.github.v3+json" \
  /repos/brendendurham/mushinai-enterprise-ai/branches/main/protection \
  --input - <<EOF
{
  "required_status_checks": {
    "strict": true,
    "contexts": ["test-python", "test-nodejs", "security-check"]
  },
  "enforce_admins": true,
  "required_pull_request_reviews": {
    "required_approving_review_count": 1,
    "dismiss_stale_reviews": true,
    "require_code_owner_reviews": true
  },
  "restrictions": null,
  "allow_force_pushes": false,
  "allow_deletions": false
}
EOF

if [ $? -eq 0 ]; then
    echo "✅ Branch protection rules successfully applied to main branch!"
else
    echo "❌ Failed to apply branch protection rules. Please check your permissions."
fi

echo ""
echo "Branch protection settings:"
echo "- Require pull request reviews (1 approval)"
echo "- Dismiss stale reviews when new commits are pushed"
echo "- Require review from code owners"
echo "- Require status checks to pass (CI/CD)"
echo "- Require branches to be up to date before merging"
echo "- Prevent force pushes"
echo "- Prevent branch deletion"