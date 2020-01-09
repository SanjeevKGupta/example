#!/bin/sh

getHostname() {
    hostname=$(cat /etc/hostname)
    echo $hostname
}

getTemp() {
    temp=$(cat /sys/class/thermal/thermal_zone0/temp)
    echo $((temp/1000))
}

HOSTNAME=$(getHostname)
TEMP=$(getTemp)
HEADERS="Content-Type: text/html; charset=ISO-8859-1"
BODY="{\"hostname\":\"${HOSTNAME}\",\"temp\":${TEMP}}"
HTTP="HTTP/1.1 200 OK\r\n${HEADERS}\r\n\r\n${BODY}\r\n"

# Emit the HTTP response
echo -en $HTTP

