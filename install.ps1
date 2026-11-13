# ========================================================
# 🚀 Dotfiles One-Click Installer for Windows & PowerShell 7
# ========================================================

$ErrorActionPreference = "Stop"

Write-Host "⚡ Installing Modern PowerShell & Windows Terminal Dotfiles..." -ForegroundColor Cyan

# 1. 폰트 디렉터리 및 D2Coding Nerd Font 설치
$fontsDir = "$env:LOCALAPPDATA\Microsoft\Windows\Fonts"
New-Item -ItemType Directory -Path $fontsDir -Force | Out-Null
$fontUrl = "https://github.com/ryanoasis/nerd-fonts/releases/download/v3.5.1/D2Coding.zip"
$tempZip = "$env:TEMP\D2Coding.zip"

Write-Host "📦 Installing D2Coding Nerd Font..." -ForegroundColor Yellow
Invoke-WebRequest -Uri $fontUrl -OutFile $tempZip
Expand-Archive -Path $tempZip -DestinationPath "$env:TEMP\D2Coding" -Force
Get-ChildItem -Path "$env:TEMP\D2Coding" -Filter "*.ttf" | ForEach-Object {
    Copy-Item $_.FullName -Destination $fontsDir -Force
    $regName = $_.Name.Replace(".ttf", " (TrueType)")
    Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows NT\CurrentVersion\Fonts" -Name $regName -Value $_.FullName -Force
}
Remove-Item $tempZip -Force -ErrorAction SilentlyContinue
Remove-Item "$env:TEMP\D2Coding" -Recurse -Force -ErrorAction SilentlyContinue

# 2. 필수 CLI 도구 설치 (winget)
Write-Host "🛠️ Installing CLI Tools (Starship, Zoxide, FZF, Bat, Eza, Fd)..." -ForegroundColor Yellow
winget install --id starship.starship -e --accept-source-agreements --accept-package-agreements --silent
winget install --id ajeetdsouza.zoxide -e --accept-source-agreements --accept-package-agreements --silent
winget install --id junegunn.fzf -e --accept-source-agreements --accept-package-agreements --silent
winget install --id sharkdp.bat -e --accept-source-agreements --accept-package-agreements --silent
winget install --id eza-community.eza -e --accept-source-agreements --accept-package-agreements --silent
winget install --id sharkdp.fd -e --accept-source-agreements --accept-package-agreements --silent

# 3. CompletionPredictor 파워셸 모듈 설치
Write-Host "🧠 Installing CompletionPredictor module..." -ForegroundColor Yellow
Install-Module -Name CompletionPredictor -Scope CurrentUser -Force -SkipPublisherCheck -ErrorAction SilentlyContinue

# 4. 설정 파일 복사
Write-Host "📝 Deploying Configuration Files..." -ForegroundColor Yellow

# (1) PowerShell 프로필 복사 (일반 문서 및 OneDrive 문서 둘 다 복사)
$profileTargets = @(
    "$HOME\Documents\PowerShell",
    "$HOME\OneDrive\Documents\PowerShell",
    "$HOME\Documents\WindowsPowerShell",
    "$HOME\OneDrive\Documents\WindowsPowerShell"
)
foreach ($target in $profileTargets) {
    if (Test-Path (Split-Path $target -Parent)) {
        New-Item -ItemType Directory -Path $target -Force | Out-Null
        Copy-Item "$PSScriptRoot\powershell\Microsoft.PowerShell_profile.ps1" -Destination "$target\Microsoft.PowerShell_profile.ps1" -Force
    }
}

# (2) Starship 설정 복사
$configDir = "$HOME\.config"
New-Item -ItemType Directory -Path $configDir -Force | Out-Null
Copy-Item "$PSScriptRoot\starship\starship.toml" -Destination "$configDir\starship.toml" -Force

# (3) Windows Terminal 설정 복사
$wtLocalState = "$env:LOCALAPPDATA\Packages\Microsoft.WindowsTerminal_8wekyb3d8bbwe\LocalState"
if (Test-Path $wtLocalState) {
    Copy-Item "$PSScriptRoot\windows-terminal\settings.json" -Destination "$wtLocalState\settings.json" -Force
}

Write-Host "✨ All Done! Restart your terminal to enjoy your new environment!" -ForegroundColor Green
