#!/bin/bash



echo() { :; } # comment line to enable debugging


apiKey=REDACTED

usedram=$(free | grep Mem | awk '{print $3/$2 * 100.0}')

temp=$(cat /sys/class/thermal/thermal_zone0/temp | awk '{ print $1/1000 }')


load=$(cat /proc/loadavg | awk  '{ print $2*100/4}')



# Send values to ThingSpeak
update=$(curl --silent --request POST --header "X-THINGSPEAKAPIKEY: $apiKey" --data "field1=$load&field2=$temp&field6=$usedram" "https://api.thingspeak.com/update")

#echo "Update #$update"
