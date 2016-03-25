//
//  NSManagedObject+CustomInit.h
//  MailByInVision
//
//  Created by Michal Kalis on 21/03/16.
//  Copyright © 2016 Michal Kalis. All rights reserved.
//

@import CoreData;

@interface NSManagedObject (CustomInit)

- (instancetype)initWithContext:(NSManagedObjectContext *)context;

+ (NSString *)entityName;
+ (id)findOrCreateElementWithID:(NSString *)remoteID inContext:(NSManagedObjectContext *)context;

@end
