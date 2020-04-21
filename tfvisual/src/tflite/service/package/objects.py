from threading import Thread
import base64
import cv2
import importlib.util
import json
import numpy
import os
import time

class Config:
    def __init__(self, resolution=(640, 480), framerate=30):
        self.resolution = resolution
        self.framerate = framerate

    def getDeviceId(self):
        return os.environ['DEVICE_ID']
    
    def getDeviceName(self):
        return os.environ['DEVICE_NAME']
    
    def getPublishPayloadKafkaUrl(self):
        return os.environ['HTTP_PUBLISH_KAFKA_URL']

    def getMinConfidenceThreshold(self):
        return float(os.environ['MIN_CONFIDENCE_THRESHOLD'])

    def getResolution(self):
        return self.resolution

    def getFramerate(self):
        return self.framerate

    def getResolutionWidth(self):
        return self.resolution[0]

    def getResolutionHeight(self):
        return self.resolution[1]

    def getTool(self):
        return "OpenCV TensorFlow Lite"

    def getModelDir(self):
        return "model"

    def getModel(self):
        return "detect.tflite"

    def getLabelmap(self):
        return "labelmap.txt"

    def getCwd(self):
        return os.getcwd()

    def getModelPath(self):
        return os.path.join(self.getCwd(), self.getModelDir(), self.getModel())

    def getLabelmapPath(self):
        return os.path.join(self.getCwd(), self.getModelDir(), self.getLabelmap())

    def getInputMean(self):
        return 127.5

    def getInputStd(self):
        return 127.5

class Detector:
    def __init__(self, config):
        spec = importlib.util.find_spec('tflite_runtime')
        if spec:
            from tflite_runtime.interpreter import Interpreter
        else:
            from tensorflow.lite.python.interpreter import Interpreter

        #Fix label content
        with open(config.getLabelmapPath(), 'r') as f:
            self.labels = [line.strip() for line in f.readlines()]
        if self.labels[0] == '???':
            del(self.labels[0])

        self.inference_interval = 0
        self.interpreter = Interpreter(model_path=config.getModelPath())
        self.interpreter.allocate_tensors()

    def getLabels(self):
        return self.labels

    def infer(self, frame_normalized):
        t1 = time.time()
        self.interpreter.set_tensor(self.getInputDetailsIndex(), frame_normalized)
        self.interpreter.invoke()
        self.inference_interval = time.time() - t1
        return self.inference_interval

    def getInferenceInterval(self):
        return self.inference_interval

    def getInputDetailsIndex(self):
        return self.getInputDetails()[0]['index']

    def getInputDetails(self):
        return self.interpreter.get_input_details()

    def getOutputDetails(self):
        return self.interpreter.get_output_details()

    def getHeight(self):
        return self.getInputDetails()[0]['shape'][1]

    def getWidth(self):
        return self.getInputDetails()[0]['shape'][2]

    def getFloatingModel(self):
        return (self.getInputDetails()[0]['dtype'] == numpy.float32)

    def getResults(self):
        output_details = self.getOutputDetails()
        boxes = self.interpreter.get_tensor(output_details[0]['index'])[0]
        classes = self.interpreter.get_tensor(output_details[1]['index'])[0]
        scores = self.interpreter.get_tensor(output_details[2]['index'])[0]
        num = self.interpreter.get_tensor(output_details[3]['index'])[0]

        return boxes, classes, scores, num

    def getInferenceDataJSON(self, config, inference_interval, entities_dict, current_frame):
        entities = []
        for key in entities_dict:
            entity_dict = {}
            entity_dict["eclass"] = key
            entity_dict["details"] = entities_dict[key]
            entities.append(entity_dict)

        # Convert image into serialized base64 encoded string
        retval, buffer = cv2.imencode('.jpg', current_frame)
        infered_b64_frame = (base64.b64encode(buffer)).decode('utf8')

        # Create inference payload
        inference_dict = {}
        inference_dict['deviceid'] = config.getDeviceId()
        inference_dict['devicename'] = config.getDeviceName()
        inference_dict['tool'] = config.getTool()
        inference_dict['date'] = int(time.time())
        inference_dict['camtime'] = 0
        inference_dict['time'] = round(inference_interval, 3)
        inference_dict['count'] = len(entities)
        inference_dict['entities'] = entities
        inference_dict['image'] = infered_b64_frame

        inference_data = {}
        inference_data['detect'] = inference_dict
        inference_data_json = json.dumps(inference_data);

        return inference_data_json

