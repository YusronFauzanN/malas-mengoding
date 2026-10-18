#!/usr/bin/env bash
set -e

REPO="YusronFauzanN/malas-mengoding"
INSTALL_DIR="$HOME/.local/bin"

OS="$(uname -s)"
ARCH="$(uname -m)"

case "$OS" in
  Linux)
    case "$ARCH" in
      x86_64) ARTIFACT="forge-linux-x86_64.tar.gz" ;;
      *) echo "Arsitektur $ARCH tidak didukung untuk Linux"; exit 1 ;;
    esac
    ;;
  Darwin)
    case "$ARCH" in
      arm64|aarch64) ARTIFACT="forge-macos-arm64.tar.gz" ;;
      *) echo "Arsitektur $ARCH tidak didukung untuk macOS"; exit 1 ;;
    esac
    ;;
  *)
    echo "OS $OS tidak didukung oleh installer ini"; exit 1 ;;
esac

DOWNLOAD_URL="https://github.com/$REPO/releases/latest/download/$ARTIFACT"
TMP_DIR="$(mktemp -d)"

echo "Mengunduh Forge AI ($ARTIFACT)..."
curl -fsSL "$DOWNLOAD_URL" -o "$TMP_DIR/$ARTIFACT"

echo "Mengekstrak ke $INSTALL_DIR..."
mkdir -p "$INSTALL_DIR"
tar -xzf "$TMP_DIR/$ARTIFACT" -C "$INSTALL_DIR"
chmod +x "$INSTALL_DIR/forge" "$INSTALL_DIR/tengu" 2>/dev/null || true
rm -rf "$TMP_DIR"

# Cek PATH
case ":$PATH:" in
  *":$INSTALL_DIR:"*) ;;
  *)
    echo ""
    echo "PENTING: Tambahkan direktori instalasi ke PATH di shell profile Anda (~/.bashrc atau ~/.zshrc):"
    echo "  export PATH=\"\$HOME/.local/bin:\$PATH\""
    ;;
esac

echo ""
echo "Instalasi Berhasil! Ketik 'forge' untuk memulai."
