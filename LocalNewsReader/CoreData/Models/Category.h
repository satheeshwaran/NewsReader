//
//  Categories.h
//  LocalNewsReader
//
//  Created by Admin on 8/18/13.
//  Copyright (c) 2013 Satheeshwaran. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Feed;

@interface Category : NSManagedObject

@property (nonatomic, retain) NSDate * categoryAddedDate;
@property (nonatomic, retain) NSString * categoryID;
@property (nonatomic, retain) NSString * categoryName;
@property (nonatomic, retain) NSSet *categoryFeeds;
@end

@interface Category (CoreDataGeneratedAccessors)

- (void)addCategoryFeedsObject:(Feed *)value;
- (void)removeCategoryFeedsObject:(Feed *)value;
- (void)addCategoryFeeds:(NSSet *)values;
- (void)removeCategoryFeeds:(NSSet *)values;

@end
