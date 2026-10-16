#!/usr/bin/env bash
# Sync agent skills từ topoteretes/cognee (.agents/skills) vào ./skills của repo này.
# Dùng khi muốn sync thủ công thay vì chờ GitHub Actions.
#
#   ./scripts/sync.sh
#
set -euo pipefail

UPSTREAM="${COGNEE_UPSTREAM:-https://github.com/topoteretes/cognee.git}"
BRANCH="${COGNEE_BRANCH:-main}"
SRC_DIR=".agents/skills"
DEST_DIR="$(cd "$(dirname "$0")/.." && pwd)/skills"

TMP="$(mktemp -d)"
trap 'rm -rf "$TMP"' EXIT

echo ">> Sparse-clone $UPSTREAM@$BRANCH ..."
git clone --depth 1 --filter=blob:none --sparse --branch "$BRANCH" "$UPSTREAM" "$TMP/cognee" --quiet
git -C "$TMP/cognee" sparse-checkout set "$SRC_DIR" --quiet

SHA="$(git -C "$TMP/cognee" rev-parse HEAD)"
echo ">> Upstream HEAD: $SHA"

rm -rf "$DEST_DIR"
mkdir -p "$DEST_DIR"
cp -R "$TMP/cognee/$SRC_DIR/." "$DEST_DIR/"

cd "$(dirname "$0")/.."
git add skills
if git diff --cached --quiet; then
  echo ">> Không có thay đổi — skills đã khớp upstream $SHA"
else
  git commit -m "sync: mirror agent skills from topoteretes/cognee@$SHA"
  echo ">> Đã commit. Chạy 'git push' để đẩy lên remote."
fi
