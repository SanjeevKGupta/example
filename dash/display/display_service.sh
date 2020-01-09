#!/bin/sh

TEMP_JSON=$(curl -sS $TEMP_URL)
HEADERS="Content-Type: text/json; charset=ISO-8859-1"
BODY="\"display\":${TEMP_JSON}"
HTTP="HTTP/1.1 200 OK\r\n${HEADERS}\r\n\r\n${BODY}\r\n"


# Emit the HTTP response
echo -en $HTTP

