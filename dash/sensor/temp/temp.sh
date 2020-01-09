#!/bin/sh

socat TCP4-LISTEN:8888,fork EXEC:./temp_service.sh
