#!/bin/bash

fn_chk_env() {
    ENV_VAR_ARR='HZN_ORG_ID HZN_EXCHANGE_USER_AUTH HZN_EXCHANGE_NODE_AUTH EVTSTREAMS_TOPIC EVTSTREAMS_API_KEY EVTSTREAMS_BROKER_URL'

    for ENV_NAME in $ENV_VAR_ARR; do
	if [[ -z "${!ENV_NAME}" ]]; then 
	    echo "Must set $ENV_NAME environment variable. "
	    exit 1
	fi
    done
}

fn_chk_env

echo "Setting NODE name..."
hzn exchange node create -n $HZN_EXCHANGE_NODE_AUTH
sleep 1

echo "Registering edge device..."
hzn register --pattern "IBM/pattern-ibm.cpu2evtstreams" --input-file user_input_stream.json --policy=node_policy_privileged.json
