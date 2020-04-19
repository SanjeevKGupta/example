#!/bin/bash
#
# edge device register unregister pattern policy
# #
#

usage() {                      
  echo "Usage: $0 -e -r -u -p -l"
  echo "where "
  echo "   -r register "
  echo "   -u unregister "
  echo "   -p pattern based deployment "
  echo "   -l policy based deployment "
}

fn_chk_env() {
    if [ -z $HZN_ORG_ID ]; then 
	echo "Must set HZN_ORG_ID in ENV file "
    fi

    if [ -z $HZN_EXCHANGE_USER_AUTH ]; then 
	echo "Must set HZN_EXCHANGE_USER_AUTH in ENV file "
    fi
}

fn_register_with_pattern() {
    echo "Registering with pattern... "

    . $envvar

    fn_chk_env

    ARCH=`hzn architecture`

    hzn exchange node create -n $HZN_EXCHANGE_NODE_AUTH
    hzn register --pattern "${HZN_ORG_ID}/pattern-${EDGE_OWNER}.${EDGE_DEPLOY}.tflite-${ARCH}" --input-file ../node/user-input-app.json --policy=../node/node_policy_privileged.json
}

fn_register_with_policy() {
    echo "Registering with policy... "

    . $envvar

    fn_chk_env

    hzn exchange node create -n $HZN_EXCHANGE_NODE_AUTH
    hzn register --policy=../node/node_policy_app.json --input-file ../node/user-input-app.json
}

fn_unregister() {
    echo "Un-registering... "

    . $envvar

    fn_chk_env

    hzn unregister -vrD
}

while getopts 'e:rupl' option; do
  case "$option" in
    h) usage
       exit 1
       ;;
    e) envvar=$OPTARG
       ;;
    r) register=1
       ;;
    u) unregister=1
       ;;
    p) pattern=1
       ;;
    l) policy=1
       ;;
    :) printf "missing argument for -%s\n" "$OPTARG" >&2
       usage
       exit 1
       ;;
    \?) printf "illegal option: -%s\n" "$OPTARG" >&2
       usage
       exit 1
       ;;
  esac
done
shift $((OPTIND - 1))

if [ -z $envvar ]; then
    echo ""
    echo "Must provide one of the options to set ENV vars ENV_HZN_DEV, ENV_HZN_DEMO etc"
    echo ""
    usage
    exit 1
fi

if [ ! -z $register ]; then
    if [ ! -z $pattern ]; then
	fn_register_with_pattern
    elif [ ! -z $policy ]; then
	fn_register_with_policy
    else
       echo "Must provide one of the options -p or -l"
       usage
       exit 1
    fi
elif [ ! -z $unregister ]; then
    fn_unregister
else
    echo "Must provide one of the options -r or -u"
    usage
    exit 1
fi


