//
//  CoreDataHelper.m
//  LocalNewsReader
//
//  Created by Satheeshwaran on 6/12/13.
//  Copyright (c) 2013 Satheeshwaran. All rights reserved.
//

#import "CoreDataHelper.h"
#import "AppDelegate.h"

@implementation CoreDataHelper

@synthesize managedObjectContext = __managedObjectContext;
@synthesize managedObjectModel = __managedObjectModel;
@synthesize persistentStoreCoordinator = __persistentStoreCoordinator;


static CoreDataHelper *sharedCoreDataHelper = nil;

#pragma mark - Core Data stack

+(CoreDataHelper *)sharedInstance
{
    @synchronized(self){
		if(sharedCoreDataHelper == nil){
            sharedCoreDataHelper = [[self alloc] init];
            
        }
    }
	return sharedCoreDataHelper;
}



// We can still have a regular init method, that will get called the first time the Singleton is used.
- (id)init
{
    self = [super init];
    
    if (self) {
        
    }
    
    return self;
}



// Returns the managed object context for the application.
// If the context doesn't already exist, it is created and bound to the persistent store coordinator for the application.
- (NSManagedObjectContext *)managedObjectContext
{
    if (__managedObjectContext != nil) {
        return __managedObjectContext;
    }
    
    NSPersistentStoreCoordinator *coordinator = [self persistentStoreCoordinator];
    if (coordinator != nil) {
        __managedObjectContext = [[NSManagedObjectContext alloc] init];
        [__managedObjectContext setPersistentStoreCoordinator:coordinator];
    }
    return __managedObjectContext;
}

// Returns the managed object model for the application.
// If the model doesn't already exist, it is created from the application's model.
- (NSManagedObjectModel *)managedObjectModel
{
    if (__managedObjectModel != nil) {
        return __managedObjectModel;
    }
    NSURL *modelURL = [[NSBundle mainBundle] URLForResource:@"LocalNewsReader" withExtension:@"momd"];
    __managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
    return __managedObjectModel;
}

// Returns the persistent store coordinator for the application.
// If the coordinator doesn't already exist, it is created and the application's store added to it.
- (NSPersistentStoreCoordinator *)persistentStoreCoordinator
{
    if (__persistentStoreCoordinator != nil) {
        return __persistentStoreCoordinator;
    }
    
    NSURL *storeURL = [[self applicationDocumentsDirectoryForCoreData] URLByAppendingPathComponent:@"LocalNewsReader.sqlite"];
    
    NSError *error = nil;
    __persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:[self managedObjectModel]];
    if (![__persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:nil error:&error])
    {
        
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }
    
    return __persistentStoreCoordinator;
}

#pragma mark -
#pragma mark Retrieve objects

// Fetch objects with a predicate
- (NSMutableArray *)searchObjectsForEntity:(NSString*)entityName withPredicate:(NSPredicate *)predicate andSortKey:(NSString*)sortKey andSortAscending:(BOOL)sortAscending andContext:(NSManagedObjectContext *)managedObjectContext
{
	// Create fetch request
	NSFetchRequest *request = [[NSFetchRequest alloc] init];
	NSEntityDescription *entity = [NSEntityDescription entityForName:entityName inManagedObjectContext:managedObjectContext];
	[request setEntity:entity];
    
	// If a predicate was specified then use it in the request
	if (predicate != nil)
		[request setPredicate:predicate];
    
	// If a sort key was passed then use it in the request
	if (sortKey != nil) {
		NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:sortKey ascending:sortAscending];
		NSArray *sortDescriptors = [[NSArray alloc] initWithObjects:sortDescriptor, nil];
		[request setSortDescriptors:sortDescriptors];
	}
    
	// Execute the fetch request
	NSError *error = nil;
	NSMutableArray *mutableFetchResults = [[managedObjectContext executeFetchRequest:request error:&error] mutableCopy];
    
	// If the returned array was nil then there was an error
	if (mutableFetchResults == nil)
		NSLog(@"Couldn't get objects for entity %@", entityName);
    
	// Return the results
	return mutableFetchResults;
}

// Fetch objects without a predicate
- (NSMutableArray *)getObjectsForEntity:(NSString*)entityName withSortKey:(NSString*)sortKey andSortAscending:(BOOL)sortAscending andContext:(NSManagedObjectContext *)managedObjectContext
{
	return [self searchObjectsForEntity:entityName withPredicate:nil andSortKey:sortKey andSortAscending:sortAscending andContext:managedObjectContext];
}

#pragma mark -
#pragma mark Count objects

