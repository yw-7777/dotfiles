# ⚡ Modern Dotfiles for Windows Terminal & PowerShell 7

> Mac의 **Oh-My-Zsh & Fish** 감성을 윈도우 순정 **Windows Terminal + PowerShell 7**에 완벽 이식한 초고속(0.2s) 개발자 세팅

---

## 🎨 주요 특징 (Features)

* **테마**: `Tokyo Night` 다크 인디고 테마 + 70% 아크릴 블러(Acrylic)
* **글꼴**: `D2CodingLigature Nerd Font` (한글/영문 1:2 황금비율 + Nerd Font 아이콘 + 코딩 기호 합자)
* **프롬프트**: `Starship` 초경량 1줄 프롬프트 (`directory on git:branch [status] ❯`)
* **문법 하이라이팅**: Zsh (`zsh-syntax-highlighting`) 시그니처 색상 매핑 (정상 명령어 🟢초록색 점등)
* **자동완성**: Microsoft 공식 `CompletionPredictor` + Fish 스타일 고스트 텍스트 (`→`로 즉시 완성, `F2`로 드롭다운 전환)
* **초고속 Modern Unix 도구**:
  * `eza` (Rust 파일 뷰어: `ls`, `ll`, `la`, `tree`)
  * `bat` (문법 하이라이팅 `cat`)
  * `zoxide` (스마트 디렉터리 점프: `z <폴더명>`)
  * `fzf` + `fd` (초고속 대화형 파일/히스토리 역방향 검색: `Ctrl + R`)

---

## 🚀 빠른 시작 (One-Line Quick Install)

새 컴퓨터나 다른 PC에서 아래 한 줄만 실행하면 모든 폰트, CLI 도구, 설정이 1분 만에 자동으로 구성됩니다.

```powershell
irm https://raw.githubusercontent.com/yw-7777/dotfiles/main/install.ps1 | iex
```

---

## ⌨️ 킬러 단축키 & 치트시트

### 1. Oh-My-Zsh 시그니처 편의 기능
| 명령어 | 동작 |
| :--- | :--- |
| `take <폴더명>` | `mkdir` + `cd` 동시 실행 (폴더 만들고 즉시 이동) |
| `open .` | 현재 폴더를 윈도우 파일 탐색기로 즉시 열기 |
| `ports [포트]` | 포트 점유 중인 프로세스(PID, 프로세스명) 즉시 확인 (`ports 3000`) |
| `-` | 직전 작업 디렉터리로 즉시 복귀 (`cd -`) |
| `..` / `...` / `....` | 1단계 / 2단계 / 3단계 상위 폴더로 초고속 탈출 |

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
* `gundo` : 직전 커밋 취소 (`git reset --soft HEAD~1`, 코드 보존)

### 3. 터미널 단축키
* `Ctrl + F` 또는 `→` : 회색 자동완성 추천 전체 수락
* `Ctrl + →` : 자동완성 한 단어씩 수락
* `Tab` : 선택형 메뉴 자동완성
* `F2` : 한 줄 고스트 텍스트 ↔ 드롭다운 목록형(ListView) 토글
* `Ctrl + R` : 내가 쳤던 명령어 실시간 FZF 퍼지 검색
* `Alt + Shift + D` : 화면 가로 분할
* `Ctrl + Shift + W` : 현재 분할 창 닫기

---

## 📁 저장소 구조

```text
dotfiles/
├── install.ps1                     # 원클릭 자동 설치 스크립트
├── powershell/
│   └── Microsoft.PowerShell_profile.ps1 # 파워셸 7 & 5.1 공용 프로필
├── starship/
│   └── starship.toml               # Starship 미니멀 프롬프트 설정
└── windows-terminal/
    └── settings.json               # 윈도우 터미널 테마, 폰트, 투명도 설정
```
