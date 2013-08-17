//
//  Articles.h
//  LocalNewsReader
//
//  Created by Admin on 8/18/13.
//  Copyright (c) 2013 Satheeshwaran. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Feed;

@interface Article : NSManagedObject

@property (nonatomic, retain) NSDate * articleAddedDate;
@property (nonatomic, retain) NSString * articleDescription;
@property (nonatomic, retain) NSString * articleImageURL;
@property (nonatomic, retain) NSString * articleLocalImageURL;
@property (nonatomic, retain) NSString * articleName;
@property (nonatomic, retain) NSString * articlePublishedDate;
@property (nonatomic, retain) NSString * articleSource;
@property (nonatomic, retain) NSString * articleURL;
@property (nonatomic, retain) Feed *articlesFeed;

@end
