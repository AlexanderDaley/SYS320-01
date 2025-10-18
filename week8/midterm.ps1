clear

#Part 1
function Part1()
{
$page = Invoke-WebRequest -TimeoutSec 10 http://10.0.17.47/IOC.html
$trs = $page.ParsedHtml.body.getElementsByTagName("tr")

$fullTable = @()

for($i = 1; $i -lt $trs.length; $i ++)
{
    $tds = $trs[$i].getElementsByTagName("td")

    $fullTable += [pscustomobject]@{"Pattern" = $tds[0].outerText;
                                    "Explanation" = $tds[1].outerText;}
}

return $fullTable
}

#Part1
############

#Part 2
function Part2()
{
    $logsNotFormatted = Get-Content C:\Users\champuser\SYS320-01\week8\access.log
    $tableRecords = @()

    for($i=0; $i -lt $logsNotFormatted.Length; $i++){
        $words = $logsNotFormatted[$i].Split(" ");

        $tableRecords += [pscustomobject]@{ "IP" = $words[0];
                                            "Time" = $words[3].Trim("[");
                                           "Method" = $words[5].Trim('"',']');
                                          "Page" = $words[6];
                                          "Protocol" = $words[7];
                                          "Response" = $words[8];
                                          "Referrer" = $words[10];
                                          }
    }
    return $tableRecords | Where-Object {$_.IP -ilike "10.*"} | Format-Table
}
#Part2
################

#Part 3
