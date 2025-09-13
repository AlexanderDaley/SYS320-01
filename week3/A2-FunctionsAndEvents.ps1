clear

function getLoginouts($days)
{
$loginouts = Get-EventLog system -Source Microsoft-Windows-Winlogon -After (Get-Date).AddDays(-$days)

$loginoutsTable = @()
for($i = 0; $i -lt $loginouts.Count; $i++)
{
    $event = ""
    if($loginouts[$i].InstanceId -eq 7001) {$event="Logon"}
    if($loginouts[$i].InstanceId -eq 7002) {$event="Logoff"}
    
    $user = $loginouts[$i].ReplacementStrings[1]
    $userObject = New-Object System.Security.Principal.SecurityIdentifier($user)
    $NTAccountObject = $userObject.Translate([System.Security.Principal.NTAccount])
    $username = $NTAccountObject.Value

    $loginoutsTable += [pscustomobject]@{"Time" = $loginouts[$i].TimeWritten;
                                           "Id" = $loginouts[$i].EventID;
                                        "Event" = $event;
                                         "User" = $username;}
}

return $loginoutsTable
}

function getStartstop($days)
{
$loginouts = Get-EventLog system -Source Microsoft-Windows-Kernel-Power -After (Get-Date).AddDays(-$days)

$loginoutsTable = @()
for($i = 0; $i -lt $loginouts.Count; $i++)
{
    $event = ""
    if($loginouts[$i].EventId -eq 172) {$event="Start Up"}
    if($loginouts[$i].EventId -eq 6006) {$event="Shut Down"}
    
    $user = $loginouts[$i].ReplacementStrings[1]

    $loginoutsTable += [pscustomobject]@{"Time" = $loginouts[$i].TimeWritten;
                                           "Id" = $loginouts[$i].EventID;
                                        "Event" = $event;
                                         "User" = $username;}
}

return $loginoutsTable
}

getLoginouts(24)
getStartstop(24)