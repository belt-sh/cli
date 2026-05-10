#!/bin/bash
set -e

VERSION=${VERSION:-latest}
OS=$(uname -s | tr '[:upper:]' '[:lower:]')
ARCH=$(uname -m)

case "$ARCH" in
  x86_64) ARCH="amd64" ;;
  arm64|aarch64) ARCH="arm64" ;;
  *) echo "unsupported architecture: $ARCH" && exit 1 ;;
esac

# set install dir
if [ "$(id -u)" -ne 0 ] && [ -z "$INSTALL_DIR" ]; then
  INSTALL_DIR="$HOME/.local/bin"
  mkdir -p "$INSTALL_DIR"

  PATH_LINE='export PATH="$HOME/.local/bin:$PATH"'
  add_path() { [ -f "$1" ] && grep -q '\.local/bin' "$1" || echo "$PATH_LINE" >> "$1"; }
  if [ "$OS" = "darwin" ]; then
    add_path "$HOME/.zshrc"
    add_path "$HOME/.bash_profile"
  else
    add_path "$HOME/.bashrc"
  fi

  export PATH="$INSTALL_DIR:$PATH"
else
  INSTALL_DIR=${INSTALL_DIR:-/usr/local/bin}
fi

DIST_BASE="https://dist.inference.sh/cli"

# resolve download url and aliases from manifest
MANIFEST=""
if [ "$VERSION" = "latest" ]; then
  MANIFEST=$(curl -fsSL "$DIST_BASE/manifest.json")
  URL=$(echo "$MANIFEST" | grep -o "\"$OS-$ARCH\":{[^}]*}" | grep -o 'https[^"]*')
else
  URL="$DIST_BASE/inferencesh-cli-${VERSION}-${OS}-${ARCH}.tar.gz"
fi

# parse aliases from manifest
if [ -n "$MANIFEST" ]; then
  ALIASES=$(echo "$MANIFEST" | grep -o '"aliases":\[[^]]*\]' | grep -o '"[^"]*"' | grep -v '^"aliases"$' | tr -d '"' | tr '\n' ' ')
fi
if [ -z "$ALIASES" ]; then
  ALIASES="belt infsh"
fi

NAME=$(basename "$URL" .tar.gz)
TARBALL_NAME=$(basename "$URL")
TMP=$(mktemp -d)
trap 'rm -rf "$TMP"' EXIT

echo "downloading belt $VERSION for $OS-$ARCH..."
curl -fsSL "$URL" -o "$TMP/$TARBALL_NAME"

# verify checksum
echo "verifying checksum..."
curl -fsSL "$DIST_BASE/checksums.txt" -o "$TMP/checksums.txt"
EXPECTED=$(grep "$TARBALL_NAME" "$TMP/checksums.txt" | awk '{print $1}')
if [ -z "$EXPECTED" ]; then
  echo "warning: no checksum found for $TARBALL_NAME, skipping verification"
else
  if command -v sha256sum >/dev/null 2>&1; then
    ACTUAL=$(sha256sum "$TMP/$TARBALL_NAME" | awk '{print $1}')
  elif command -v shasum >/dev/null 2>&1; then
    ACTUAL=$(shasum -a 256 "$TMP/$TARBALL_NAME" | awk '{print $1}')
  else
    echo "warning: no sha256sum or shasum found, skipping verification"
    ACTUAL="$EXPECTED"
  fi
  if [ "$ACTUAL" != "$EXPECTED" ]; then
    echo "error: checksum mismatch!"
    echo "  expected: $EXPECTED"
    echo "  got:      $ACTUAL"
    echo "the download may be corrupted or tampered with."
    exit 1
  fi
  echo "checksum verified."
fi

# verify signature if cosign available
if command -v cosign >/dev/null 2>&1; then
  echo "verifying signature..."
  BUNDLE="$TMP/checksums.txt.bundle"
  curl -fsSL "$DIST_BASE/checksums.txt.bundle" -o "$BUNDLE" 2>/dev/null && \
  cosign verify-blob "$TMP/checksums.txt" \
    --bundle "$BUNDLE" \
    --key "$DIST_BASE/cosign.pub" && \
  echo "signature verified." || \
  echo "warning: signature verification failed, continuing with checksum-only."
fi

tar -xzf "$TMP/$TARBALL_NAME" -C "$TMP"
BIN="$TMP/$NAME"

chmod +x "$BIN"
rm -f "$INSTALL_DIR/inferencesh"
for alias in $ALIASES; do
  rm -f "$INSTALL_DIR/$alias"
done
mv "$BIN" "$INSTALL_DIR/inferencesh"
for alias in $ALIASES; do
  ln -sf inferencesh "$INSTALL_DIR/$alias"
done

echo "installed to $INSTALL_DIR"
ALIAS_LIST=$(echo "$ALIASES" | tr ' ' ',' | sed 's/,$//')
echo "run 'belt' (aliases: $ALIAS_LIST)"
