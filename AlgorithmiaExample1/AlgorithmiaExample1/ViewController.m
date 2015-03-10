//
//  ViewController.m
//  AlgorithmiaExample1
//
//  Created by Richard Sprague on 3/9/15.
//  Copyright (c) 2015 Richard Sprague. All rights reserved.
//

#import "ViewController.h"

NSString * const kALGAlgorithmURL = @"http://api.algorithmia.com/api/diego/isPrime";
NSString * const kALGAuthorizationID = @"3944281388ec41b5b922aadac79a2645";


@interface ViewController ()
@property (weak, nonatomic) IBOutlet UITextField *userInputTextField;

@property (weak, nonatomic) IBOutlet UILabel *AGResultsTextLabel;
@end

@implementation ViewController

- (IBAction)didPressPrime:(id)sender {
    self.AGResultsTextLabel.text = ![self.userInputTextField.text  isEqual:@""] ? self.userInputTextField.text : @"Maybe";
    [self sendInputToAlgorithmia:self.userInputTextField.text];
   
}

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

- (void) sendInputToAlgorithmia:(NSString *)input {
    
    NSURL *url  = [NSURL URLWithString:kALGAlgorithmURL];
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[url standardizedURL]];
    NSString *postData = [[NSString alloc] initWithString:input];
    
    self.AGResultsTextLabel.text = @"Checking with Algorithmia...";
    
    [request setHTTPMethod:@"POST"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
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
       //     self.AGResultsTextLabel.text = [[json objectForKey:@"result"] boolValue] ? @"Yes, prime" : @"No, not prime";
            
            [self processAlgorithmiaReply:json];
            
        } else {
            NSLog(@"NSURLSession error response code = %ld",(long)[(NSHTTPURLResponse*)response statusCode]);
            
        }
    }];
    [dataTask resume];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
