//
//  CoreDataHelper.h
//  LocalNewsReader
//
//  Created by Satheeshwaran on 6/12/13.
//  Copyright (c) 2013 Satheeshwaran. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@interface CoreDataHelper : NSObject

//core data properties - used across the application.
@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;



- (BOOL)checkAttributeWithAttributeName:(NSString *)attributeName InEntityWithEntityName:(NSString *)entityName ForPreviousItems:(NSString *)itemValue;

- (NSUInteger)countForEntity:(NSString *)entityName andContext:(NSManagedObjectContext *)managedObjectContext;

- (NSUInteger)countForEntity:(NSString *)entityName withPredicate:(NSPredicate *)predicate andContext:(NSManagedObjectContext *)managedObjectContext;

- (NSMutableArray *)getObjectsForEntity:(NSString*)entityName withSortKey:(NSString*)sortKey andSortAscending:(BOOL)sortAscending andContext:(NSManagedObjectContext *)managedObjectContext;

- (NSMutableArray *)searchObjectsForEntity:(NSString*)entityName withPredicate:(NSPredicate *)predicate andSortKey:(NSString*)sortKey andSortAscending:(BOOL)sortAscending andContext:(NSManagedObjectContext *)managedObjectContext;

- (void)deleteObject:(NSManagedObjectID*)oId ;

+ (CoreDataHelper *)sharedInstance;

@end
