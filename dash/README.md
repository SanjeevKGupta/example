## How to setup communicating containers on different edge devices

In this example one container running on an edge device **A** reads the CPU temperature and makes it available over REST API. Another container running on another edge device **B** queries the temp service REST API and makes it availble via display service REST APi. Display service API can be similarly queried by yet another container/edge device or via CLI.

This example works on RaspberryPi and can be modified to work on other architectures.

### Setup
- You will require at least two RPis 
- For this test, preferably configure the RPis with static IPs
- Clone the code on one RPi
- Make necessary changes in the services based on your HZN_ORG_ID and IP_ADDRESS of the devices
  - Modify value for HZN_ORG_ID in file hzn.json
  - Modify value for DOCKER_IMAGE_BASE in file hzn.json as per your docker repo.
  - Modify value for TEMP_URL in the file display/horizon/user.input.display.json as per the IP_ADDRESS of the RPI running temp service
- Build and publish the services using the Makefile for each service
- Publish the patterns using the Makefile for each service
- Register one RPi with patterrn-dash.temp
- Register another RPi with patten-dash.display

### Test from another device or a computer on same LAN

#### Test 1
    
    curl http://<IP_ADDRESS_OF_THE_FIRST_RPI>:8888/dash.temp
  
  You should see the CPU temperature value of the first RPI.
  
#### Test 2
  
    curl http://<IP_ADDRESS_OF_THE_SECOND_RPI>:7777/dash.display
  
  You should see the CPU temperature value of the **first** RPI, while performing the query on the second RPI


