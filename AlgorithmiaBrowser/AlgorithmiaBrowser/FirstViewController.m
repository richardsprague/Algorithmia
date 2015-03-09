//
//  FirstViewController.m
//  AlgorithmiaBrowser
//
//  Created by Richard Sprague on 3/5/15.
//  Copyright (c) 2015 Richard Sprague. All rights reserved.
//

#import "FirstViewController.h"
#import "ALGConnection.h"
#import "ALGConnectionProtocol.h"

NSString * const algorithmiaPhotoImage = @"https://algorithmia.com/data/sprague/photos/img.jpg";

NSString * const rikPhotoURL = @"http://richardsprague.com/RikGreatWall2010.jpg";


@interface FirstViewController ()

@property (weak, nonatomic) IBOutlet UITextField *factorsDisplayHere;
@property (weak, nonatomic) IBOutlet UITextField *enterFactorHere;
@property (strong, nonatomic) NSString *resultsInTextField;

@property (weak, nonatomic) IBOutlet UIImageView *resultImageView;
@end

@implementation FirstViewController

- (IBAction)didPressFactor:(id)sender {
self.factorsDisplayHere.text = self.resultsInTextField;
    
    ALGConnection *connection = [[ALGConnection alloc] init];
    connection.delegate = self;
    
    [connection sendNumberToBeFactored:self.enterFactorHere.text];
    
}
- (IBAction)didEnterFactorText:(id)sender {
    
    [sender resignFirstResponder];
    

}

- (void) sendPhotoToAlgorithmia:(NSString *)newPhoto {
    
    NSURL *url  = [NSURL URLWithString:@"https://api.algorithmia.com/data/sprague/photos/newphoto.jpg"];
    
    NSURL *photoURL = [NSURL URLWithString:newPhoto];
    
    NSData *photoData = [NSData dataWithContentsOfURL:photoURL];
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[url standardizedURL]];
    
    
    
    [request setHTTPMethod:@"POST"];
    
    //   [request setValue:@"api.algorithmia.com" forHTTPHeaderField:@"Host"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    [request setValue:@"3944281388ec41b5b922aadac79a2645" forHTTPHeaderField: @"Authorization"];
    
    NSString *postData = [[NSString alloc] initWithData:photoData encoding:NSUTF8StringEncoding];
    
    // set the content-length
    NSString *postLength = [NSString stringWithFormat:@"%lu", (unsigned long)[photoData length]];
    [request setValue:postLength forHTTPHeaderField:@"Content-Length"];
    
    [request setHTTPBody:photoData];
    
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
            
            
            [self didReceiveJSONfromPhoto:json];
            
        } else {
            NSLog(@"NSURLSession error response code = %lu\n",(long)[(NSHTTPURLResponse*)response statusCode]);
            NSLog(@"Error Response = %@",[(NSHTTPURLResponse*)response allHeaderFields]);
            
        }
    }];
    [dataTask resume];
    
}

- (void) didReceiveJSONfromPhoto:(NSDictionary *)json
{
    NSString *msg = [json objectForKey:@"result"];
    if (!msg){
        NSLog(@"No JSON result returned to didReceiveJSON: %@",json);
        
        
    }
    else
        
    { NSDictionary *jsonResults = [json objectForKey:@"result"];
        NSLog(@"results = %@",jsonResults);
        self.resultsInTextField = [[NSString alloc] initWithFormat:@"[%@]",jsonResults];
        self.factorsDisplayHere.text = self.resultsInTextField;
    }
}

- (void) didReceiveJSON:(NSDictionary *)json
{
    NSString *msg = [json objectForKey:@"result"];
    if (!msg){
        NSLog(@"No JSON result returned to didReceiveJSON: %@",json);
        

    }
    else
        
    { NSDictionary *jsonResults = [json objectForKey:@"result"];
        NSLog(@"results = %@",jsonResults);
        self.resultsInTextField = [[NSString alloc] initWithFormat:@"[%@]",jsonResults];
        self.factorsDisplayHere.text = self.resultsInTextField;
    }
}

# pragma mark Image handling
- (UIImage *)createImagefromURLString: (NSString *) urlstring
{
    
    
    CGSize size = CGSizeMake(712, 650);
    
    UIGraphicsBeginImageContext(size);
    
    // Create a filled ellipse
    /*[color setFill];
    UIBezierPath *path = [UIBezierPath bezierPathWithOvalInRect:rect];
    [path fill];
     */
    
    
    UIImage *theImage =[UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:urlstring]]];
    
    
    UIGraphicsEndImageContext();
    
    return theImage;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    
    UIImage *newImage = [self createImagefromURLString:algorithmiaPhotoImage];
  
    [self sendPhotoToAlgorithmia:rikPhotoURL];
    self.resultImageView.image = newImage;

    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
