#!/bin/sh
# Update requirements files and pre-commit hooks to current versions.
set -e
echo "🧱 Updating project"
uv sync --all-groups
uv lock --upgrade
echo "🛠️ Updating pre-commit"
uv run pre-commit autoupdate
echo "🏛️ Listing outdated Python packages for manual update"
uv pip list --outdated
echo "🎉 Successfully updated dependencies"
