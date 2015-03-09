__author__ = 'sprague'
print("hello from Algorithmia")

import urllib.request
import urllib.parse

import json

#  a = Algorithmia('3944281388ec41b5b922aadac79a2645',user="kenny",algo="factor")
class Algorithmia:
    '''creates an instance that can call Algorithmia.com in the background
    '''
    def __init__(self, username= "sprague", authorization = '3944281388ec41b5b922aadac79a2645',user="kenny",algo="factor"):
        self.user = user
        self.algo = algo
        self.auth = authorization
        self.username = username
        self.url = "http://api.algorithmia.com/api/"+user+"/"+algo


    def result(self,data):
        headers = {'Content-Type': 'application/json',
           'Authorization': self.auth}
        jsonData = json.dumps(data)
        jsonData = jsonData.encode('utf-8')
        request = urllib.request.Request(url=self.url,data=jsonData,headers=headers)
        response = urllib.request.urlopen(request)
        return json.loads(response.read().decode())

    def makeCollection(self,collectionName):
        headers = {'Content-Type': 'application/json',
           'Authorization': self.auth}
        jsonData = json.dumps(collectionName).encode('utf-8')
        post = urllib.request.Request(url="https://api.algorithmia.com/data/"+self.username, data=jsonData,headers=headers)
        response = urllib.request.urlopen(post)
        return json.loads(response.read().decode())


    def addData(self,filename,collection):
        headers = {'Accept': 'application/json',
           'Authorization': self.auth}
        jsonData = json.dumps(collection).encode('utf-8')
        post = urllib.request.Request(url="https://api.algorithmia.com/data/"+self.username+"/"+collection, data=jsonData,headers=headers)

        response = urllib.request.urlopen(post)
        return json.loads(response.read().decode())



