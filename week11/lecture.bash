allLogs=""
file="/var/log/apache2/access.log"

function getAllLogs(){
	allLogs=$(cat "$file" | sort | uniq -c)
}

getAllLogs

echo "$allLogs"
