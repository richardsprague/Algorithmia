//
//  ALGConnection.m
//  AlgorithmiaBrowser
//
//  Created by Richard Sprague on 3/5/15.
//  Copyright (c) 2015 Richard Sprague. All rights reserved.
//

#import "ALGConnection.h"
#import "ALGConnectionProtocol.h"

NSString * const ALGAuthorization = @"3944281388ec41b5b922aadac79a2645";
NSString * const ALGUser = @"kenny";
NSString * const ALGAlgo = @"factor";
NSString * const ALGURL = @"http://api.algorithmia.com/api/kenny/factor";

@interface ALGConnection()<NSURLConnectionDelegate>

@property NSString *ALGAuthorization;

@end


@implementation ALGConnection

- (void) sendNumberToBeFactored:(NSString *)newData {
    
    NSURL *url  = [NSURL URLWithString:@"http://api.algorithmia.com/api/kenny/factor"];
                   
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[url standardizedURL]];
    
    
    
    [request setHTTPMethod:@"POST"];
    
 //   [request setValue:@"api.algorithmia.com" forHTTPHeaderField:@"Host"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [request setValue:@"3944281388ec41b5b922aadac79a2645" forHTTPHeaderField: @"Authorization"];
    
    NSString *postData = [[NSString alloc] initWithString:newData];
    
    
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
            
            
            [self.delegate didReceiveJSON:json];
            
        } else {
            NSLog(@"NSURLSession error response code = %ld",(long)[(NSHTTPURLResponse*)response statusCode]);
            
        }
    }];
    [dataTask resume];
    
}

@end
