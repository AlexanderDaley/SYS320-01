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
        $words = $logsNotFormatted[$i].Split(" ");

        $tableRecords += [pscustomobject]@{ "IP" = $words[0];
                                            "Time" = $words[3].Trim("[");
                                           "Method" = $words[4].Trim('"');
                                          "Page" = $words[5];
                                          "Protocol" = $words[6];
                                          "Response" = $words[7];
                                          "Referrer" = $words[8];
                                          "Client" = $words[11..($words.Count)];
                                          }
    }
    return $tableRecords | Where-Object {$_.IP -ilike "10.*"}
}
