# ========================================================
# ⚡ Antigravity Ultimate Developer Zsh Profile (macOS)
# ========================================================

# 1. 인코딩 및 환경 변수
export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8

# Homebrew 경로 설정 (Apple Silicon M1/M2/M3/M4 및 Intel Mac 지원)
if [ -f "/opt/homebrew/bin/brew" ]; then
    eval "$(/opt/homebrew/bin/brew shellenv)"
elif [ -f "/usr/local/bin/brew" ]; then
    eval "$(/usr/local/bin/brew shellenv)"
fi

# PATH 확장
export PATH="$HOME/bin:$HOME/.local/bin:$PATH"

# 2. Zsh 히스토리 최적화
HISTFILE="$HOME/.zsh_history"
HISTSIZE=50000
SAVEHIST=50000
setopt EXTENDED_HISTORY          # 타임스탬프 기록
setopt SHARE_HISTORY             # 모든 터미널 탭 간 실시간 히스토리 공유
setopt HIST_EXPIRE_DUPS_FIRST    # 중복 기록 시 오래된 중복부터 삭제
setopt HIST_IGNORE_DUPS          # 연속 중복 명령 무시
setopt HIST_IGNORE_ALL_DUPS      # 전체 중복 삭제
setopt HIST_FIND_NO_DUPS         # 히스토리 탐색 시 중복 제외
setopt HIST_IGNORE_SPACE         # 공백으로 시작하는 명령어는 히스토리에 미기록

# 3. 플러그인 로드 (Homebrew 기반)
# (1) zsh-autosuggestions (Fish 스타일 회색 자동완성 제안)
if [ -f "$(brew --prefix 2>/dev/null)/share/zsh-autosuggestions/zsh-autosuggestions.zsh" ]; then
    source "$(brew --prefix)/share/zsh-autosuggestions/zsh-autosuggestions.zsh"
    # 추천 제안 색상: 은은한 회색 (ANSI 244)
    ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=244'
    # 오른쪽 방향키(→) 또는 Ctrl+F로 제안 수락
    bindkey '^F' autosuggest-accept
elif [ -f "$HOME/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh" ]; then
    source "$HOME/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh"
    ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=244'
    bindkey '^F' autosuggest-accept
fi

# (2) zsh-syntax-highlighting (명령어 실시간 유효성 검사 - 정상 초록색, 에러 빨간색)
if [ -f "$(brew --prefix 2>/dev/null)/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh" ]; then
    source "$(brew --prefix)/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"
elif [ -f "$HOME/.zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh" ]; then
    source "$HOME/.zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"
fi

# 4. Starship 프롬프트 (초고속 미니멀 프롬프트)
if command -v starship >/dev/null 2>&1; then
    eval "$(starship init zsh)"
fi

# 5. Zoxide 초고속 디렉터리 점프 ('z 폴더명')
if command -v zoxide >/dev/null 2>&1; then
    eval "$(zoxide init zsh)"
fi

# 6. FZF + fd 초고속 퍼지 검색 (Ctrl + R: 히스토리 검색)
if command -v fd >/dev/null 2>&1; then
    export FZF_DEFAULT_COMMAND='fd --type f --hidden --exclude .git'
    export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
fi
if [ -f "$HOME/.fzf.zsh" ]; then
    source "$HOME/.fzf.zsh"
elif [ -f "$(brew --prefix 2>/dev/null)/opt/fzf/shell/key-bindings.zsh" ]; then
    source "$(brew --prefix)/opt/fzf/shell/key-bindings.zsh"
    source "$(brew --prefix)/opt/fzf/shell/completion.zsh"
fi

# 7. eza (Rust 기반 초고속 파일 목록 + 아이콘 + Git 상태)
if command -v eza >/dev/null 2>&1; then
    alias ls="eza --icons=auto"
    alias ll="eza --icons=auto -l --git --time-style=relative"
    alias la="eza --icons=auto -la --git"
    alias tree="eza --tree --icons=auto"
    alias d="ls"
else
    alias ll="ls -alF"
    alias la="ls -A"
    alias d="ls"
fi

# 8. bat (문법 하이라이팅 지원 cat)
if command -v bat >/dev/null 2>&1; then
    export BAT_THEME="TwoDark"
    alias cat="bat"
fi

# 9. Oh-My-Zsh 시그니처 편의 함수
# 디렉터리 생성 후 즉시 진입
take() {
    if [ -n "$1" ]; then
        mkdir -p "$1" && cd "$1"
    fi
}

# 현재 포트 사용 프로세스 확인 (예: ports 3000 또는 ports 전체 목록)
ports() {
    if [ -n "$1" ]; then
        lsof -i :"$1"
    else
        lsof -iTCP -sTCP:LISTEN -P -n
    fi
}

# 상위 폴더 빠른 이동
alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."
alias -- -="cd -"

# Python 가상환경 원클릭 활성화
activate() {
    if [ -f ".venv/bin/activate" ]; then
        source .venv/bin/activate
    elif [ -f "venv/bin/activate" ]; then
        source venv/bin/activate
    else
        echo "⚠️ .venv 또는 venv 가상환경 폴더를 찾을 수 없습니다."
    fi
}

# 10. Oh-My-Zsh 시그니처 Git 단축키
if command -v git >/dev/null 2>&1; then
    alias g="git"
    alias gs="git status"
    alias gst="git status"
    alias ga="git add"
    alias gaa="git add --all"
    alias gc="git commit -m"
    alias gcm="git commit -m"
    alias gcam="git commit -a -m"
    alias gp="git push"
    alias gpf="git push --force-with-lease"
    alias gl="git pull"
    alias gb="git branch"
    alias gco="git checkout"
    alias gcb="git checkout -b"
    alias glog="git log --oneline --graph --decorate -n 15"
    alias gd="git diff"
    alias gundo="git reset --soft HEAD~1"
fi
