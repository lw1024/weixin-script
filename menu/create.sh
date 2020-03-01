#!/bin/bash

token=$1
url="https://api.weixin.qq.com/cgi-bin/menu/create?access_token=$token"

curl -d @newMenu.json -H 'Content-Type: application/json' $url
