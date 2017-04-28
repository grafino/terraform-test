#!/bin/sh

get_keys () {
   curl -X GET -H "Content-Type: application/json" -H "Authorization: Bearer $DIGITALOCEAN_TOKEN" "https://api.digitalocean.com/v2/account/keys" | python -m json.tool
}


# Setup a simple and fast menu for api info

while true
do

    echo "
              1 - List Images
              2 - List running Droplets
              3 - List ssh keys
            "

    read op

    case $op in
      1) echo dummy 1; sleep 1; clear;;
      2) echo dummy 2; sleep 1; clear;;
      3) get_keys; read dummy; clear;;
      *) echo wrong option; sleep 1; clear;;
    esac



done
