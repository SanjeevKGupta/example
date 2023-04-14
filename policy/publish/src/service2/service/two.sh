#!/bin/sh

socat TCP4-LISTEN:8882,fork EXEC:./service_two.sh
