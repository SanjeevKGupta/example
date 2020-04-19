import requests

def inference_publish_kafka(url, inference_data_json):
    req = {}
    try:
        header = {"Content-type": "application/json", "Accept": "text/plain"} 
        req = requests.post(url, data=inference_data_json, headers=header)
    except:
        print ()

    return ""
