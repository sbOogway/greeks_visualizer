#!/bin/sh
# Wrap index.html (an artifact-style fragment: no doctype/html/head) into a standalone page in dist/.
# Usage: build.sh [commit]   — builds from that commit's index.html, or the working tree if omitted.
set -eu
cd "$(dirname "$0")/.."
rev="${1:-}"
rm -rf dist && mkdir -p dist
{
  printf '<!doctype html>\n<html lang="en">\n<head>\n'
  printf '<meta name="viewport" content="width=device-width, initial-scale=1, viewport-fit=cover">\n'
  if [ -n "$rev" ]; then git show "$rev:index.html"; else cat index.html; fi
  printf '\n</html>\n'
} > dist/index.html
touch dist/.nojekyll
echo "built dist/ from ${rev:-working tree}"
