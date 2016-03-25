//
//  NSManagedObject+CustomInit.m
//  MailByInVision
//
//  Created by Michal Kalis on 21/03/16.
//  Copyright © 2016 Michal Kalis. All rights reserved.
//

@import CoreData;
@import Foundation;

#import "NSManagedObject+CustomInit.h"
#import "NSString+Emptiness.h"

@implementation NSManagedObject (CustomInit)

- (instancetype)initWithContext:(NSManagedObjectContext *)context {
    NSEntityDescription *entityDescription = [NSEntityDescription entityForName:NSStringFromClass([self class]) inManagedObjectContext:context];
    return [self initWithEntity:entityDescription insertIntoManagedObjectContext:context];
}

+ (NSString *)entityName {
    return NSStringFromClass(self);
}

+ (id)findOrCreateElementWithID:(NSString *)remoteID inContext:(NSManagedObjectContext *)context {
    if (!remoteID.notEmpty) {
        return nil;
    }
    
    NSFetchRequest *request = [[NSFetchRequest alloc] initWithEntityName:[self entityName]];
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"remoteID == %@", remoteID];
    request.predicate = predicate;
    
    // First try finding object in row cache
    for (NSManagedObject *object in context.registeredObjects) {
        if (object.fault) {
            continue;
        }
        
        if (![object isKindOfClass:[self class]] || ![predicate evaluateWithObject:object]) {
            continue;
        }
        
    }
    
    // Else do a fetch down to SQLite database
    NSError *error = nil;
    NSArray<NSManagedObject *> *objects = [context executeFetchRequest:request error:&error];
    if (objects.firstObject) {
        return objects.firstObject;
    }
    
    if (error) {
#warning TODO handle error
        return nil;
    }
    
    return [NSEntityDescription insertNewObjectForEntityForName:[self entityName] inManagedObjectContext:context];
}

@end
