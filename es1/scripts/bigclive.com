#!/bin/bash

ping -c 3 heise.de
if [ $? -eq 0 ]
then
echo "Ping success"
else
echo "No network. Exiting..."
exit 0
fi

mkdir BigClive
cd BigClive

#youtube-dl -f22 --dateafter=20161014 --max-downloads=10 --output "%(title)s.%(ext)s" --restrict-filenames https://www.youtube.com/user/bigclivedotcom/videos
youtube-dl -f18 --max-downloads=8 --output "%(title)s.%(ext)s" --restrict-filenames https://www.youtube.com/user/bigclivedotcom/videos
