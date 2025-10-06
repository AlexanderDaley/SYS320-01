

clear

$Prompt = "`n"
$Prompt += "Please choose your operation:`n"
$Prompt += "1 - Read Current Configuration`n"
$Prompt += "2 - Change Configuration`n"
$Prompt += "3 - Exit`n"
$filePath = "C:\Users\champuser\SYS320-01\week7\configuration.txt"

function readConfiguration()
{
    $contents = @()
    Get-Content -Path $filePath | ForEach-Object{
        $contents += $_
    }
    $read = @()
    $read += [pscustomobject]@{"Days" = $contents[0];"ExecutionTime" = $contents[1]}
    return $read
}

function changeConfiguration()
{
    $numDays = Read-Host -Prompt "Please enter the number of days for which the logs will be obtained: "
    if($numDays -match "^\d+$")
    {
        $execTime = Read-Host -Prompt "Please enter the execution time for the script: "
        if($execTime -ilike "[0-9]:[0-9][0-9] [AP]M")
        {
            Clear-Content -Path $filePath
            $numDays | Out-File $filePath
            $execTime | Out-File $filePath -Append
        }
        else
        {
            Write-Host "ERROR: unknown format for time of day"
        }
    }
    else
    {
        Write-Host "ERROR: unknown format for number of days"
    }
}

function configurationMenu()
{
    $operation = $True
    while($operation)
    {
        Write-Host $Prompt | Out-String
        $choice = Read-Host
        if($choice -eq 1)
        {
            $settings = readConfiguration
            Write-Host($settings | Format-Table | Out-String)
        }
        elseif($choice -eq 2)
        {
            changeConfiguration
        }
        elseif($choice -eq 3)
        {
            $operation = $False
            Write-Host "Exiting Config Menu..." | Out-String
        }
        else
        {
            Write-Host "Improper input format" | Out-String
        }
    }
}

configurationMenu