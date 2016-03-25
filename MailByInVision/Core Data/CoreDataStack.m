//
//  CoreDataStack.m
//  MailByInVision
//
//  Created by Michal Kalis on 15/03/16.
//  Copyright © 2016 Michal Kalis. All rights reserved.
//

#import "CoreDataStack.h"

@interface CoreDataStack ()

@property (strong, readwrite) NSManagedObjectContext *mainContext;
/**
 *  Private context is initialized with `private` queue concurrency type to handle data processing.
 *  Private context is a parent context of the `mainContext`
 */
@property (strong, readwrite) NSManagedObjectContext *privateContext;

@property (copy) InitCallbackBlock initCallback;

- (void)initializeCoreData;

@end

@implementation CoreDataStack

/**
 *  Asynchronous initialization of Core Data stack due to various times it takes to create reference to the store which would cause blocked UI.
 *
 *  @param callback Callback block to be called once the initialization is complete
 *
 *  @return Initialized instance of `CoreDataStack` object
 */
- (instancetype)initWithCallback:(InitCallbackBlock)callback {
    if (!(self = [super init])) return nil;
    
    [self setInitCallback:callback];
    [self initializeCoreData];
    
    return self;
}

- (void)initializeCoreData {
    if ([self mainContext]) return;
    
    NSURL *modelURL = [[NSBundle mainBundle] URLForResource:@"MailByInVision" withExtension:@"momd"];
    NSManagedObjectModel *mom = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
    NSAssert(mom, @"%@:%@ No model to generate a store from", [self class], NSStringFromSelector(_cmd));
    
    NSPersistentStoreCoordinator *coordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:mom];
    NSAssert(coordinator, @"Failed to initialize persistent store coordinator");
    
    [self setMainContext:[[NSManagedObjectContext alloc] initWithConcurrencyType:NSMainQueueConcurrencyType]];
    
    [self setPrivateContext:[[NSManagedObjectContext alloc] initWithConcurrencyType:NSPrivateQueueConcurrencyType]];
    [[self privateContext] setPersistentStoreCoordinator:coordinator];
    [[self mainContext] setParentContext:[self privateContext]];
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), ^{
        NSPersistentStoreCoordinator *psc = [[self privateContext] persistentStoreCoordinator];
        NSMutableDictionary *options = [NSMutableDictionary dictionary];
        options[NSMigratePersistentStoresAutomaticallyOption] = @YES;
        options[NSInferMappingModelAutomaticallyOption] = @YES;
        options[NSSQLitePragmasOption] = @{ @"journal_mode":@"DELETE" };
        
        NSFileManager *fileManager = [NSFileManager defaultManager];
        NSURL *documentsURL = [[fileManager URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
        NSURL *storeURL = [documentsURL URLByAppendingPathComponent:@"DataModel.sqlite"];
        
        NSError *error = nil;
        NSAssert([psc addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:options error:&error], @"Error initializing PSC: %@\n%@", [error localizedDescription], [error userInfo]);
        
        if (![self initCallback]) return;
        
        dispatch_sync(dispatch_get_main_queue(), ^{
            [self initCallback]();
        });
    });
}

- (void)save {
    if (![[self privateContext] hasChanges] && ![[self mainContext] hasChanges]) return;
    
    [[self mainContext] performBlockAndWait:^{
        NSError *error = nil;
        
        NSAssert([[self mainContext] save:&error], @"Failed to save main context: %@\n%@", [error localizedDescription], [error userInfo]);
        
        [[self privateContext] performBlock:^{
            NSError *privateError = nil;
            NSAssert([[self privateContext] save:&privateError], @"Error saving private context: %@\n%@", [privateError localizedDescription], [privateError userInfo]);
        }];
    }];
}

@end
