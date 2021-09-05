#!/bin/bash

mkdir APK
find . -type f -iname "*apk" -print0 | xargs -0 -I %  mv  %  APK

mkdir MP3
find . -type f -iname "*ogg" -print0 | xargs -0 -I %  mv  %  MP3/
find . -type f -iname "*mp3" -print0 | xargs -0 -I %  mv  %  MP3/
find . -type f -iname "*m4a" -print0 | xargs -0 -I %  mv  %  MP3/
mkdir Videos
find . -type f -iname "*webm" -print0 | xargs -0 -I %  mv  %  Videos
find . -type f -iname "*mp4" -print0 | xargs -0 -I %  mv  %  Videos
find . -type f -iname "*amr" -print0 | xargs -0 -I %  mv  %  Videos
find . -type f -iname "*mkv" -print0 | xargs -0 -I %  mv  %  Videos

mkdir PDF
find . -type f -iname "*pdf" -print0 | xargs -0 -I %  mv  %  PDF
mkdir Pics
find . -type f -iname "*jpg" -print0 | xargs -0 -I %  mv  %  Pics
find . -type f -iname "*jpeg" -print0 | xargs -0 -I %  mv  %  Pics
find . -type f -iname "*png" -print0 | xargs -0 -I %  mv  %  Pics
exit 0

