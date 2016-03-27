//
//  Mark+CoreDataProperties.h
//  MailByInVision
//
//  Created by Michal Kalis on 20/03/16.
//  Copyright © 2016 Michal Kalis. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "Mark.h"

NS_ASSUME_NONNULL_BEGIN

@interface Mark (CoreDataProperties)

@property (nullable, nonatomic, retain) id color;
@property (nullable, nonatomic, retain) NSString *name;
@property (nullable, nonatomic, retain) NSSet<Message *> *messages;

@end

@interface Mark (CoreDataGeneratedAccessors)

- (void)addMessagesObject:(Message *)value;
- (void)removeMessagesObject:(Message *)value;
- (void)addMessages:(NSSet<Message *> *)values;
- (void)removeMessages:(NSSet<Message *> *)values;

@end

NS_ASSUME_NONNULL_END
