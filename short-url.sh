#!/bin/bash
# 参数顺序：appId scope state redirect_uri token

appId="" 
scope="snsapi_base" 
state=""
redirect_uri=""
token=""

if [ $# == 5 ]; then
  appId=$1 
  scope=$2
  state=$3
  redirect_uri=$4
  token=$5
elif [ $# == 4 ]; then
  appId=$1
  state=$2
  redirect_uri=$3
  token=$4
elif [ $# == 3 ]; then
  appId=$1
  redirect_uri=$2
  token=$3
else
  echo "参数个数错误！" 
  exit 1; 
fi

echo "参数如下："
echo "appId=$appId" 
echo "scope=$scope"
echo "state=$state"
echo "redirect_uri=$redirect_uri"
echo "token=$token"
echo "================================================"

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

response_type="code"
redirect_uri=$(urlencode $redirect_uri)
echo "redirect_uri: $redirect_uri"

long_url="https://open.weixin.qq.com/connect/oauth2/authorize?appid=$appId&redirect_uri=$redirect_uri&response_type=$response_type&scope=$scope&state=$state#wechat_redirect"
echo "long_url: $long_url"

url="https://api.weixin.qq.com/cgi-bin/shorturl?access_token=$token"
body="{\"action\":\"long2short\", \"long_url\":\"$long_url\"}"

curl -d "$body" $url | jq -r '.short_url'
