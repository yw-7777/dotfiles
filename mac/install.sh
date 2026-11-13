#!/usr/bin/env bash
# ========================================================
# 🚀 Dotfiles One-Click Installer for macOS (Apple Silicon & Intel)
# ========================================================

set -e

echo -e "\033[1;36m⚡ Installing Modern macOS Developer Environment...\033[0m"

# 1. Homebrew 설치 여부 확인 및 설치
if ! command -v brew >/dev/null 2>&1; then
    echo -e "\033[1;33m📦 Homebrew가 설치되어 있지 않습니다. Homebrew 설치를 시작합니다...\033[0m"
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    if [ -f "/opt/homebrew/bin/brew" ]; then
        eval "$(/opt/homebrew/bin/brew shellenv)"
    elif [ -f "/usr/local/bin/brew" ]; then
        eval "$(/usr/local/bin/brew shellenv)"
    fi
else
    echo -e "\033[1;32m✓ Homebrew 확인 완료\033[0m"
fi

# 2. 필수 CLI 도구 및 플러그인 설치
echo -e "\033[1;36m📦 현대적 CLI 패키지 설치 중 (Starship, Zoxide, FZF, fd, eza, bat, Zsh 플러그인)...\033[0m"
brew install starship zoxide fzf fd eza bat zsh-autosuggestions zsh-syntax-highlighting

# 3. D2Coding Nerd Font 설치
echo -e "\033[1;36m🔤 D2Coding Nerd Font 설치 중...\033[0m"
brew tap homebrew/cask-fonts 2>/dev/null || true
brew install --cask font-d2coding-nerd-font 2>/dev/null || {
    echo -e "\033[1;33m⚠️ Homebrew 폰트 캐스크 실패 시 수동 다운로드 진행...\033[0m"
    FONT_DIR="$HOME/Library/Fonts"
    curl -fsSL "https://github.com/ryanoasis/nerd-fonts/releases/download/v3.5.1/D2Coding.zip" -o "/tmp/D2Coding.zip"
    unzip -o "/tmp/D2Coding.zip" -d "/tmp/D2Coding"
    cp /tmp/D2Coding/*.ttf "$FONT_DIR/" 2>/dev/null || true
    rm -rf /tmp/D2Coding.zip /tmp/D2Coding
}

# 4. FZF 키바인딩 설정
echo -e "\033[1;36m🔍 FZF 단축키(Ctrl+R) 활성화 중...\033[0m"
"$(brew --prefix)/opt/fzf/install" --all --no-bash --no-fish 2>/dev/null || true

# 5. Starship 설정 배포 (~/.config/starship.toml)
mkdir -p "$HOME/.config"
STARSHIP_SOURCE="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)/common/starship/starship.toml"
if [ -f "$STARSHIP_SOURCE" ]; then
    cp "$STARSHIP_SOURCE" "$HOME/.config/starship.toml"
else
    # 원격 URL에서 직접 설치되는 경우
    curl -fsSL "https://raw.githubusercontent.com/yw-7777/dotfiles/main/common/starship/starship.toml" -o "$HOME/.config/starship.toml"
fi
echo -e "\033[1;32m✓ Starship 프롬프트 설정 완료\033[0m"

# 6. .zshrc 설정 배포
if [ -f "$HOME/.zshrc" ]; then
    BACKUP_FILE="$HOME/.zshrc.bak-$(date +%Y%m%d%H%M%S)"
    cp "$HOME/.zshrc" "$BACKUP_FILE"
    echo -e "\033[1;34mℹ️ 기존 .zshrc 백업됨: $BACKUP_FILE\033[0m"
fi

ZSHRC_SOURCE="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)/zsh/.zshrc"
if [ -f "$ZSHRC_SOURCE" ]; then
    cp "$ZSHRC_SOURCE" "$HOME/.zshrc"
else
    curl -fsSL "https://raw.githubusercontent.com/yw-7777/dotfiles/main/mac/zsh/.zshrc" -o "$HOME/.zshrc"
fi
echo -e "\033[1;32m✓ .zshrc 설정 배포 완료\033[0m"

# 7. 기본 셸 zsh 확인
if [ "$SHELL" != "$(which zsh)" ]; then
    echo -e "\033[1;33m기본 셸을 Zsh로 변경합니다...\033[0m"
    chsh -s "$(which zsh)"
fi

echo -e "\n\033[1;32m========================================================\033[0m"
echo -e "\033[1;32m🎉 macOS Zsh 개발 환경 세팅이 성공적으로 완료되었습니다!\033[0m"
echo -e "\033[1;36m터미널을 재시작하거나 'source ~/.zshrc'를 입력해 즉시 적용하세요.\033[0m"
echo -e "\033[1;32m========================================================\033[0m\n"
