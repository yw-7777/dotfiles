#!/usr/bin/env bash
# ========================================================
# 🚀 Multi-Platform Entry Point for Dotfiles Installer
# ========================================================

set -e

OS="$(uname -s)"

case "$OS" in
    Darwin*)
        SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
        LOCAL_MAC_INSTALL="$SCRIPT_DIR/mac/install.sh"
        if [ -f "$LOCAL_MAC_INSTALL" ]; then
            bash "$LOCAL_MAC_INSTALL"
        else
            /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/yw-7777/dotfiles/main/mac/install.sh)"
        fi
        ;;
    Linux*)
        echo "🐧 Linux 환경이 감지되었습니다."
        echo "현재 dotfiles는 macOS(Zsh)와 Windows(PowerShell 7)에 최적화되어 있습니다."
        ;;
    *)
        echo "알 수 없는 운영체제입니다: $OS"
        exit 1
        ;;
esac
