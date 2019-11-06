#!/bin/bash

# 配置信息
appId="wx******"
secret="*****"

url="https://api.weixin.qq.com/cgi-bin/token?grant_type=client_credential&appid=$appId&secret=$secret"

function httpRequest() {
  #curl 请求
  info=$(curl $url)

  #获取返回码
  token=$(echo $info | jq -r '.access_token')

  echo $token >token

  #对响应码进行判断
  # if [ "$code" == "200" ]; then
  #   echo "请求成功，响应码是$code"
  # else
  #   echo "请求失败，响应码是$code"
  # fi
}

httpRequest
