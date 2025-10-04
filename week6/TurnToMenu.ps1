. (Join-Path $PSScriptRoot Users.ps1)
. (Join-Path $PSScriptRoot Event-Logs.ps1)
. (Join-Path $PSScriptRoot Apache-Logs.ps1)

clear

$Prompt = "`n"
$Prompt += "Please choose your operation: `n"
$Prompt += "1 - Display last 10 apache logs `n"
$Prompt += "2 - Display last 10 failed logins for all users `n"
$Prompt += "3 - Display at risk users `n"
$Prompt += "4 - Start champlain.edu web page `n"
$Prompt += "5 - Quit `n"

$operation = $true

while($operation)
{

    Write-Host $Prompt | Out-String
    $choice = Read-Host

    if($choice -eq 1)
    {
        $table = ApacheLogs1
        $table
    }
    elseIf($choice -eq 2)
    {
        $table = getFailedLogins 100000 | Group-Object count, name
        $i = [System.Math]::Max($table.Length - 11, 0)
        $finalTable = @()
        for($i; $i -lt $table.Length; $i++)
        {
            $finalTable += $table[$i]
        }
        $finalTable
    }
    elseIf($choice -eq 3)
    {
        $userLogins = getFailedLogins 100000 | Group-Object count, name
        $riskUsers = @()
        foreach($item in $userLogins)
        {
            if($item.count > 9)
            {
                $riskUsers += $item.name
            }
        }
        $riskUsers
    }
    elseIf($choice -eq 4)
    {
        if(Get-Process -Name "TurnToMenu" -ErrorAction SilentlyContinue)
        {
            Write-Host "Exiting"
            Exit
        }else{
            Start-Process chrome.exe -ArgumentList "--new-window https://www.champlain.edu"
            Write-Host "Tab Opened"
        }
    }
    elseIf($choice -eq 5)
    {
        $operation = $True
        Write-Host "Exiting" | Out-String
        Exit
    }
    else
    {
        Write-Host "Your input is not valid here" | Out-String
    }
}