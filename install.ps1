# ========================================================
# 🚀 Windows Entry Point for Dotfiles Installer
# ========================================================

$localScript = if ($PSScriptRoot) { Join-Path $PSScriptRoot "windows\install.ps1" } else { "" }
if ($localScript -and (Test-Path $localScript)) {
    & $localScript
} else {
    irm "https://raw.githubusercontent.com/yw-7777/dotfiles/main/windows/install.ps1" | iex
}
