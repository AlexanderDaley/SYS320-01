function gatherClasses(){

$page = Invoke-WebRequest -TimeoutSec 2 http://10.0.17.22/Courses2025FA.html
$trs = $page.ParsedHtml.body.getElementsByTagName("tr")

$fullTable = @()

for($i = 1; $i -lt $trs.length; $i ++)
{
    $tds = $trs[$i].getElementsByTagName("td")

    $Times = $tds[5].innerText.Split("-")

    $fullTable += [pscustomobject]@{"Class Code" = $tds[0].outerText;
                                    "Title" = $tds[1].outerText;
                                    "Days" = $tds[4].outerText;
                                    "Time Start" = $Times[0].outerText;
                                    "Time End" = $Times[1].outerText;
                                    "Instructor" = $tds[6].outerText;
                                    "Location" = $tds[9].outerText; }
}
return $fullTable
}