class Opencv:
    def __init__(self):
        self.frame_rate  = 1 # seed value. Will get updated
        self.tickFrequency = cv2.getTickFrequency()
        self.t1 = cv2.getTickCount()
        
    def getFrameRate(self):
        return self.frame_rate

    def updateFrameRate(self):
        t2 = cv2.getTickCount()
        time1 = (t2 - self.t1)/self.tickFrequency
        self.frame_rate = 1/time1
    
    def getFrame(self, config, detector, videostream):
        self.t1 = cv2.getTickCount()
        frame_read = videostream.read()
        frame_current = frame_read.copy()
        frame_rgb = cv2.cvtColor(frame_current, cv2.COLOR_BGR2RGB)
        frame_resize = cv2.resize(frame_rgb, (detector.getWidth(), detector.getHeight()))

        # Condition and Normalize pixel values
        frame_norm = numpy.expand_dims(frame_resize, axis=0)
        if detector.getFloatingModel():
            frame_norm = (numpy.float32(frame_norm) - config.getInputMean()) / config.getInputStd()

        return frame_current, frame_norm

    def updateFrame(self, config, detector, opencv, frame_current, boxes, classes, scores, num):
        entities_dict = {}
        for i in range(len(scores)):
            if ((scores[i] > config.getMinConfidenceThreshold()) and (scores[i] <= 1.0)):
                
                imageH, imageW, _ = frame_current.shape

                # Get bounding box coordinates and draw box
                ymin = int(max(1, (boxes[i][0] * imageH)))
                xmin = int(max(1, (boxes[i][1] * imageW )))
                ymax = int(min(imageH, (boxes[i][2] * imageH)))
                xmax = int(min(imageW, (boxes[i][3] * imageW)))
                cv2.rectangle(frame_current, (xmin, ymin), (xmax, ymax), (10, 255, 0), 2)

                # Draw label
                object_name = detector.getLabels()[int(classes[i])]
                label = '%s: %d%%' % (object_name,  int(scores[i] * 100))
                labelSize, baseLine = cv2.getTextSize(label, cv2.FONT_HERSHEY_SIMPLEX, 0.6, 2)
                label_ymin = max(ymin, labelSize[1] + 8)
                cv2.rectangle(frame_current, (xmin, label_ymin - labelSize[1] - 10), (xmin + labelSize[0], label_ymin + baseLine - 10), (255, 255, 255), cv2.FILLED)
                cv2.putText(frame_current, label, (xmin, label_ymin-7), cv2.FONT_HERSHEY_SIMPLEX, 0.6, (0, 0, 0), 2)
            
                details = []
                if object_name in entities_dict:
                    details = entities_dict[object_name]
                else:
                    entities_dict[object_name] = details

                h = int(ymax-ymin)
                w = int(xmax-xmin)
                detail_dict = {}
                detail_dict['h'] = h 
                detail_dict['w'] = w
                detail_dict['cx'] = int(xmin + w/2)
                detail_dict['cy'] = int(ymin + h/2)
                detail_dict['confidence'] = float('{0:.2f}'.format(scores[i]))
                details.append(detail_dict)

        # Color BGR
        overlay = frame_current.copy()
        cv2.rectangle(overlay, (15, 10), (250, 110), (64, 64, 64), -1)
        alpha = 0.7
        cv2.addWeighted(overlay, alpha, frame_current, 1 - alpha, 0, frame_current)

        cv2.putText(frame_current, '{tool}'.format(tool = config.getTool()), (30, 30), cv2.FONT_HERSHEY_PLAIN, 1, (255, 255, 0), 2, cv2.LINE_AA)
        cv2.putText(frame_current, '{device_name}'.format(device_name = config.getDeviceName()), (30, 60), cv2.FONT_HERSHEY_PLAIN, 1, (255, 255, 0), 1, cv2.LINE_AA)
        cv2.putText(frame_current, 'Detection Time {0:.2f} sec'.format(detector.getInferenceInterval()), (30, 80), cv2.FONT_HERSHEY_PLAIN, 1, (255, 255, 0), 1, cv2.LINE_AA)
        cv2.putText(frame_current, 'Overall FPS {0:.2f}'.format(opencv.getFrameRate()), (30, 100), cv2.FONT_HERSHEY_PLAIN, 1, (255, 255, 0), 1, cv2.LINE_AA)

        return entities_dict 
        
class VideoStream:
    def __init__(self, config):
        self.stream = cv2.VideoCapture(0)
        ret = self.stream.set(cv2.CAP_PROP_FOURCC, cv2.VideoWriter_fourcc(*'MJPG'))
        ret = self.stream.set(3, config.getResolutionWidth())
        ret = self.stream.set(4, config.getResolutionHeight())

        (self.grabbed, self.frame) = self.stream.read()

        self.stopped = False

    def start(self):
        Thread(target=self.update, args=()).start()
        return self

    def stop(self):
        self.stopped = True

    def read(self):
        return self.frame

    def update(self):
        while True:
            if self.stopped:
                self.stream.release()
                return
            else:
                (self.grabbed, self.frame) = self.stream.read()




        
