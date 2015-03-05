# Python and Algorithmia
Many programmers are comfortable with the Python language as an environment for quick prototyping or exploration, but it can quickly run out of gas if you need an algorithm for some task you don't know how to do quickly yourself. Of course, you could try to find a pre-existing package that solves your problem, but integrating it into your code can be very time-consuming, even if you have all the source code. That's where Algorithmia can help.

I made a simple Python class wrapper that can call any Algorithmia algorithm and return the results back to my Python development environment in an easy-to-use, interactive way.

# Example: Python numbers
Let's say I need to factor some big numbers, but
I don't know how to write an efficient algorithm for that. There's probably an open-source package someplace, but finding and integrating it will take time and I don't really care to deal with all of that right now.

Fortunately, Algorithmia already has what I need right here:

https://algorithmia.com/algorithms/kenny/Factor

First, let's create an instance of the Python class ```Algorithmia```. To call the factor algorithm, I first note the username (```kenny```) and the algorithm name (```Factor```) identified on Algorithmia's site. In Python I type this:
```python
factoring = Algorithmia(user="kenny",algo="factor")
```
Now, the Python object instance ```factoring``` can seamlessly talk to the Algorithmia web site, like this:

```python
findNumber=197329798
factorResult = factoring.result(findNumber)
```
The new variable ```factorResult``` is a Python dictionary representation of the JSON returned by Algorithmia:
```
{'duration': 0.000317145, 'result': [2, 479, 205981]}
```
Since it's just an ordinary Python dictionary, I can do whatever I want with it.  For example:

```python
factors=factorResult["result"]
print("factors for ",findNumber,"are:",factorResult["result"])
for i,factor in enumerate(factors):
    print("Factor ",i+1, "= ",factor)
```
will print the following to the Python console:
```python
factors for  197329798 are: [2, 479, 205981]
Factor  1 =  2
Factor  2 =  479
Factor  3 =  205981
```
# Passing a Python list to Algorithmia

Let's try a slightly more complicated example. This time, I'd like to take advantage of [AutoTagGithub](https://algorithmia.com/algorithms/tags/AutoTagGithub), an algorithm that automatically generate appropriate topic tags from the README file on a [github](http://github.com) repository.

Again, the first step is to create an instance of my Python ```Algorithmia``` class:
```python

g = Algorithmia(user="tags",algo="AutoTagGithub")

```
and then I call that class instance with a Python list that represents the repository and username:
```python
githubUsername="richardsprague"
githubRepo = "ubiome"
githubList = [githubUsername, githubRepo]
githubTags = g.result(githubList)['result']

```
Now the Python variable ```githubTags``` contains the tags recommended by the algorithm. I can print it like this:
```python
for tag in githubTags:
    print (tag, end=" ")
print()
```
and here's the output:
``` python
output files source ubiome tools information samples data
```

# Passing a list of Python numbers
We could go on all day with these examples. Here's one that calculates a linear regression:
```python
l = Algorithmia(user="dproberts",algo="LinearRegression")
points = [(1.0,2.0),(3.5,4.0),(5.0,6.0),(7.0,8.0)]
m = l.result(points)
print("\n\nLinear Regression:")
print(m)

```
which gives me this dictionary:
```python
Linear Regression:
{'result': {'beta0': 0.8078175895765476, 'beta1': 1.01628664495114, 'r_squared': 0.9908794788273614}, 'duration': 0.057703148}

```
which of course I can handle like any other Python object.

# Passing a Python string
Finally, let's see how to pass a large string. In this case, I'll do something *really* large: pass the entire contents copy of the book [_Moby Dick_](http://www.gutenberg.org/ebooks/2701) to the Algorithmia [natural language processing Summarizer](https://algorithmia.com/algorithms/nlp/Summarizer):
```python
# Open the text file and convert it to one long string:
with open ("MobyDick.txt", "r") as myfile:
    mobyDick=myfile.read().replace('\n', '')
# Create the Algorithmia summarizer instance
summarizer = Algorithmia(user="nlp",algo="Summarizer")
summary = summarizer.result(mobyDick)

print(summary['result'])
```
Here's what we get:
```python
The Whale, by Herman Melville
Call me Ishmael. This is my substitute for pistol and ball. With a
philosophical flourish Cato throws himself upon his sword; I quietly
take to the ship.
```
Okay, we can argue about whether that's a good summary of the book or not, but you can't argue about the coolness of being able to do this so quiclky and easily!

# Summary
Python's interactive nature is designed for quick and easy exploration. Add that to the powerful, ever-expanding algorithms on Algorithmia and we have a fantastic new way to dramatically lower the bar for experimentation to every programmer.
