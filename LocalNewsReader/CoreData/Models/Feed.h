//
//  Feeds.h
//  LocalNewsReader
//
//  Created by Admin on 8/18/13.
//  Copyright (c) 2013 Satheeshwaran. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Article, Category;

@interface Feed : NSManagedObject

@property (nonatomic, retain) NSString * feedAddedDate;
@property (nonatomic, retain) NSString * feedID;
@property (nonatomic, retain) NSString * feedImageURL;
@property (nonatomic, retain) NSString * feedLocalImageURL;
@property (nonatomic, retain) NSString * feedName;
@property (nonatomic, retain) NSString * feedURL;
@property (nonatomic, retain) Category *feedCategory;
@property (nonatomic, retain) NSSet *feedArticles;
@end

@interface Feed (CoreDataGeneratedAccessors)

- (void)addFeedArticlesObject:(Article *)value;
- (void)removeFeedArticlesObject:(Article *)value;
- (void)addFeedArticles:(NSSet *)values;
- (void)removeFeedArticles:(NSSet *)values;

@end
