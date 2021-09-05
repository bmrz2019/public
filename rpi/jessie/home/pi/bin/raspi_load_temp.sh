#!/bin/bash

FAKE_API_KEY='5VCKBBEM2JIF6EPE'
LOAD_AVE=`cat /proc/loadavg | awk {'print $2'}`

#temp_CPU=`cat /proc/loadavg | awk {'print $3'}`

#pi@raspberrypi:~/scripts$ vcgencmd measure_temp
#temp=52.1'C
CPU_TEMP=
#pi@raspberrypi:~/scripts$ aa=`vcgencmd measure_temp | awk -F"=" '{print $2}' `
#pi@raspberrypi:~/scripts$ echo $aa
#52.1'C
#pi@raspberrypi:~/scripts$ echo "${aa%%.*}"

#GET_TEMP=`vcgencmd measure_temp | awk -F"=" '{print $2}'`
#TEMPERATURE=`echo "${GET_TEMP%%.*}"`

TEMPERATURE=`cat /sys/class/thermal/thermal_zone0/temp | cut -c1-2`

curl "https://api.thingspeak.com/update.json?api_key=$FAKE_API_KEY&field1=$LOAD_AVE&field2=$TEMPERATURE" > /dev/null 2>&1
