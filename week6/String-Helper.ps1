<# String-Helper
*************************************************************
   This script contains functions that help with String/Match/Search
   operations. 
************************************************************* 
#>


<# ******************************************************
   Functions: Get Matching Lines
   Input:   1) Text with multiple lines  
            2) Keyword
   Output:  1) Array of lines that contain the keyword
********************************************************* #>
function getMatchingLines($contents, $lookline){

$allines = @()
$splitted =  $contents.split([Environment]::NewLine)

for($j=0; $j -lt $splitted.Count; $j++){  
 
   if($splitted[$j].Length -gt 0){  
        if($splitted[$j] -ilike $lookline){ $allines += $splitted[$j] }
   }

}

return $allines
}

function checkPassword($pwd)
{
    #check if password is 6 characters or more
    if($pwd.Length -lt 6)
    {
    Write-Host "Number issue" | Out-String
        return $False
    }
    #check if password contains a number
    if(-not ($pwd -match "\d"))
    {
    Write-Host "Digit character issue" | Out-String
        return $False
    }
    #check if password contains a capital letter
    if(-not ($pwd -cmatch '[A-Z]'))
    {
    Write-Host "Capital character issue" | Out-String
        return $False
    }
    #TODO check if password contains a special character
    if($pwd -notmatch "`[!@#$%^&*()-+={[}]|\:;,<.>/?]")
    {
    Write-Host "Special character issue" | Out-String
        return $False
    }

    return $True

}
