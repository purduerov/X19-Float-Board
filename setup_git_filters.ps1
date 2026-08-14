<#
.SYNOPSIS
    Delegates Git clean filter setup to the central pcb-devops script.
#>

$cacheDir = Join-Path $PSScriptRoot ".pcb-devops-cache"

if (-not (Test-Path $cacheDir)) {
    Write-Host "Fetching central pcb-devops tooling..." -ForegroundColor Cyan
    git clone --depth 1 https://github.com/purduerov/pcb-devops.git $cacheDir
}

$setupScript = Join-Path $cacheDir "scripts\setup_git_filters.ps1"
& $setupScript
