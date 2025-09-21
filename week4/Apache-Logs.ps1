function getIPsVisited($pageName, $HTTPCode, $browserName) {
    $notFounds = Get-Content C:\xampp\apache\logs\access.log | Select-String $HTTPCode.ToString()
    $founds = $notFounds | Select-String $browserName.ToString()
    $page = $founds | Select-String $pageName.ToString()

    $regex = [regex] "\d{1,3}\.\d{1,3}\.\d{1,3}\.\d{1,3}"

    $ipsUnorganized = $regex.Matches($page)

    $ips = @()
    for($i=0; $i -lt $ipsUnorganized.Count; $i++)
    { 
       $ips += [pscustomobject]@{ "IP" = $ipsUnorganized[$i].Value;}
    }

    $ipCounts = $ips | Where-Object { $_.IP -ilike "10.*" }

    $counts = $ipCounts | Group-Object -Property IP
    $counts | Select-Object Count, Name
}

function ApacheLogs1(){
    $logsNotFormatted = Get-Content C:\xampp\apache\logs\access.log
    $tableRecords = @()

    for($i=0; $i -lt $logsNotFormatted.Length; $i++){
        $words = $logsNotFormatted[$i].Insert(" ");
        $tableRecords += [pscustomobject]@{ "IP" = $words[1];
                                            "Time" = $words[2].Trim("[");
                                           "Method" = $words[8].Trim('"');
                                          "Page" = $words[13];
                                          }
    }

}
