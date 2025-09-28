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
                                    "Time Start" = $Times[0];
                                    "Time End" = $Times[1];
                                    "Instructor" = $tds[6].outerText;
                                    "Location" = $tds[9].outerText; }
}
$fullTable = daysTranslator $fullTable
return $fullTable
}

function daysTranslator($fullTable){
    for($i = 0; $i -lt $fullTable.length; $i++)
    {
        $days = @()
        if($fullTable[$i].Days -ilike "*M*"){$days += "Monday"}

        if($fullTable[$i].Days -ilike "*[T]*"){$days += "Tuesday"}
        ElseIf($fullTable[$i].Days -ilike "T"){$days += "Tuesday"}

        if($fullTable[$i].Days -ilike "*W*") {$days += "Wednesday"}

        if($fullTable[$i].Days -ilike "*TH*") {$days += "Thursday"}

        if($fullTable[$i].Days -ilike "*F*") {$days += "Friday"}

        $fullTable[$i].Days = $days
    }

    return $fullTable
}