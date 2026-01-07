#!/usr/bin/env bash
set -e

BRANCH="main"

if ! git rev-parse --is-inside-work-tree >/dev/null 2>&1; then
  echo "ERROR: Not inside a git repository"
  exit 1
fi

echo "WARNING: This will PERMANENTLY delete ALL local changes."
echo "Target: origin/$BRANCH"
read -rp "Type YES to continue: " CONFIRM

if [ "$CONFIRM" != "YES" ]; then
  echo "Aborted."
  exit 1
fi

git fetch origin
git reset --hard "origin/$BRANCH"
git clean -fd

echo "Repository now matches origin/$BRANCH"

