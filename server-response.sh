#!/bin/bash
# 
# Url scanner 
# Author: Hrishikesh Mishra
 

#Configurations
SITEMAP_PATH='http://<server_url>/sitemap.txt'
SITEMAP_FILE='sitemap.txt'
REPONSE_FILE='reponsefile.txt' 
OUTPUT_FILE='output.csv'
STATUS_FILE='status.txt'
STARTDATE_TIME=`date`

echo "---------------- Started --------------------\n\n" > $STATUS_FILE 
echo "\nStarted At: $STARTDATE_TIME" >> $STATUS_FILE 

if curl --output /dev/null --silent --head --fail $SITEMAP_PATH 
then
    echo "\nSitemap url found, and start downloading.... "
    echo "\nSitemap url found, and start downloading...." >> $STATUS_FILE 

else
    echo "\nSitemap url not exist."
    echo "\nSitemap url not exist." >> $STATUS_FILE 
    exit 1 
fi

curl -o $SITEMAP_FILE $SITEMAP_PATH 

if [ -s "$SITEMAP_FILE" ]
then
    echo "\n$SITEMAP_FILE file downloaded.."
    echo "\n$SITEMAP_FILE file downloaded.." >> $STATUS_FILE
else
    echo "\n$SITEMAP_FILE file not downloaded."
    echo "\n$SITEMAP_FILE file not downloaded.." >> $STATUS_FILE 
    exit 
fi

echo "\n\nReading responses of urls. " 
echo "\\n\nReading responses of usrls." >> $STATUS_FILE 

echo "URL,SERVER_RESPONSE" >> $OUTPUT_FILE  

while read -r url  
do
    response=`curl --write-out %{http_code} --head --silent --output /dev/null $url`
    echo "$url,$response" >> $OUTPUT_FILE 
done < $SITEMAP_FILE;

ENDDATE_TIME=`date`
echo "\n\nCompleted. "
echo "\n\nOutput File : $OUTPUT_FILE"

echo "\nCompleted on $ENDDATE_TIME ." >> $STATUS_FILE 
echo "\nOutput File:  $OUTPUT_FILE" >> $STATUS_FILE 






