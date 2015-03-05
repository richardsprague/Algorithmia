__author__ = 'sprague'


from Algorithmia import *


#findNumber = input("What number would you like to factor?")


findNumber=197329798 # add one to get a prime number
factoring = Algorithmia(user="kenny",algo="factor")
factorResult = factoring.result(findNumber)
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