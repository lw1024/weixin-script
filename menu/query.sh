#!/bin/bash

token=$1
url="https://api.weixin.qq.com/cgi-bin/get_current_selfmenu_info?access_token=$token"

menu=$(curl $url)
echo $menu >menu.json
jq '{button:.selfmenu_info.button}' menu.json >newMenu.json
menu/decode.sh >newMenu.json
