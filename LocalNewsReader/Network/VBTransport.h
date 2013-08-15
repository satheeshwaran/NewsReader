//
//  VBTransport.h
//  Vibe
//
//  Created by PC242748 on 18/07/13.
//  Copyright (c) 2013 Cognizant. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface VBTransport : NSObject

@property (nonatomic, copy) void (^completionHandler)(NSData *resData, int statusCode);

- (id)initWithURL:(NSURL *)url andWithDetails:(NSDictionary *)postData;
- (void)makeHTTPRequest;
- (void)makeHTTPPostRequest:(NSString *)body;

@end
