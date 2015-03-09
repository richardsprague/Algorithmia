# Programming Algorithmia with iOS

The same easy Algorithmia API calls that are possible
with Python, Java, Scala, and others, is easy for iOS programming too.

This short lesson assumes you have a basic knowledge of iOS programming:
enough to write a simple single-view app using the Storyboard. To run
this example, all you need is a Mac and a copy of Apple's (free) Xcode development
environment. If you want to run your app on an iPhone or iPad, or if
you intend to ship your app in the iTunes App Store, you'll
also need a $100 subscription to Apple's developer program, but that
won't be necessary for this short example.

Fortunately, iOS already provides several powerful networking object classes that make it easy to POST http commands to the Algorithmia API:

```NSMutableURLRequest``` sets up the HTTP request with some straightforward and obvious methods, like ```setHTTPMethod:@"POST"``` to tell the server that you want to post some data.

```NSURLSession``` is a powerful class that lets you download the content via HTTP, including in the background or even while the application is suspended. Fortunately, the methods to control the download behavior are pretty straightforward.

```NSURLDataTask``` is a related class specifically for getting data via HTTP. Pass it an instance of ```NSURLSession```,  a ```NSMutableURLRequest``` and handler that describes what to do when it receives the a response from the server.

 Finally, ```NSJSONSerialization``` is a handy class that will convert between JSON and native iOS dictionary or array types. Read [Apple's class reference documentation](https://developer.apple.com/library/ios/documentation/Foundation/Reference/NSJSONSerialization_Class/index.html) to see how much work this will save you!

 ---
 # Example: POST a string to the Algorithmia API
 The best way to understand is with a simple example. The following method will send the NSString ```input``` to Algorithmia and call the method ```didReceiveJSON``` if the server replies with the answer.

```objc
- (void) sendInputToAlgorithmia:(NSString *)input {

    // create a url object for the API you want to call.
    NSURL *url  = [NSURL URLWithString:@"http://api.algorithmia.com/api/diego/isPrime"];

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
            self.AGResultsTextLabel.text = [[json objectForKey:@"result"] boolValue] ? @"Yes, prime" : @"No, not prime";

          //  [self didReceiveJSON:json];

        } else {
            NSLog(@"NSURLSession error response code = %ld",(long)[(NSHTTPURLResponse*)response statusCode]);

        }
    }];
    [dataTask resume];

}
```
That's it!  All the networking code you need to access the Algorithmia API is right there.
