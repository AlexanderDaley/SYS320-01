link="10.0.17.47/IOC.html"

fullPage=$(curl -sL "$link")

toolOutput=$(echo "$fullPage" | \
xmlstarlet format --html --recover 2>/dev/null | \
xmlstarlet select --template --copy-of \
"//html//body//table//tr")

echo "$toolOutput" | sed 's/<\/tr>/\n/g' | \
                     sed -e 's/&amp;//g' | \
                     sed -e 's/<tr>//g' | \
                     sed -e 's/<td[^>]*>//g' | \
                     sed -e 's/<\/td>/;/g' \
                      > webTable.txt

sed -n '6p;10p;14p;18p;22p;26p' webTable.txt | sed 's/\t//g' |  cut -d ';' -f1 > IOC.txt

