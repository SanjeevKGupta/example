import os
import time

from package import Config
from package import Detector
from package import Opencv
from package import VideoStream
from package import util

config = Config(resolution=(640, 480), framerate=30)
detector = Detector(config)
opencv = Opencv()
videostream = VideoStream(config).start()

time.sleep(1)

while True:
    # Get frame from the videostream
    current_frame, frame_normalized = opencv.getFrame(config, detector, videostream)

    # Perform the actual inferencing with the initilized detector . tflite
    inference_interval = detector.infer(frame_normalized)

    # Get results
    boxes, classes, scores, num = detector.getResults()
    
    # Annotate the frame with class boundaries
    entities_dict = opencv.updateFrame(config, detector, opencv, current_frame, boxes, classes, scores, num)
    
    # Get full payload in json
    inference_data_json = detector.getInferenceDataJSON(config, inference_interval, entities_dict, current_frame)

    # Publish the result to kafka event stream
    util.inference_publish_kafka(config.getPublishPayloadKafkaUrl(), inference_data_json)

    # Update framerate
    opencv.updateFrameRate()

# Clean up
videostream.stop()
