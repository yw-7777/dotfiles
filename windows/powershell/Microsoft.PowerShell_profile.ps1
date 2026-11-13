# ========================================================
# ⚡ Antigravity Ultimate Zsh-Power Developer Profile
# ========================================================

# 1. UTF-8 인코딩 기본 설정
[Console]::OutputEncoding = [System.Text.Encoding]::UTF8
$OutputEncoding           = [System.Text.Encoding]::UTF8

# 2. PSReadLine - Zsh 스타일 문법 하이라이팅 & IntelliSense
if ($Host.UI.RawUI) {
    try {
        # 마이크로소프트 공식 IntelliSense 예측 플러그인
        if (Get-Module -ListAvailable CompletionPredictor) {
            Import-Module CompletionPredictor -ErrorAction SilentlyContinue
            Set-PSReadLineOption -PredictionSource HistoryAndPlugin -ErrorAction SilentlyContinue
        } else {
            Set-PSReadLineOption -PredictionSource History -ErrorAction SilentlyContinue
        }

        # Zsh (zsh-syntax-highlighting) 시그니처 색상
        Set-PSReadLineOption -Colors @{
            Command            = 'Green'                           # 정상 명령어: 산뜻한 녹색 (Zsh 핵심)
            Parameter          = 'Cyan'                            # 옵션/플래그(-m, --help): 시안색
            Operator           = 'DarkGray'                        # 연산자(|, &&, >): 은은한 회색
            Variable           = 'Magenta'                         # 변수($var): 보라색
            String             = 'Yellow'                          # 문자열("message"): 노란색
            Number             = 'Magenta'                         # 숫자: 보라색
            Type               = 'DarkCyan'                        # 타입([string]): 청록색
            Comment            = 'DarkGray'                        # 주석(# comment): 어두운 회색
            Error              = 'Red'                             # 에러/오타: 빨간색
            InlinePrediction   = "$([char]0x1b)[38;5;244m"         # 자동완성 추천: 선명한 밝은 회색
        } -ErrorAction SilentlyContinue

        # 기본 인라인 예측 뷰
        Set-PSReadLineOption -PredictionViewStyle InlineView -ErrorAction SilentlyContinue

        # 단축키 매핑
        Set-PSReadLineKeyHandler -Key Tab -Function MenuComplete -ErrorAction SilentlyContinue
        Set-PSReadLineKeyHandler -Key UpArrow -Function HistorySearchBackward -ErrorAction SilentlyContinue
        Set-PSReadLineKeyHandler -Key DownArrow -Function HistorySearchForward -ErrorAction SilentlyContinue
        Set-PSReadLineKeyHandler -Key RightArrow -Function AcceptSuggestion -ErrorAction SilentlyContinue
        Set-PSReadLineKeyHandler -Chord 'Ctrl+f' -Function AcceptSuggestion -ErrorAction SilentlyContinue
        Set-PSReadLineKeyHandler -Chord 'Ctrl+RightArrow' -Function AcceptNextSuggestionWord -ErrorAction SilentlyContinue
    } catch {}
}

# 3. Starship 프롬프트 (초고속 캐싱)
$starshipCache = "$HOME\.config\starship_init.ps1"
if (Test-Path $starshipCache) {
    . $starshipCache
} elseif (Get-Command starship -ErrorAction SilentlyContinue) {
    Invoke-Expression (&starship init powershell --print-full-init | Out-String)
}

# 4. Zoxide 초고속 디렉터리 점프 ('z 폴더명')
$zoxideCache = "$HOME\.config\zoxide_init.ps1"
if (Test-Path $zoxideCache) {
    . $zoxideCache
} elseif (Get-Command zoxide -ErrorAction SilentlyContinue) {
    Invoke-Expression (&zoxide init powershell | Out-String)
}

# 5. FZF + fd 초고속 퍼지 검색 (Ctrl + r)
if (Get-Command fd -ErrorAction SilentlyContinue) {
    $env:FZF_DEFAULT_COMMAND = 'fd --type f --hidden --exclude .git'
}
if (Get-Command fzf -ErrorAction SilentlyContinue) {
    Set-PSReadLineKeyHandler -Chord 'Ctrl+r' -ScriptBlock {
        $histPath = (Get-PSReadLineOption).HistorySavePath
        if (Test-Path $histPath) {
            $cmd = Get-Content $histPath -ErrorAction SilentlyContinue | Select-Object -Unique | fzf --tac --no-sort
            if ($cmd) {
                [Microsoft.PowerShell.PSConsoleReadLine]::RevertLine()
                [Microsoft.PowerShell.PSConsoleReadLine]::Insert($cmd)
            }
        }
    }
}

