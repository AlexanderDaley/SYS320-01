if [ ! ${#} -eq 1 ]; then
echo "Improper number of args"
exit;
fi

report=$1

> report.html

echo -e "<html>\n<body>\n<table>\n" >> report.html

while IFS= read -r line; do

	echo -e "<tr>\n<td>" >> report.html
	sed 's/ /</tr>\n<td>' line >> report.html
	echo -e "</td>\n</tr>\n" >> report.html

done < "$report"

mv report.html /var/www/html
