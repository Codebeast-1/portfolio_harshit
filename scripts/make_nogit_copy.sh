#!/usr/bin/env bash
# Creates a clean copy of the repo without .git history or build artifacts.
# Usage: ./scripts/make_nogit_copy.sh

set -euo pipefail

SRC_DIR=$(cd "$(dirname "$0")/.." && pwd)
DEST_DIR="$SRC_DIR"_nogit

echo "Source: $SRC_DIR"
echo "Destination: $DEST_DIR"

# Exclude patterns: .git, node_modules, .next, .vercel, .cache, dist, logs
rsync -a \
  --exclude='.git' \
  --exclude='node_modules' \
  --exclude='.next' \
  --exclude='.vercel' \
  --exclude='.cache' \
  --exclude='dist' \
  --exclude='*.log' \
  --exclude='coverage' \
  --exclude='*.sqlite' \
  --delete \
  "$SRC_DIR/" "$DEST_DIR/"

# Ensure .git is not accidentally copied
if [ -d "$DEST_DIR/.git" ]; then
  rm -rf "$DEST_DIR/.git"
fi

echo "Clean copy created at: $DEST_DIR"

echo "You can now cd to the new folder and use it without git history."
echo "Example: cd $DEST_DIR"

exit 0
