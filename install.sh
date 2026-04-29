#!/usr/bin/env bash
set -euo pipefail

REPO="alirehmani/sureshift-dist"
APP="sureshift"
VERSION="${VERSION:-latest}"

OS="$(uname -s)"
ARCH="$(uname -m)"

case "$OS" in
Linux)
FILE="sureshift-linux-x64.tar.gz"
;;
Darwin)
if [ "$ARCH" = "arm64" ]; then
FILE="sureshift-macos-arm64.tar.gz"
else
FILE="sureshift-macos-x64.tar.gz"
fi
;;
*)
echo "Unsupported OS"
exit 1
;;
esac

URL="https://github.com/${REPO}/releases/${VERSION}/download/${FILE}"

TMP_DIR="$(mktemp -d)"
cd "$TMP_DIR"

curl -LO "$URL"
tar -xzf "$FILE"

chmod +x "$APP"
sudo mv "$APP" /usr/local/bin/

echo "Installed $APP"
