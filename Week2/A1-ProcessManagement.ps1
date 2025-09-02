clear
#P1
#Get-Process | Where-Object{ $_.ProcessName -ilike "C*" }

#P2
#Get-Process | Where-Object { $_.ProcessName -inotlike "*system32*" }

#P3
#Get-Service | Where-Object {$_.Status -eq "Stopped" } | Sort-Object

#P4
if(Get-Process -Name "A1-ProcessManagement" -ErrorAction SilentlyContinue)
{
    Write-Host "Exiting"
    Exit
}else{
    Start-Process chrome.exe -ArgumentList "--new-window https://www.champlain.edu"
    Write-Host "Tab Opened"
}
