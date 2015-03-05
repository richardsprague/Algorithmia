__author__ = 'sprague'


import urllib.request
import urllib.parse

import json


#  a = Algorithmia('3944281388ec41b5b922aadac79a2645',user="kenny",algo="factor")
class Algorithmia:
    '''creates an instance that can call Algorithmia.com in the background
    '''
    def __init__(self, authorization = '3944281388ec41b5b922aadac79a2645',user="kenny",algo="factor"):
        self.user = user
        self.algo = algo
        self.auth = authorization
        self.url = "http://api.algorithmia.com/api/"+user+"/"+algo

    def result(self,data):
        headers = {'Content-Type': 'application/json',
           'Authorization': self.auth}
        jsonData = json.dumps(data)
        jsonData = jsonData.encode('utf-8')
        request = urllib.request.Request(url=self.url,data=jsonData,headers=headers)
        response = urllib.request.urlopen(request)
        return json.loads(response.read().decode())







findNumber=197329799

#findNumber = input("What number would you like to factor?")
#
# a = Algorithmia()
#
# j = a.result(findNumber)
#
#
# print(j)
# print("factors for ",findNumber,"are:",j["result"])


findNumber=197329799
factoring = Algorithmia(user="kenny",algo="factor")
factorResult = factoring.result('197329798')
factors=factorResult["result"]
print("factors for ",findNumber,"are:",factorResult["result"])
for i in factors:
    print("Factor = ",i)



print("\n\nAutoTagGithub:")
githubUsername="richardsprague"

githubRepo = "ubiome"

githubList = [githubUsername, githubRepo]

g = Algorithmia(user="tags",algo="AutoTagGithub")

githubTags = g.result(githubList)['result']

for i,tag in enumerate(githubTags):
    print (tag, end=" ", flush=True)

for tag in githubTags:
    print (tag, end=" ")
print()

## Linear Regression

l = Algorithmia(user="dproberts",algo="LinearRegression")
points = [(1.0,2.0),(3.5,4.0),(5.0,6.0),(7.0,8.0)]
m = l.result(points)
print("\n\nLinear Regression:")
print(m)

## Hacker News Summary
bestOfHN = Algorithmia(user="sprague",algo="ScrapeHN2")
best = bestOfHN.result([])
print("\n\nHacker News BestOf:")
print(best)


# read Moby Dick and summarize
print("\n\nSummary of Moby Dick:")
with open ("MobyDick.txt", "r") as myfile:
    mobyDick=myfile.read().replace('\n', '')

summarizer = Algorithmia(user="nlp",algo="Summarizer")
summary = summarizer.result(mobyDick)

print(summary['result'])