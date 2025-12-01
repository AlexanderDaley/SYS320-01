allLogs=""
file="/var/log/apache2/access.log"

function getAllLogs(){
	allLogs=$(cat "$file" | sort | uniq -c)
}

function countingCurlAccess()
{
	allLogs=$(cat "$file" | sort | cut -d ' ' -f 1,2,12 | uniq -c)
}

countingCurlAccess

echo "$allLogs"
