#!/bin/bash

appId="***"
response_type="code"
scope="snsapi_base"
state=$2
echo "token: $token"
echo "url: $1"

function urlencode() {
  local length="${#1}"
  for ((i = 0; i < length; i++)); do
    local c="${1:i:1}"
    case $c in
    [a-zA-Z0-9.~_-]) printf "$c" ;;
    *) printf "$c" | xxd -p -c1 | while read x; do printf "%%%s" "$x"; done ;;
    esac
  done
}

token=$(cat token)
redirect_uri=$(urlencode $1)
echo "redirect_uri: $redirect_uri"

long_url="https://open.weixin.qq.com/connect/oauth2/authorize?appid=$appId&redirect_uri=$redirect_uri&response_type=$response_type&scope=$scope&state=$state#wechat_redirect"
echo "long_url: $long_url"

url="https://api.weixin.qq.com/cgi-bin/shorturl?access_token=$token"
body="{\"action\":\"long2short\", \"long_url\":\"$long_url\"}"

curl -d "$body" $url | jq -r '.short_url'
