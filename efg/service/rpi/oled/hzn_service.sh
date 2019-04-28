#Service dev

export SERVICE_VERSION=0.0.4

export ARCH=arm
export SERVICE_NAME=rpii2coled

#export HZN_PATTERN=IBM_efg_rpi_i2c_oled

export EVENT_STREAM_API_KEY="QfonJaAb9NVQSMqDq4qQYaZXnPBhOd74h3GoNn2oJFI5wBTI"
export EVENT_STREAM_ADMIN_URL="https://kafka-admin-prod02.messagehub.services.us-south.bluemix.net:443"
export EVENT_STREAM_BROKER_URL="kafka03-prod02.messagehub.services.us-south.bluemix.net:9093,kafka04-prod02.messagehub.services.us-south.bluemix.net:9093,kafka05-prod02.messagehub.services.us-south.bluemix.net:9093,kafka01-prod02.messagehub.services.us-south.bluemix.net:9093,kafka02-prod02.messagehub.services.us-south.bluemix.net:9093"

export MYDOMAIN=com.ibm.example.efg
export DOCKER_HUB_ID=edgedock

# There is normally no need for you to edit these variables
export HZN_ORGANIZATION=$HZN_ORG_ID
export EXCHANGE_NODEAUTH="$HZN_DEVICE_ID:$HZN_DEVICE_TOKEN"

# You only need to set this if you are running 'hzn dev' without the full edge fabric agent installed
export HZN_EXCHANGE_URL="https://alpha.edge-fabric.com/v1"

