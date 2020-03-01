#!/bin/bash

token=$1
json="qrcode/QR_LIMIT_STR_SCENE"
# json="qrcode/QR_STR_SCENE"

url="https://api.weixin.qq.com/cgi-bin/qrcode/create?access_token=$token"

data=$(curl -d @$json.json -H 'Content-Type: application/json' $url)
echo $data

ticket=$(echo $data | jq -r '.ticket')

curl https://mp.weixin.qq.com/cgi-bin/showqrcode?ticket=$ticket -o qrcode.jpeg
