#!/bin/bash

# 获取Token的URL
url="http://localhost:9010/token"

info=$(curl $url)

#获取返回码
echo $info | jq -r '.token'