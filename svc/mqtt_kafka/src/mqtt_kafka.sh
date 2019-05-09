#!/bin/sh

mosquitto_sub -h mqtt_broker -t iot-2/type/+/id/+/evt/random/fmt/json | while read -r line
do
  if [ ! -z "$line" ]; then 
    d=$(echo "$line" | jq -r '.d')

    id=$(echo "$d" | jq -r '.id' )
    intensity=$(echo "$d"  | jq -r '.i' )

    epoch=$(date +%s)
    json='{"date":'$epoch',"id":"'$id'","light":'$intensity'}'

    echo "$json" 
    
    echo "$json" | kafkacat -P -b $EVENT_STREAM_BROKER_URL -X api.version.request=true -X security.protocol=sasl_ssl -X sasl.mechanisms=PLAIN -X sasl.username=${EVENT_STREAM_API_KEY:0:16} -X sasl.password=${EVENT_STREAM_API_KEY:16} -t "$EVENT_STREAM_EFG_TOPIC"
  fi
done

