. (Join-Path $PSScriptRoot Apache-Logs.ps1)

clear

#$ips = getIPsVisited "index.html" '202' 'Chrome'
$ips = ApacheLogs1
$ips