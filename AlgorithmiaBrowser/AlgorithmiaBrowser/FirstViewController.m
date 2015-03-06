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

@interface FirstViewController ()

@property (weak, nonatomic) IBOutlet UITextField *factorsDisplayHere;
@property (weak, nonatomic) IBOutlet UITextField *enterFactorHere;
@property (strong, nonatomic) NSString *resultsInTextField;

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
    
    /*
    if ([sender isKindOfClass:[UITextField class]]){
        NSString *fieldString = self.enterFactorHere.text;
        NSScanner *myScanner = [NSScanner scannerWithString:fieldString];
        double myDouble;
        if ([myScanner scanDouble:&myDouble] & [myScanner isAtEnd]){
            
            NSLog(@"You entered %f but rest of location is %d",myDouble, (int)[myScanner scanLocation]);
        }
        else {NSLog(@"you entered a non-number %@",fieldString);}
        
        [sender resignFirstResponder];
    }
    
    else NSLog(@"not a class");
     */
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

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
