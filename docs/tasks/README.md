# Parallel Issue Setup

This directory contains a CSV file describing a set of issues that can be created in parallel using the GitHub API.

## Files

- `parallel_issues.csv` - CSV with columns `title`, `body`, and optional `labels`.
- `../../scripts/bulk_create_issues.py` - Script to create issues concurrently.

## Usage

1. Ensure you have Python 3.8+ and install dependencies:
   ```bash
   pip install aiohttp
   ```
2. Export your GitHub repository and token:
   ```bash
   export GITHUB_REPOSITORY="owner/repo"
   export GITHUB_TOKEN="<YOUR_PERSONAL_ACCESS_TOKEN>"
   ```
3. Run the script with the CSV file:
   ```bash
   python scripts/bulk_create_issues.py docs/tasks/parallel_issues.csv
   ```

The script will create each issue concurrently, printing the created issue numbers upon success.
