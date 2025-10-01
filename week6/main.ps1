. (Join-Path $PSScriptRoot Users.ps1)
. (Join-Path $PSScriptRoot Event-Logs.ps1)

clear

$Prompt = "`n"
$Prompt += "Please choose your operation:`n"
$Prompt += "1 - List Enabled Users`n"
$Prompt += "2 - List Disabled Users`n"
$Prompt += "3 - Create a User`n"
$Prompt += "4 - Remove a User`n"
$Prompt += "5 - Enable a User`n"
$Prompt += "6 - Disable a User`n"
$Prompt += "7 - Get Log-In Logs`n"
$Prompt += "8 - Get Failed Log-In Logs`n"
$Prompt += "9 - Get At-Risk Users`n"
$Prompt += "0 - Exit`n"



$operation = $true

while($operation){

    
    Write-Host $Prompt | Out-String
    $choice = Read-Host 


    if($choice -eq 0){
        Write-Host "Goodbye" | Out-String
        exit
        $operation = $false 
    }

    elseif($choice -eq 1){
        $enabledUsers = getEnabledUsers
        Write-Host ($enabledUsers | Format-Table | Out-String)
    }

    elseif($choice -eq 2){
        $notEnabledUsers = getNotEnabledUsers
        Write-Host ($notEnabledUsers | Format-Table | Out-String)
    }


    # Create a user
    elseif($choice -eq 3){ 

        $name = Read-Host -Prompt "Please enter the username for the new user"
        $password = Read-Host -AsSecureString -Prompt "Please enter the password for the new user"
        $bstr = [System.Runtime.InteropServices.Marshal]::SecureStringToBSTR($password)
        $plainPWD = [System.Runtime.InteropServices.Marshal]::PtrToStringAuto($bstr)
        
        If(checkUser $name)
        {
            Write-Host "User: $name is created." | Out-String
        }
        ElseIf(checkPassword $plainPWD)
        {
            Write-Host "Password must contain 1 special character, 1 number, 1 letter, and must be at least 6 characters long." | Out-String
        }
        Else
        {
            createAUser $name $password
        }

    }


    # Remove a user
    elseif($choice -eq 4){

        $name = Read-Host -Prompt "Please enter the username for the user to be removed"


        if(checkUser $name)
        {
            removeAUser $name

            Write-Host "User: $name Removed." | Out-String
        }
    }


    # Enable a user
    elseif($choice -eq 5){


        $name = Read-Host -Prompt "Please enter the username for the user to be enabled"


        if(checkUser $name)
        {
            enableAUser $name

            Write-Host "User: $name Enabled." | Out-String
        }
        
    }


    # Disable a user
    elseif($choice -eq 6){

        $name = Read-Host -Prompt "Please enter the username for the user to be disabled"


        if(checkUser $name)
        {
            disableAUser $name

            Write-Host "User: $name Disabled." | Out-String
        }
        
    }


    elseif($choice -eq 7){

        $name = Read-Host -Prompt "Please enter the username for the user logs"

        if(checkUser $name)
        {
            $days = Read-Host -Prompt "Please enter the max number of days to check user logs."
            $userLogins = getLogInAndOffs $days -as Double

            Write-Host ($userLogins | Where-Object { $_.User -ilike "*$name"} | Format-Table | Out-String)
        }

    }


    elseif($choice -eq 8){

        $name = Read-Host -Prompt "Please enter the username for the user's failed login logs"


        if(checkUser $name)
        {
            $days = Read-Host -Prompt "Please enter the max number of days to check failed logins."
            $userLogins = getFailedLogins $days -as Double

            Write-Host ($userLogins | Where-Object { $_.User -ilike "*$name"} | Format-Table | Out-String)
        }

        
    }

    elseif($choice -eq 9)
    {
        $days = Read-Host -Prompt "Please enter the max number of days you would check for at-risk users"
        $userLogins = getFailedLogins $days -as Double | Group-Object count, name
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
    
    else
    {
        Write-Host "Your input is not an option." | Out-String
    }

}
