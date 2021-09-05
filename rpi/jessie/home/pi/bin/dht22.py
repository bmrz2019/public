""" 
dht22.py 
Temperature/Humidity monitor using Raspberry Pi and DHT22. 
Data is displayed at thingspeak.com
Original author: Mahesh Venkitachalam at electronut.in 
Modified by Adam Garbo on December 1, 2016 
""" 
import sys 
import Adafruit_DHT

import urllib2 
myAPI = "AABBCCDDEEFF" 
baseURL = 'https://api.thingspeak.com/update?api_key=%s' % myAPI 

humidity, temperature = Adafruit_DHT.read_retry(22,22)
temperature = str(round(temperature, 1))
humidity = str(round(humidity, 1))
print humidity, temperature
f = urllib2.urlopen(baseURL + "&field1=%s&field2=%s" % (temperature, humidity)) 
#f = urllib2.urlopen(baseURL + "&field1=%s" % (temperature)) 
print f.read() 
f.close() 
