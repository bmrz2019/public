#!/bin/bash

IFS=$'\n' # Input Field Separator

#FILENAME_I=$1

for FILENAME_I in `ls *.mp4`
do
if [ -e $FILENAME_I ]; then
		echo "Input MP4 file exists"
	else
		echo $FILENAME_I "File missing"
fi	

BASE=`basename $FILENAME_I mp4`


#if [ -e $BASE"srt" ]; then
#      echo "Input SRT file exists"
#   else
#      echo $BASE"srt" "File missing"
#fi


if [ -e $BASE"mkv" ]; then
		echo "mkv exists; skipping"
				# delete mp4 and subtitle file
				# rm $BASE"mp4" $BASE"srt"
	else
			if [ -e $BASE"srt" ]; then
				echo "Now creating mkv"
				mkvmerge -q -o $BASE"mkv" $BASE"mp4" $BASE"srt"
			fi
fi
done

