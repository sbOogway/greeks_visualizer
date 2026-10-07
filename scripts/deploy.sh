#!/bin/sh
# Publish dist/ to the gh-pages branch without touching the working tree or current branch.
# Usage: deploy.sh [commit]   — commit to build from (default HEAD).
set -eu
cd "$(dirname "$0")/.."
rev="${1:-HEAD}"
sha=$(git rev-parse --short "$rev")
sh scripts/build.sh "$rev"

tmp_index=$(mktemp)
trap 'rm -f "$tmp_index"' EXIT
rm -f "$tmp_index"
GIT_INDEX_FILE="$tmp_index" git --work-tree=dist add -A .
tree=$(GIT_INDEX_FILE="$tmp_index" git write-tree)

parent=""
if git fetch -q origin gh-pages 2>/dev/null; then parent=$(git rev-parse FETCH_HEAD)
elif git rev-parse -q --verify refs/heads/gh-pages >/dev/null; then parent=$(git rev-parse refs/heads/gh-pages); fi

if [ -n "$parent" ] && [ "$(git rev-parse "$parent^{tree}")" = "$tree" ]; then
  echo "gh-pages already up to date with $sha"
  exit 0
fi

commit=$(git commit-tree "$tree" ${parent:+-p "$parent"} -m "Deploy $sha to GitHub Pages")
git update-ref refs/heads/gh-pages "$commit"
# --no-verify: this push must not re-run the pre-push hook that called us.
git push --no-verify origin gh-pages
echo "deployed $sha to gh-pages"
