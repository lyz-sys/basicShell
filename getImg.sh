#!/bin/bash

read -p "Please enter the website URL:" URL

#echo $URL
if [ ! "$URL" ]
then
    echo "ERROR URL"
    exit
fi

html_name=$$.txt

curl "$URL" -s > "$html_name"

echo -e "\033[32m DOWNLOADING URL...\033[0m"

sed -i '' '/<img/!d' "$html_name"
sed -i '' 's/.*src="//' "$html_name"
sed -i '' 's/".*//' "$html_name"
#
echo
#
echo -e "\033[32m DOWNLOADING IMAGES...\033[0m"

for i in $(cat $html_name)
do
    wget -P ./img -q "$i" &
done

rm -r $html_name

wait
exit