# 6. eza (Rust 기반 초고속 파일 목록 + 아이콘 + Git 상태)
if (Get-Command eza -ErrorAction SilentlyContinue) {
    Remove-Item Alias:ls -Force -ErrorAction SilentlyContinue
    Remove-Item Alias:dir -Force -ErrorAction SilentlyContinue
    function ls { eza --icons=auto @args }
    function ll { eza --icons=auto -l --git --time-style=relative @args }
    function la { eza --icons=auto -la --git @args }
    function tree { eza --tree --icons=auto @args }
    Set-Alias -Name d -Value ls -Option AllScope -ErrorAction SilentlyContinue
} else {
    function ll { Get-ChildItem -Path $args }
    function la { Get-ChildItem -Force -Path $args }
    Set-Alias -Name d -Value Get-ChildItem -Option AllScope -ErrorAction SilentlyContinue
}

# 7. bat (문법 하이라이팅 지원 cat)
if (Get-Command bat -ErrorAction SilentlyContinue) {
    $env:BAT_THEME = "TwoDark"
    Set-Alias -Name cat -Value bat -Option AllScope -ErrorAction SilentlyContinue
}

# ========================================================
# 🚀 8. Oh-My-Zsh 시그니처 꿀기능 & 편의 함수
# ========================================================

# [1] take: 폴더 만들고 즉시 이동 (Zsh 최고 인기 기능)
function take ($dir) {
    if ($dir) {
        New-Item -ItemType Directory -Path $dir -Force | Out-Null
        Set-Location $dir
    }
}

# [2] open: Mac 스타일 탐색기 열기 (open . 치면 현재 폴더 열림)
function open ($path = '.') {
    Invoke-Item $path
}

# [3] ports: 현재 열려 있는 포트 / 프로세스 점유 실시간 확인 (개발 필수)
function ports ($port) {
    if ($port) {
        Get-NetTCPConnection -LocalPort $port -ErrorAction SilentlyContinue | Select-Object LocalAddress, LocalPort, State, OwningProcess, @{Name="ProcessName";Expression={(Get-Process -Id $_.OwningProcess -ErrorAction SilentlyContinue).ProcessName}}
    } else {
        Get-NetTCPConnection -State Listen -ErrorAction SilentlyContinue | Select-Object LocalAddress, LocalPort, OwningProcess, @{Name="ProcessName";Expression={(Get-Process -Id $_.OwningProcess -ErrorAction SilentlyContinue).ProcessName}} | Sort-Object LocalPort -Unique
    }
}

# [4] 디렉터리 초고속 이동 단축키
function .. { Set-Location .. }
function ... { Set-Location ../.. }
function .... { Set-Location ../../.. }
function - { Set-Location - }   # 직전 작업 디렉터리로 즉시 복귀

# [5] which: 명령어 바이너리 절대 경로 확인
function which ($name) { Get-Command $name -ErrorAction SilentlyContinue | Select-Object -ExpandProperty Source }

# [6] activate: 파이썬 가상환경 원클릭 활성화
function activate {
    if (Test-Path .venv\Scripts\Activate.ps1) { & .venv\Scripts\Activate.ps1 }
    elseif (Test-Path venv\Scripts\Activate.ps1) { & venv\Scripts\Activate.ps1 }
    else { Write-Host "No .venv or venv folder found." -ForegroundColor Yellow }
}

# ========================================================
# 🐙 9. Oh-My-Zsh Git 시그니처 단축키
# ========================================================
if (Get-Command git -ErrorAction SilentlyContinue) {
    Set-Alias -Name g -Value git -Option AllScope -ErrorAction SilentlyContinue
    function gs { git status }
    function gst { git status }
    function ga { git add @args }
    function gaa { git add --all }
    function gc { git commit -m "$args" }
    function gcm { git commit -m "$args" }
    function gcam { git commit -a -m "$args" }
    function gp { git push }
    function gpf { git push --force-with-lease }
    function gl { git pull }
    function gb { git branch }
    function gco { git checkout @args }
    function gcb { git checkout -b @args }
    function glog { git log --oneline --graph --decorate -n 15 }
    function gd { git diff @args }
    function gundo { git reset --soft HEAD~1 }   # 직전 커밋 취소 (작업 파일 보존)
}
