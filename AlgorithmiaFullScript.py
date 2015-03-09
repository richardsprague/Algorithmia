__author__ = 'sprague'

from Algorithmia import *


factoring = Algorithmia(user="kenny",algo="factor")
factors = factoring.result(144)
print(factors)


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