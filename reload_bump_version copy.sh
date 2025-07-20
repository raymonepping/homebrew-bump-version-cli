#!/usr/bin/env bash
set -euo pipefail

# === Config ===
FORMULA_PATH="./Formula/bump-version-cli.rb"
FORMULA_NAME="bump-version-cli"
REPO_URL="https://github.com/raymonepping/homebrew-bump-version-cli"
SLEEP_DURATION=3

# === Parse arguments ===
VERSION=""
PUBLISH=false
SKIP_REINSTALL=false

# Scan arguments for version-like value first
for arg in "$@"; do
  if [[ "$arg" =~ ^v?[0-9]+\.[0-9]+\.[0-9]+$ ]]; then
    VERSION="${arg#v}"         # strip leading v if present
  elif [[ "$arg" == "--publish-gh-release" ]]; then
    PUBLISH=true
  elif [[ "$arg" == "--skip-reinstall" ]]; then
    SKIP_REINSTALL=true
  fi
done

# Auto-detect latest version if not supplied
if [[ -z "$VERSION" ]]; then
  if git describe --tags --abbrev=0 &>/dev/null; then
    VERSION="$(git describe --tags --abbrev=0)"
    VERSION="${VERSION#v}"
    echo "📌 Auto-detected version: v$VERSION"
  else
    echo "❌ No version argument supplied, and no tags found in repo."
    echo "   Usage: $0 <version> [--publish-gh-release] [--skip-reinstall]"
    exit 1
  fi
fi

# Validate version again (must be X.Y.Z)
if [[ ! "$VERSION" =~ ^[0-9]+\.[0-9]+\.[0-9]+$ ]]; then
  echo "❌ Invalid version: '$VERSION'"
  echo "   Usage: $0 <version> [--publish-gh-release] [--skip-reinstall]"
  exit 1
fi

TARBALL_URL="$REPO_URL/archive/refs/tags/v$VERSION.tar.gz"

echo ""
echo "📦 Updating Homebrew formula for $FORMULA_NAME to version v$VERSION..."

# Optional wait to ensure tag is processed
echo "⏳ Waiting $SLEEP_DURATION s for GitHub to process tag..."
sleep "$SLEEP_DURATION"

# Check tarball availability (max 5 attempts, 2s between)
echo "🔎 Checking tarball availability..."
attempt=1
while ! curl --head --fail --silent "$TARBALL_URL" >/dev/null && (( attempt <= 5 )); do
  echo "⏳ Tarball not ready yet. Retrying ($attempt/5)..."
  sleep 2
  attempt=$((attempt + 1))
done

if ! curl --head --fail --silent "$TARBALL_URL" >/dev/null; then
  echo "❌ Tarball $TARBALL_URL is still not available after retrying."
  exit 1
fi

# Compute SHA256
SHA256=$(curl -sL "$TARBALL_URL" | shasum -a 256 | awk '{ print $1 }')
echo "🔐 SHA256: $SHA256"

# Update formula file (url, sha256, and version)
sed -i '' "s|url \".*\"|url \"$TARBALL_URL\"|" "$FORMULA_PATH"
sed -i '' "s|sha256 \".*\"|sha256 \"$SHA256\"|" "$FORMULA_PATH"

if grep -q '^  version "' "$FORMULA_PATH"; then
  sed -i '' "s|^  version \".*\"|  version \"$VERSION\"|" "$FORMULA_PATH"
else
  echo "⚠️ No 'version' field found in formula. Consider adding it for Homebrew to track version properly."
fi

echo "📝 Formula updated."

# Commit and push formula change if needed
if ! git diff --quiet; then
  git add "$FORMULA_PATH"
  git commit -m "🔖 $FORMULA_NAME: release v$VERSION"
  git push
else
  echo "ℹ️ No changes to commit."
fi

# Create GitHub release if requested
if [[ "$PUBLISH" == true ]]; then
  echo "📣 Publishing GitHub release..."
  if ! gh release create "v$VERSION" --title "bump_version $VERSION" --notes "Release $VERSION"; then
    echo "ℹ️ Tag v$VERSION already exists, skipping creation."
  fi
  echo "🌐 $REPO_URL/releases/tag/v$VERSION"
fi

# Optionally reinstall via Homebrew
if [[ "$SKIP_REINSTALL" == true ]]; then
  echo "⏭️  Skipping reinstall as requested via --skip-reinstall."
else
  echo "🍺 Reinstalling via Homebrew..."
  if brew list "$FORMULA_NAME" >/dev/null 2>&1; then
    brew uninstall --force "$FORMULA_NAME" || true
  fi

  brew install --formula --build-from-source "$FORMULA_PATH"

  echo "🔗 Relinking..."
  brew link --overwrite --force "$FORMULA_NAME" || true

  echo "✅ Verifying installed version..."
  BINARY_PATH="$(brew --prefix $FORMULA_NAME 2>/dev/null)/bin/bump_version"

  if [[ -x "$BINARY_PATH" ]]; then
    "$BINARY_PATH" --version
  else
    echo "⚠️  bump_version binary not found in expected path. You may need to run:"
    echo "  brew link --overwrite --force $FORMULA_NAME"
  fi
fi

echo "🔗 Ensuring latest Homebrew link..."
brew link --overwrite bump-version-cli

echo "✅ Checking installed version:"
bump_version --version
