#!/bin/bash

curl -sSL https://raw.githubusercontent.com/bmrz2019/public/master/es1/list_of_all_youtube_subscriptions  -o /tmp/list_of_all_youtube_subscriptions
auth_key='yaABCDEFGHIJKLMNOPQRSTUVWXYZ'
# get it at https://developers.google.com/oauthplayground

function do_subscribe () {
echo $1
sleep 1

curl --request POST \
  "https://youtube.googleapis.com/youtube/v3/subscriptions?part=snippet" \
  --header "Authorization: Bearer $auth_key" \
  --header "Accept: application/json" \
  --header "Content-Type: application/json" \
  --data '{'snippet':{"resourceId":{"kind":"youtube#channel","channelId":"'${1}'"}}}' \
  --compressed -S  --show-error

}

for i in `cat /tmp/list_of_all_youtube_subscriptions | shuf`
do
  echo $i
  do_subscribe $i
done
exit 0

