//
//  ALGConnectionProtocol.h
//  AlgorithmiaBrowser
//
//  Created by Richard Sprague on 3/5/15.
//  Copyright (c) 2015 Richard Sprague. All rights reserved.
//

#ifndef AlgorithmiaBrowser_ALGConnectionProtocol_h
#define AlgorithmiaBrowser_ALGConnectionProtocol_h


#endif

#import <Foundation/Foundation.h>

#define ALGUSERNAME_KEY @"USERNAME"
#define ALGPASSWORD_KEY @"PASSWORD"
#define ALGACCESSTOKEN_KEY @"ACCESSTOKEN"
#define ALGCLIENTID_KEY @"CLIENTID"

typedef NS_ENUM(NSInteger, ALGReturnType) {
    ALGBuckets,                  // buckets
    ALGEvents                 // events
};

@protocol ALGConnectionProtocol <NSObject>

// You set up a connection.  If you implemenet this protocol, you'll get back some JSON from that connection.  That's all you know.
- (void)didReceiveJSON: (NSDictionary *)json;

@optional
- (id) ALGUserID;


@end