// Get a count for an entity with a predicate
-(NSUInteger)countForEntity:(NSString *)entityName withPredicate:(NSPredicate *)predicate andContext:(NSManagedObjectContext *)managedObjectContext
{
	// Create fetch request
	NSFetchRequest *request = [[NSFetchRequest alloc] init];
	NSEntityDescription *entity = [NSEntityDescription entityForName:entityName inManagedObjectContext:managedObjectContext];
	[request setEntity:entity];
	[request setIncludesPropertyValues:NO];
    
	// If a predicate was specified then use it in the request
	if (predicate != nil)
		[request setPredicate:predicate];
    
	// Execute the count request
	NSError *error = nil;
	NSUInteger count = [managedObjectContext countForFetchRequest:request error:&error];
    
	// If the count returned NSNotFound there was an error
	if (count == NSNotFound)
		NSLog(@"Couldn't get count for entity %@", entityName);
    
	// Return the results
	return count;
}

// Get a count for an entity without a predicate
-(NSUInteger)countForEntity:(NSString *)entityName andContext:(NSManagedObjectContext *)managedObjectContext
{
	return [self countForEntity:entityName withPredicate:nil andContext:managedObjectContext];
}


- (void) deleteAllObjects: (NSString *) entityDescription ForContext:(NSManagedObjectContext *)context
{
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:entityDescription inManagedObjectContext:context];
    [fetchRequest setEntity:entity];
    
    NSError *error;
    NSArray *items = [context executeFetchRequest:fetchRequest error:&error];
    
    
    for (NSManagedObject *managedObject in items) {
    	[context deleteObject:managedObject];
    	NSLog(@"%@ object deleted",entityDescription);
    }
    if (![context save:&error]) {
    	NSLog(@"Error deleting %@ - error:%@",entityDescription,error);
    }
    
}


- (BOOL)resetDatastore
{
    [[self managedObjectContext] lock];
    [[self managedObjectContext] reset];
    NSPersistentStore *store = [[[self persistentStoreCoordinator] persistentStores] lastObject];
    BOOL resetOk = NO;
    
    if (store)
    {
        NSURL *storeUrl = store.URL;
        NSError *error;
        
        if ([[self persistentStoreCoordinator] removePersistentStore:store error:&error])
        {
            __persistentStoreCoordinator = nil;
            __managedObjectContext = nil;
            
            if (![[NSFileManager defaultManager] removeItemAtPath:storeUrl.path error:&error])
            {
                NSLog(@"\nresetDatastore. Error removing file of persistent store: %@",
                      [error localizedDescription]);
                resetOk = NO;
            }
            else
            {
                //now recreate persistent store
                [self persistentStoreCoordinator];
                [[self managedObjectContext] unlock];
                resetOk = YES;
            }
        }
        else
        {
            NSLog(@"\nresetDatastore. Error removing persistent store: %@",
                  [error localizedDescription]);
            resetOk = NO;
        }
        return resetOk;
    }
    else
    {
        NSLog(@"\nresetDatastore. Could not find the persistent store");
        return resetOk;
    }
}

#pragma mark - Core Data Helper Methods

// Returns the URL to the application's Documents directory.
- (NSURL *)applicationDocumentsDirectoryForCoreData
{
    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
}



/****************************************************************************************/
// This method checks for a previoulsy existing item in Core data DB for any entity.
/****************************************************************************************/

- (BOOL)checkAttributeWithAttributeName:(NSString *)attributeName InEntityWithEntityName:(NSString *)entityName ForPreviousItems:(NSString *)itemValue
{
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    fetchRequest.predicate=[NSPredicate predicateWithFormat:@"%K == %@",attributeName,itemValue];
    NSSortDescriptor *sortDescriptor=[NSSortDescriptor sortDescriptorWithKey:attributeName ascending:YES];
    fetchRequest.sortDescriptors=[NSArray arrayWithObject:sortDescriptor];
    
    NSEntityDescription *entity = [NSEntityDescription entityForName:entityName
                                              inManagedObjectContext:self.managedObjectContext];
    [fetchRequest setEntity:entity];
    
    NSArray *fetchedObjects = [self.managedObjectContext
                               executeFetchRequest:fetchRequest error:nil
                               ];
    if ([fetchedObjects count]>0) {
        return YES;
    }
    
    return NO;
}

- (void)deleteObject:(NSManagedObjectID*)oId {
    
    NSError *error;
    NSManagedObjectContext *context = [[CoreDataHelper sharedInstance] managedObjectContext];
    NSManagedObject *obj = [context existingObjectWithID:oId error:&error];
    [context deleteObject:obj];
    [context processPendingChanges];

    if (![context save:&error]) {
        NSLog(@"Couldn't Delete: %@", error);
    }
    
}

@end
