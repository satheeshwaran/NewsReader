//
//  LNRNetwork.h
//
//  Created by PC242748 on 10/05/13.
//

#import <Foundation/Foundation.h>
#import <SystemConfiguration/SCNetworkReachability.h>
#import <netinet/in.h>



@interface LNRNetwork : NSObject {

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
