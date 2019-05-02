#All Service Environments. As services interact and use values from ENV VAR, define them at one place uniquely to avoid any clobbering 

export SERVICE_VERSION_EF_GATEWAY=0.0.1
export SERVICE_NAME_EF_GATEWAY=ef_gateway

export SERVICE_VERSION_MQTT_KAFKA=0.0.1
export SERVICE_NAME_MQTT_KAFKA=mqtt_kafka

export SERVICE_VERSION_MQTT_BROKER=0.0.1
export SERVICE_NAME_MQTT_BROKER=mqtt_broker

export SERVICE_VERSION_I2C_OLED=0.0.1
export SERVICE_NAME_I2C_OLED=i2c_oled

export SERVICE_VERSION_BLE_SCAN=0.0.1
export SERVICE_NAME_BLE_SCAN=ble_central

export DOCKER_HUB_ID=edgedock

export MYDOMAIN=com.ibm.edge.example
export MYSERVICE=svc
export MYAPPLICATION=app

export PRIVATE_KEY_FILE=~/key/*-private.key
export PUBLIC_KEY_FILE=~/key/*-public.pem

export ARCH=`hzn node list | jq .configuration.architecture | sed 's/"//g'`
export HZN_EXCHANGE_USER_AUTH="$EXCHANGE_USER:$EXCHANGE_PW"

export EVENT_STREAM_ADMIN_URL="https://kafka-admin-prod02.messagehub.services.us-south.bluemix.net:443"
export EVENT_STREAM_BROKER_URL="kafka03-prod02.messagehub.services.us-south.bluemix.net:9093,kafka04-prod02.messagehub.services.us-south.bluemix.net:9093,kafka05-prod02.messagehub.services.us-south.bluemix.net:9093,kafka01-prod02.messagehub.services.us-south.bluemix.net:9093,kafka02-prod02.messagehub.services.us-south.bluemix.net:9093"

# There is normally no need for you to edit these variables
export EVENT_STREAM_EFG_TOPIC="$DOCKER_HUB_ID.$MYDOMAIN.message"
export HZN_ORGANIZATION=$HZN_ORG_ID
export EXCHANGE_NODEAUTH="$HZN_DEVICE_ID:$HZN_DEVICE_TOKEN"

# You only need to set this if you are running 'hzn dev' without the full edge fabric agent installed
export HZN_EXCHANGE_URL="https://alpha.edge-fabric.com/v1"

