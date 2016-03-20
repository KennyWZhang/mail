//
//  Message+CoreDataProperties.h
//  MailByInVision
//
//  Created by Michal Kalis on 20/03/16.
//  Copyright © 2016 Michal Kalis. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "Message.h"

NS_ASSUME_NONNULL_BEGIN

@interface Message (CoreDataProperties)

@property (nullable, nonatomic, retain) NSString *attachmentName;
@property (nullable, nonatomic, retain) NSString *attachmentURL;
@property (nullable, nonatomic, retain) NSNumber *lastMessage;
@property (nullable, nonatomic, retain) NSNumber *mailbox;
@property (nullable, nonatomic, retain) NSNumber *read;
@property (nullable, nonatomic, retain) NSString *receivedAt;
@property (nullable, nonatomic, retain) NSString *subject;
@property (nullable, nonatomic, retain) Contact *from;
@property (nullable, nonatomic, retain) NSSet<Group *> *groups;
@property (nullable, nonatomic, retain) NSSet<Mark *> *marks;
@property (nullable, nonatomic, retain) NSManagedObject *relationship;
@property (nullable, nonatomic, retain) Thread *thread;
@property (nullable, nonatomic, retain) NSSet<Contact *> *to;

@end

@interface Message (CoreDataGeneratedAccessors)

- (void)addGroupsObject:(Group *)value;
- (void)removeGroupsObject:(Group *)value;
- (void)addGroups:(NSSet<Group *> *)values;
- (void)removeGroups:(NSSet<Group *> *)values;

- (void)addMarksObject:(Mark *)value;
- (void)removeMarksObject:(Mark *)value;
- (void)addMarks:(NSSet<Mark *> *)values;
- (void)removeMarks:(NSSet<Mark *> *)values;

- (void)addToObject:(Contact *)value;
- (void)removeToObject:(Contact *)value;
- (void)addTo:(NSSet<Contact *> *)values;
- (void)removeTo:(NSSet<Contact *> *)values;

@end

NS_ASSUME_NONNULL_END
