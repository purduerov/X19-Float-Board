<#
.SYNOPSIS
    Delegates hardware validation and linter checks to the central pcb-devops repository.
.DESCRIPTION
    Clones/pulls pcb-devops into .pcb-devops-cache and executes the central symbol library linter.
#>

$cacheDir = Join-Path $PSScriptRoot ".pcb-devops-cache"

if (-not (Test-Path $cacheDir)) {
    Write-Host "Fetching central pcb-devops tooling..." -ForegroundColor Cyan
    git clone --depth 1 https://github.com/purduerov/pcb-devops.git $cacheDir
} else {
    Write-Host "Updating central pcb-devops tooling..." -ForegroundColor Cyan
    git -C $cacheDir pull origin master --quiet
}

$linterScript = Join-Path $cacheDir "scripts\linter_validator.py"
$symFiles = Get-ChildItem -Path (Join-Path $PSScriptRoot "libs") -Filter "*.kicad_sym" -Recurse

if ($symFiles.Count -gt 0) {
    Write-Host "Running central KiCad Symbol Linter..." -ForegroundColor Yellow
    foreach ($file in $symFiles) {
        python $linterScript $file.FullName
    }
} else {
    Write-Host "No local .kicad_sym files found in libs/ directory." -ForegroundColor Green
}
