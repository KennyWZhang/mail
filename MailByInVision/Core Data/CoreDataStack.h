//
//  CoreDataStack.h
//  MailByInVision
//
//  Created by Michal Kalis on 15/03/16.
//  Copyright © 2016 Michal Kalis. All rights reserved.
//

#import <Foundation/Foundation.h>

@import CoreData;

typedef void (^InitCallbackBlock)(void);

@interface CoreDataStack : NSObject

- (id)initWithCallback:(InitCallbackBlock)callback;
- (void)save;

/**
 *  Main context is a "single source of truth" used to access UI
 */
@property (nonatomic, readonly) NSManagedObjectContext *mainContext;

@end
