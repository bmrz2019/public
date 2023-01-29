#!/bin/bash

shopt -s globstar
cd ~/Downloads

for file in ./**/*.mp4; do
  echo "$file"
  dir="$(dirname "$file")"
  cd $dir
  #ls
  #read
  
IFS=$'\n' # Input Field Separator
for FILENAME_I in `ls *.mp4`
do
if [ -e $FILENAME_I ]; then
      echo "Input MP4 file exists"
      BASE=`basename $FILENAME_I mp4`
   else
      echo $FILENAME_I "File missing"
fi
echo $BASE
if [ -e $BASE"mkv" ]; then
      echo "mkv exists; skipping"
            # delete mp4 and subtitle file
            rm $BASE"mp4" $BASE"srt"
fi
if [ -e $BASE"srt" ]; then
            echo "Now creating mkv for " $BASE"mp4"
            mkvmerge -q -o $BASE"mkv" $BASE"mp4" $BASE"srt"
            touch -r $BASE"mp4" $BASE"mkv"
            sleep 4
            rm $BASE"mp4" $BASE"srt"
fi
if [ -e $BASE"en.srt" ]; then
            echo "Now creating mkv from .en.srt for " $BASE"mp4"
            mkvmerge -q -o $BASE"mkv" $BASE"mp4" $BASE"en.srt"
            touch -r $BASE"mp4" $BASE"mkv"
            sleep 4
            rm $BASE"mp4" $BASE"en.srt"
fi
done


  #cd ~/TV.Shows
  #BASE=`basename "$file" mp4`
  #echo "$BASE"
done
