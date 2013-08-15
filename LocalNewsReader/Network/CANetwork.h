//
//  CANetwork.h
//  ComeAlive
//
//  Created by PC242748 on 10/05/13.
//  Copyright (c) 2013 Cognizant. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <SystemConfiguration/SCNetworkReachability.h>
#import <netinet/in.h>



@interface CANetwork : NSObject {

}

/*returns network status*/
+(BOOL)networkAvailbility;

/*setup Reachability callback*/
+(void)startListening;

/*Determines network status*/
+(BOOL)connectedToNetwork;

/*returns error status*/
+(BOOL)getErrorStatus;

@end
