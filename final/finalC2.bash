if [ ! ${#} -eq 2 ]; then
echo "Improper number of arguments"
exit;
fi

accessList=$1
iocList=$2

> report.txt

while IFS= read -r IOC; do

	grep "$IOC" "$accessList" | cut -d ' ' -f1,4,7 | tr -d '[' >> report.txt

done < "$iocList"
