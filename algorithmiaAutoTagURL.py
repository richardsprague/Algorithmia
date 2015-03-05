__author__ = 'sprague'


import urllib.request
import urllib.parse

import json

testURL =  urllib.parse.quote_plus("https://raw.githubusercontent.com/mbernste/machine-learning/master/README.md")

url = "https://api.algorithmia.com/tags/AutoTagURL"


headers = {'Content-Type': 'application/json',
           'Authorization': '3944281388ec41b5b922aadac79a2645'}

data = json.dumps(testURL)
data = data.encode('utf-8')
request = urllib.request.Request(url=url,data=data,headers=headers)
response = urllib.request.urlopen(request)
ans = response.read()
ans = ans.decode()
j = json.loads(ans)