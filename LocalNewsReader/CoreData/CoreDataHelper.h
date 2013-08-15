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

-(void)deleteObject:(NSManagedObjectID*)oId ;

+ (CoreDataHelper *)sharedInstance;

@end
