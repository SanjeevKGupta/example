#!/bin/sh

socat TCP4-LISTEN:7777,fork EXEC:./display_service.sh

