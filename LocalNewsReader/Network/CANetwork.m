//
//  CANetwork.h
//  ComeAlive
//
//  Created by PC242748 on 10/05/13.
//  Copyright (c) 2013 Cognizant. All rights reserved.
//

#import "CANetwork.h"

@interface NSURLRequest (ServiceClient)
@end

@implementation NSURLRequest(ServiceClient)

@end

@implementation CANetwork

BOOL isNetworkAvailable=YES;
BOOL firstNotification=NO;
BOOL errorStatusFlag=NO;

/*returns network status*/
+(BOOL)networkAvailbility
{
	return isNetworkAvailable;
}

/*returns error status*/
+(BOOL)getErrorStatus
{
	return errorStatusFlag;
}

static void ReachabilityCallback(SCNetworkReachabilityRef target, SCNetworkReachabilityFlags flags, void *info)
{
	NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];
	BOOL didRetrieveFlags = SCNetworkReachabilityGetFlags(target, &flags);
	if (!didRetrieveFlags) 
	{
		isNetworkAvailable=NO;
	}
	
	BOOL isReachable = flags & kSCNetworkFlagsReachable;
	BOOL needsConnection = flags & kSCNetworkFlagsConnectionRequired;
	
	if(((isReachable && !needsConnection) ? YES : NO))
	{
		@synchronized([CANetwork class])
		{
			isNetworkAvailable=YES;
		}		
	}
	else
	{
		isNetworkAvailable=NO;
	}

    [pool drain];
}

/*setup Reachability callback*/
+(void)startListening
{
	struct sockaddr_in zeroAddress;
	bzero(&zeroAddress, sizeof(zeroAddress));
	zeroAddress.sin_len = sizeof(zeroAddress);
	zeroAddress.sin_family = AF_INET;
	
	SCNetworkReachabilityRef defaultRouteReachability = SCNetworkReachabilityCreateWithAddress(NULL, (struct sockaddr *)&zeroAddress);       
	SCNetworkReachabilityContext    context = {0, self, NULL, NULL, NULL};
	SCNetworkReachabilitySetCallback(defaultRouteReachability, ReachabilityCallback, &context);       
	SCNetworkReachabilityScheduleWithRunLoop(defaultRouteReachability, [[NSRunLoop currentRunLoop]getCFRunLoop] , kCFRunLoopDefaultMode);
}

//login check
/*Determines network status*/
+ (BOOL) connectedToNetwork
{
	// Create zero addy
	struct sockaddr_in zeroAddress;
	bzero(&zeroAddress, sizeof(zeroAddress));
	zeroAddress.sin_len = sizeof(zeroAddress);
	zeroAddress.sin_family = AF_INET;
	
	// Recover reachability flags
	SCNetworkReachabilityRef defaultRouteReachability = SCNetworkReachabilityCreateWithAddress(NULL, (struct sockaddr *)&zeroAddress);	
	
	
	SCNetworkReachabilityFlags flags;
	
	BOOL didRetrieveFlags = SCNetworkReachabilityGetFlags(defaultRouteReachability, &flags);
	if (!didRetrieveFlags) 
	{
		CFRelease(defaultRouteReachability);
		return 0;
	}
	
	BOOL isReachable = flags & kSCNetworkFlagsReachable;
	BOOL needsConnection = flags & kSCNetworkFlagsConnectionRequired;
	CFRelease(defaultRouteReachability);
	if(((isReachable && !needsConnection) ? YES : NO))
	{
		isNetworkAvailable=YES;
	}
	else{
		isNetworkAvailable=NO;
	}
	
	return isNetworkAvailable;
}


@end
