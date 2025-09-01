clear
#Q1
#Get-NetIPAddress | Where-Object { $_.InterfaceAlias -ilike "Ethernet" } | Select IPAddress

#Q2
#Get-NetIPAddress | Where-Object { $_.InterfaceAlias -ilike "Ethernet" } | Select-Object PrefixLength

#Q3/Q4
#Get-WmiObject -List | Where-Object { $_.Name -ilike "Win32_*" } | Sort-Object

#Q5/Q6
#Get-CimInstance Win32_NetworkAdapterConfiguration | Select DHCPServer

#Q7
#(Get-DnsClientServerAddress -AddressFamily IPv4 | Where-Object { $_.InterfaceAlias -ilike "Ethernet"}).ServerAddresses[0]

#Q8
#cd $PSScriptRoot
#$files=(Get-ChildItem -File)
#for($j = 0; $j -le $files.Length; $j++)
#{
#    if($files[$j].Name -ilike "*ps1")
#    {
#        Write-Host $files[$j].Name
#    }
#}

#Q9
#$folderPath = Join-Path $PSScriptRoot "outfolder"
#if(Test-Path -Path $folderPath)
#{
#    Write-Host "Folder already exists"
#}
#else
#{
#    New-Item -Path $folderPath -Name "outfolder" -ItemType Directory
#}

#Q10
#cd $PSScriptRoot
#$files = Get-ChildItem -File
#$FolderPath = "$PSScriptRoot/outfolder/"
#$FilePath = $FolderPath + "out.csv"
#$FileList = New-Object System.Collections.ArrayList
#for($j = 0; $j -le $files.Length; $j++)
#{
#    if($files[$j].Name -ilike "*ps1")
#    {
#        $FileList.Add($files[$j])
#    }
#}
#$FileList | Export-Csv -Path $FilePath

#Q11
$files = Get-ChildItem -Path $PSScriptRoot -Recurse -Include "*.csv" | Rename-Item -NewName { $_.Name -replace ".csv", ".log" }

