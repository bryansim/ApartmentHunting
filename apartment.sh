#!/bin/bash
echo -e "NEWPOST,TIME,DATE,PERCENTAGE" >> apartmentlog.csv 

while [ 1 ]
do
URL="http://newyork.craigslist.org/search/roo/mnh?query=village|soho|noho|bowery|nolita|lower&sale_date=-&minAsk=700&maxAsk=1400" # CHANGE THIS LINE
FILE="apartment.html" # AND THIS ONE
curl "http://newyork.craigslist.org/search/roo/mnh?query=village|soho|noho|bowery|nolita|lower&sale_date=-&minAsk=700&maxAsk=1400" > "apartment.html"

if [[ -e $FILE ]] ;then

PYTEST=$(python2 textsearch.py)
VAR=$PYTEST
if [[ $VAR -ne 0 ]]; then # -gt for greater than -lt for less then
echo "http://newyork.craigslist.org/search/roo/mnh?query=village|soho|noho|bowery|nolita|lower&sale_date=-&minAsk=700&maxAsk=1400" | mail -s "Apartment!" bryan.sim@nyu.edu
date +"Updated at %T %m-%d-%y"
date +"1,%T,%m-%d-%y" >> apartmentlog.csv
mv $FILE "$FILE.1"
else
date +"No change at %T %m-%d-%y"
date +"0,%T,%m-%d-%y" >> apartmentlog.csv 
mv $FILE "$FILE.1"
fi
else
mv $FILE "$FILE.1"
fi
sleep 60
done

