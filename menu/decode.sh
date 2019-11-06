#!/bin/bash

json=$(jq -r '.selfmenu_info.button' menu.json)
length=$(echo $json | jq -r '.|length')
arr=""

for ((i = 0; i < $length; i++)); do
  subButton=$(echo $json | jq -r .[$i].sub_button)
  if [ "$subButton" != "null" ]; then
    item=$(echo $json | jq "{name:.[$i].name,sub_button:.[$i].sub_button.list}")
    if [ "$arr" = "" ]; then
      arr=$item
    else
      arr=$arr","$item
    fi
  else
    item=$(echo $json | jq ".[$i]")
    if [ "$arr" = "" ]; then
      arr=$item
    else
      arr=$arr","$item
    fi
  fi
done

jq -n --argjson v "[$arr]" '{"button": $v}'
