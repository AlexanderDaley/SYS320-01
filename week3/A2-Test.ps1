. (Join-Path $PSScriptRoot A2-FunctionsAndEvents.ps1)

clear

$loginsTable = getLoginouts(24)
$loginsTable

$powerTable = getStartstop(24)
$powerTable