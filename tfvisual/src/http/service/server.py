from flask import Flask
from flask import request
import json
import os
import requests
import subprocess
import uuid

EVENTSTREAMS_BROKER_URLS = os.environ['EVENTSTREAMS_BROKER_URLS']
EVENTSTREAMS_API_KEY = os.environ['EVENTSTREAMS_API_KEY']
EVENTSTREAMS_ENHANCED_TOPIC = os.environ['EVENTSTREAMS_ENHANCED_TOPIC']

PUBLISH_KAFKA_COMMAND = ' kafkacat -P -b ' + EVENTSTREAMS_BROKER_URLS + ' -X api.version.request=true -X security.protocol=sasl_ssl -X sasl.mechanisms=PLAIN -X sasl.username=token -X sasl.password="' + EVENTSTREAMS_API_KEY + '" -t ' + EVENTSTREAMS_ENHANCED_TOPIC + ' '

server = Flask(__name__)

@server.route('/publish/kafka', methods=['POST'])
def publish_kafka():
    if request.headers['Content-Type'] == 'application/json':
        json_str = json.dumps(request.json)
        TMP_FILE = '/tmp/kafka-' + str(uuid.uuid4()) + '.json'
        with open(TMP_FILE, 'w+') as tmp_file:
            tmp_file.write(json_str)
            tmp_file.close()
            discard = subprocess.run(PUBLISH_KAFKA_COMMAND + TMP_FILE + '; rm ' + TMP_FILE, shell=True)
    return ""

if __name__ == '__main__':
    server.run(debug=False, host='0.0.0.0')
