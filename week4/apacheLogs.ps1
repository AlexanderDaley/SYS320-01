clear
#list apache logs

#Get-Content C:\xampp\apache\logs\access.log -Tail 5

#Get-Content C:\xampp\apache\logs\access.log | Select-String ' 404 ',' 400 '

#Get-Content C:\xampp\apache\logs\access.log | Select-String ' 200 ' -NotMatch

#$all = Get-ChildItem C:\xampp\apache\logs\*.log | Select-String 'error'
#$all[-5..-1]

$notFounds = Get-Content C:\xampp\apache\logs\access.log | Select-String ' 404 '

$regex = [regex] "\d{1,3}\.\d{1,3}\.\d{1,3}\.\d{1,3}"

$ipsUnorganized = $regex.Matches($notFounds)

$ips = @()
for($i=0; $i -lt $ipsUnorganized.Count; $i++)
{ 
    $ips += [pscustomobject]@{ "IP" = $ipsUnorganized[$i].Value;}
}

$ipCounts = $ips | Where-Object { $_.IP -ilike "10.*" }

$counts = $ipCounts | Group-Object -Property IP
$counts | Select-Object Count, Name
