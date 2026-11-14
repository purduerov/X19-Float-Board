param(
    [string]$DsnFile = "$PSScriptRoot\X19-Float-Board.dsn",
    [string]$SesFile = "$PSScriptRoot\X19-Float-Board.ses",
    [switch]$Headless
)

$freerouting = "$env:LOCALAPPDATA\freerouting\freerouting.exe"
if (-not (Test-Path $freerouting)) {
    $cmd = Get-Command freerouting -ErrorAction SilentlyContinue
    if ($cmd) { $freerouting = $cmd.Source }
}

if (-not (Test-Path $freerouting)) {
    Write-Error "FreeRouting not found at $env:LOCALAPPDATA\freerouting\freerouting.exe or on PATH."
    exit 1
}

$argsList = @(
    "-de", $DsnFile,
    "-do", $SesFile,
    "--router.job_timeout=00:05:00",
    "--router.max_passes=10",
    "--router.optimizer.max_passes=3",
    "--router.optimizer.improvement_threshold=0.2"
)

if ($Headless) {
    $argsList += "--gui.enabled=false"
}

& $freerouting @argsList
