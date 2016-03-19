#!/bin/sh
{
token='YOUR_KEY_HERE'
verbose=0
while getopts ":f:n:t:" opt; do
    case $opt in
    f)
	FILE=$OPTARG >&2
	;;
    n)
        NAME=$OPTARG >&2
        ;;
    t) 
	TYPE=$OPTARG >&2
        ;;
    esac
done
echo "Pushfile starting..."
echo "--------------------"
echo "Sending upload request..."
curl --silent --header 'Authorization: Bearer $token' -X POST https://api.pushbullet.com/v2/upload-request -d file_name=$(basename $FILE) -d file_type=$TYPE > temppush.temp
sleep 1
echo "Reading output of request..."
AWSACCESSKEYID=$(cat temppush.temp | jq -r '.data.awsaccesskeyid')
ACL=$(cat temppush.temp | jq -r '.data.acl')
KEY=$(cat temppush.temp | jq -r '.data.key')
SIGNATURE=$(cat temppush.temp | jq -r '.data.signature')
POLICY=$(cat temppush.temp | jq -r '.data.policy')
CONTENTTYPE=$(cat temppush.temp | jq -r '.data."content-type"')
echo "Uploading file..."
curl --silent -i -X POST $(cat temppush.temp | jq -r '.upload_url') \
  -F awsaccesskeyid=$AWSACCESSKEYID \
  -F acl=$ACL \
  -F key=$KEY \
  -F signature=$SIGNATURE \
  -F policy=$POLICY \
  -F content-type=$CONTENTTYPE \
  -F file=@$FILE
sleep 1
echo "Sending push message..."
curl --silent -u '$token': https://api.pushbullet.com/v2/pushes -d type=file -d file_name=$NAME -d file_type=$TYPE -d file_url=$(cat temppush.temp | jq -r '.file_url') > /dev/null
} > /dev/null
rm temppush.temp
#exit 0
