clear

$scrapedPage = Invoke-WebRequest -TimeoutSec 10 http://10.0.17.22/ToBeScraped.html

#$scrapedPage.Links.Count

#$scrapedPage.Links | select outerText, href

#$h2s = $scrapedPage.ParsedHtml.body.getElementsByTagName("h2") | select outerText
#$h2s

$div1 = $scrapedPage.ParsedHtml.body.getElementsByTagName("div") | where {
$_.getAttributeNode("class").Value -ilike "div1"} | select innerText

$div1
