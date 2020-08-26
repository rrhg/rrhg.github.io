#!/bin/bash

# download youtube video to mp3 

url=$1

echo downloading $url
echo

downloadedfile=$(youtube-dl -x -o "%(title)s-%(id)s.%(ext)s" --audio-format mp3 $url)
#downloadedfile=$(youtube-dl -x --get-filename -o "%(title)s-%(id)s.%(ext)s" --audio-format mp3 $url)

echo 
echo downloadedfile $file
echo


