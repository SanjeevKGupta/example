#!/bin/sh

socat TCP4-LISTEN:8881,fork EXEC:./service_one.sh
