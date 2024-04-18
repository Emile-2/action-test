
name: Rebase Check Workflow

on:
  pull_request:
    types: [opened, synchronize, reopened]

jobs:
  check-rebase:
    runs-on: ubuntu-latest
    steps:
      - name: Checkout the base branch
        uses: actions/checkout@v3

      - name: Checkout the head branch
        uses: actions/checkout@v3
      

      - name: Check if head branch is rebased onto base branch
        run: |
          git_hash=$(git rev-parse "$GITHUB_SHA")
          echo "branch commit: $git_hash"

          main_head=$(git rev-parse origin/main)
          echo "Trunk head: $main_head"

          branch_source_commit_id="$git merge-base "git_hash" origin/main)"
          echo "First commit of this branch: $branch_source_commit_id"

          if [[ "$branch_source_commit_id" != "$main_head" ]]; then
            echo "Error: you need to rebase with head main"
            exit 1
          fi