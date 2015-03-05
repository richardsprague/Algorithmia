__author__ = 'sprague'

import urllib.request
import urllib.parse

import json

testString = "Rik"

url = "http://api.algorithmia.com/api/demo/Hello"


headers = {'Content-Type': 'application/json',
           'Authorization': '3944281388ec41b5b922aadac79a2645'}

data = json.dumps(testString)
data = data.encode('utf-8')
request = urllib.request.Request(url=url,data=data,headers=headers)
response = urllib.request.urlopen(request)
ans = response.read()
ans = ans.decode()
j = json.loads(ans)