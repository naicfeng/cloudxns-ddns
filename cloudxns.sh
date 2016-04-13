#!/bin/sh

CONFIG=$1

if [ ! -f "$CONFIG" ];then
    echo "ERROR, CONFIG NOT EXIST."
    exit 1
fi 

. $CONFIG

local agent="WeicnDdns/1.0(admin@weicn.org)"

URL_D="https://www.cloudxns.net/api2/ddns"
DATE=$(date)

DdnsCheck() {
	PARAM_BODY="{\"domain\":\"${1}\"}"
	if [ x."${2}" != "x." ]; then
		PARAM_BODY="{\"domain\":\"${2}.${1}\"}"
	fi
	echo $PARAM_BODY
	HMAC_U=$(echo -n "$API_KEY$URL_D$PARAM_BODY$DATE$SECRET_KEY"|md5sum|cut -d" " -f1)
	RESULT=$(curl -A $agent -k -s $URL_D --data $PARAM_BODY -H "API-KEY: $API_KEY" -H "API-REQUEST-DATE: $DATE" -H "API-HMAC: $HMAC_U" -H 'Content-Type: application/json')
	echo $RESULT

	if [ $(echo -n "$RESULT"|grep -o "message\":\"success\""|wc -l) = 1 ];then
	    echo "$(date) -- Update success"
	else
	    echo "$(date) -- Update failed"
	fi
}

DdnsCheck "weicn.org"
