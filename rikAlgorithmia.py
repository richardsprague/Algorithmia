__author__ = 'sprague'



from Algorithmia import *
import base64

ImageA = Algorithmia(user="opencv",algo="FaceDetection")

# photoDataCollection = ImageA.makeCollection("photos")
#
# with open("rikchild.png", "rb") as imageFile:
#     myImg = base64.b64encode(imageFile.read())
#     print(myImg[1:100])

data = "data://sprague/photos/rikchild.png"
facesDetectedResult = ImageA.result("data://sprague/photos/rikchild.png")

print(facesDetectedResult)
