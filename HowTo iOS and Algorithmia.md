# Programming Algorithmia with iOS

The same easy Algorithmia API that works with
 Python, Java, Scala, and others, is easy for iOS programming too.

This short lesson assumes you have [a basic knowledge of iOS programming:
enough to write a simple single-view app using the Storyboard. (If not, start with [Apple's documentation here](https://developer.apple.com/library/ios/referencelibrary/GettingStarted/RoadMapiOS/)). To run
this example, all you need is a Mac and a copy of Apple's (free) Xcode development
environment. If you want to run your app on an iPhone or iPad, or if
you intend to ship your app in the iTunes App Store, you'll
also need a $100 subscription to Apple's developer program, but that
won't be necessary for this short example.

The Algorithmia API works through simple http POST commands. Fortunately, iOS already provides several powerful networking object classes that make that very easy:

* ```NSMutableURLRequest``` sets up the HTTP request with some straightforward and obvious methods, like ```setHTTPMethod:@"POST"``` to tell the server that you want to post some data.

* ```NSURLSession``` is a powerful class that lets you download the content via HTTP, including in the background or even while the application is suspended. Fortunately, the methods to control the download behavior are pretty straightforward.

* ```NSURLDataTask``` is a related class specifically for getting data via HTTP. Pass it an instance of ```NSURLSession```,  a ```NSMutableURLRequest``` and handler that describes what to do when it receives the a response from the server.

* Finally, ```NSJSONSerialization``` is a handy class that will convert between JSON and native iOS dictionary or array types. Read [Apple's class reference documentation](https://developer.apple.com/library/ios/documentation/Foundation/Reference/NSJSONSerialization_Class/index.html) to see how much work this will save you!

 ---
 # Example: POST a string to the Algorithmia API

 The best way to understand is with a simple example. Here's a short program to send a string representation of an integer to the Algorithmia ```isPrime``` API, to find whether an input number is prime or not.

 Here's the opening screen:
 ![isPrime Algorithmia Example](https://github.com/richardsprague/Algorithmia/blob/master/images/ScreenShotIsPrimeYes.png?raw=true)

 First a couple of housekeeping declarations. You'll need the URL for the algorithm you want to use, and a valid Algorithmia authorization ID (which you can find in your profile):

 ```objc

 NSString * const kALGAlgorithmURL = @"http://api.algorithmia.com/api/diego/isPrime";
NSString * const kALGAuthorizationID = @"<enter your Algorithmia Authorization ID here";

 ```
 Now for the most important method, the HTTP POST to Algorithmia's API.


  The following method will send the NSString ```input``` to Algorithmia and call the method ```processAlgorithmiaReply``` if the server replies with the answer.

```objc
- (void) sendInputToAlgorithmia:(NSString *)input {

    // create a url object for the API you want to call.
    NSURL *url  = [NSURL URLWithString:@kALGAlgorithmURL];

    // set up the http request object for that URL.
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[url standardizedURL]];
    NSString *postData = [[NSString alloc] initWithString:input];

    [request setHTTPMethod:@"POST"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];

    // be sure to substitute your own authorization string for kALGAuthorizationID
    [request setValue:kALGAuthorizationID forHTTPHeaderField: @"Authorization"];
    [request setHTTPBody:[postData dataUsingEncoding:NSUTF8StringEncoding]];

    NSURLSession *session = [NSURLSession sharedSession];

    //Prepare the data task
    NSURLSessionDataTask * dataTask = [session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        //This block will be executed on the main thread once the data task has completed
        //Status Code is HTTP 200 OK
        //You have to cast to NSHTTPURLResponse, a subclass of NSURLResponse, to get the status code
        if ([(NSHTTPURLResponse*)response statusCode] == 200) {
            NSDictionary * json = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
            //NSLog(@"%@", json);
            //The JSON is parsed into standard Cocoa classes such as NSArray, NSDictionary, NSString and NSNumber:
            NSLog(@"The result from Algorithmia was %@\n", json[@"result"]);

           // we have a valid reply, with valid JSON, so send it to the processing method
           [self processAlgorithmiaReply:json];

        } else {
            NSLog(@"NSURLSession error response code = %ld",(long)[(NSHTTPURLResponse*)response statusCode]);

        }
    }];
    [dataTask resume];

}
```
That's it!  All the networking code you need to access the Algorithmia API is right there.

 In a simple app like this one, you could substitute the call to ```processAlgorithmiaReply``` with inline code. Separating it like this just makes the the method shorter and easier to understand. Here's how to process that reply:

```objc
// When the Algorithmia server successfully replies, this method fires with the JSON returned.
- (void) processAlgorithmiaReply: (NSDictionary *) json {

    NSString *msg = [json objectForKey:@"result"];
    if (!msg){
        NSLog(@"No JSON result returned to didReceiveJSON: %@",json);
    }
    else

    { NSNumber *jsonResults = [json objectForKey:@"result"];
        NSLog(@"results = %@",jsonResults);

        bool resultP = [jsonResults boolValue];
        self.AGResultsTextLabel.text=@"not yet";

        self.AGResultsTextLabel.text = resultP ? @"Yes,it's prime" : @"No, not prime";
    }
}
```

In this case, we simply change the text in a label, but of course now that the JSON is a regular ```NSDictionary``` object, you can handle it any way you like.
