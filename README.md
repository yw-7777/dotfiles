# ⚡ Modern Multi-Platform Dotfiles (Windows & macOS)

> **macOS (Zsh)** 와 **Windows (PowerShell 7 + Windows Terminal)** 어디서든 동일한 감성, 동일한 단축키, 0.2초 초고속 터미널 개발 환경을 유지하는 dotfiles 저장소입니다.

---

## 🎨 주요 특징 (Features)

* **프롬프트 (공용)**: `Starship` 초경량 1줄 프롬프트 (`directory on git:branch [status] ❯`)
* **글꼴 (공용)**: `D2CodingLigature Nerd Font` (한글/영문 1:2 황금비율 + Nerd Font 아이콘 + 코딩 기호 합자)
* **모던 CLI 스택 (공용)**:
  * `eza` (Rust 파일 뷰어: `ls`, `ll`, `la`, `tree`)
  * `bat` (문법 하이라이팅 `cat`)
  * `zoxide` (스마트 디렉터리 점프: `z <폴더명>`)
  * `fzf` + `fd` (초고속 대화형 파일/히스토리 역방향 검색: `Ctrl + R`)
* **Windows (PowerShell 7)**:
  * `Tokyo Night` 테마 + 70% 아크릴 블러(Acrylic)
  * Microsoft `CompletionPredictor` + Fish 스타일 고스트 텍스트 인라인 추천
  * Zsh 스타일 문법 하이라이팅 (정상 명령어 🟢초록색)
* **macOS (Zsh)**:
  * `zsh-autosuggestions` (Fish 스타일 고스트 텍스트 추천, `Ctrl + F` / `→` 완성)
  * `zsh-syntax-highlighting` (정상 명령어 🟢초록색, 에러 🔴빨간색)
  * 탭 간 실시간 히스토리 공유 (`SHARE_HISTORY`)

---

## 🚀 빠른 시작 (One-Line Quick Install)

새로운 장비나 포맷 후 원하는 운영체제의 한 줄 명령어를 터미널에 붙여넣기만 하면 폰트, CLI 도구, 모든 설정이 자동으로 구성됩니다.

### 🪟 Windows (PowerShell 관리자 권한)
```powershell
irm https://raw.githubusercontent.com/yw-7777/dotfiles/main/install.ps1 | iex
```

### 🍎 macOS (기본 터미널 또는 iTerm2/Ghostty)
```bash
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/yw-7777/dotfiles/main/install.sh)"
```

---

## ⌨️ 킬러 단축키 & 치트시트 (Windows & Mac 공통)

모든 단축키와 함수는 **Windows와 Mac에서 100% 동일하게 동작**하도록 설계되었습니다.

### 1. 시그니처 편의 기능
| 명령어 | 동작 |
| :--- | :--- |
| `take <폴더명>` | `mkdir` + `cd` 동시 실행 (폴더 생성 후 즉시 진입) |
| `open .` | 현재 폴더를 파일 탐색기 / Mac Finder로 즉시 열기 |
| `ports [포트]` | 포트 점유 중인 프로세스(PID, 프로세스명) 즉시 확인 (`ports 3000` / `ports`) |
| `-` | 직전 작업 디렉터리로 즉시 복귀 (`cd -`) |
| `..` / `...` / `....` | 1단계 / 2단계 / 3단계 상위 폴더로 초고속 탈출 |
| `activate` | 현재 디렉터리의 파이썬 가상환경(`.venv` / `venv`) 원클릭 활성화 |

### 2. Git 단축키 (Oh-My-Zsh 스타일)
* `gst` / `gs` : `git status`
* `gaa` : `git add --all`
* `gcm "메시지"` : `git commit -m "메시지"`
* `gcam "메시지"` : `git commit -a -m "메시지"`
* `gp` / `gl` : `git push` / `git pull`
* `gpf` : `git push --force-with-lease`
* `gco <브랜치>` : `git checkout`
* `gcb <새브랜치>` : `git checkout -b`
* `glog` : 1줄 트리 그래프 로그
* `gundo` : 직전 커밋 취소 (`git reset --soft HEAD~1`, 작성 코드 보존)

### 3. 터미널 조작 단축키
* `Ctrl + F` 또는 `→` : 회색 자동완성 추천 전체 수락
* `Tab` : 선택형 메뉴 자동완성
* `Ctrl + R` : 내가 쳤던 모든 명령어 실시간 FZF 대화형 퍼지 검색

---

## 📁 저장소 아키텍처

```text
dotfiles/
├── common/                         # Mac & Windows 공용 설정
│   └── starship/
│       └── starship.toml           # Starship 1줄 미니멀 프롬프트
├── windows/                        # Windows 전용 구성
│   ├── install.ps1                 # Windows 전용 설치 스크립트
│   ├── powershell/
│   │   └── Microsoft.PowerShell_profile.ps1 # PowerShell 7 프로필
│   └── windows-terminal/
│       └── settings.json           # Windows Terminal 테마 & 글꼴
├── mac/                            # macOS 전용 구성
│   ├── install.sh                  # macOS Homebrew 기반 설치 스크립트
│   └── zsh/
│       └── .zshrc                  # macOS Zsh 프로필
├── install.ps1                     # Windows 원클릭 루트 진입점
├── install.sh                      # macOS 원클릭 루트 진입점
└── README.md                       # 문서 및 사용 가이드
```
