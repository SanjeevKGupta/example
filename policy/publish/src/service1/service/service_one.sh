#!/bin/sh

getHostname() {
    hostname=$(cat /etc/hostname)
    echo $hostname
}

getService() {
    echo "Service One"
}


HOSTNAME=$(getHostname)
SERVICE=$(getService)

HEADERS="Content-Type: text/html; charset=ISO-8859-1"
BODY="{\"hostname\":\"${HOSTNAME}\",\"service\":\"${SERVICE}\"}"
HTTP="HTTP/1.1 200 OK\r\n${HEADERS}\r\n\r\n${BODY}\r\n"

# Emit the HTTP response
echo -en $HTTP
