#!/bin/bash

## Installation: sudo bash -c "wget -P /usr/local/bin https://raw.github.com/gist/5721473/rpi-monitor.sh && chmod +x /usr/local/bin/rpi-monitor.sh"

echo() { :; } # comment line to enable debugging

apiKey=SOMETHINGHERE # ThingSpeak channel write API key, put your own

#freeram=$(free -m | awk '/Mem:/ { print $4 }')
#freeroot=$(df -BM | awk '/root/ { print substr($4, 1, length($4)-1) }')
#freependrive=$(df -BM | awk '/home/ { print substr($4, 1, length($4)-1) }')
temp=$(cat /sys/class/thermal/thermal_zone0/temp | awk '{ print $1/1000 }')
#processes=$(ps ax | wc -l | tr -d " ")
load=$(cat /proc/loadavg | awk '{ print $2 }')

#echo "## Raspberry Monitor -> ThingSpeak ##"
#echo "Temp: $temp C"
#echo "Load: $load"
#echo "Processes: $processes"
#echo "Free RAM: $freeram MB"
#echo "Free rootfs: $freeroot MB"
#echo "Free pendrive: $freependrive MB"

# Send values to ThingSpeak
update=$(curl --silent --request POST --header "X-THINGSPEAKAPIKEY: $apiKey" --data "field1=$load&field2=$temp" "https://api.thingspeak.com/update")

#echo "Update #$update"
