//
//  ALGConnection.h
//  AlgorithmiaBrowser
//
//  Created by Richard Sprague on 3/5/15.
//  Copyright (c) 2015 Richard Sprague. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ALGConnection: NSObject

- (void) sendNumberToBeFactored:(NSString *)newData ;

@property (strong, nonatomic) id delegate;


@end


