#!/bin/sh
{
token='YOUR_KEY_HERE'
verbose=0
while getopts ":m:t:" opt; do
    case $opt in
    m)
        MESSAGE=$OPTARG >&2
        ;;
    t)  TITLE=$OPTARG >&2
        ;;
    esac
done
curl -u "$token": https://api.pushbullet.com/v2/pushes -d type=note -d title="$TITLE" -d body="$MESSAGE" > /dev/null
} > /dev/null 2>&1
exit 0
