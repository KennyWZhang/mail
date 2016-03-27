//
//  Contact+CoreDataProperties.h
//  MailByInVision
//
//  Created by Michal Kalis on 20/03/16.
//  Copyright © 2016 Michal Kalis. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "Contact.h"

NS_ASSUME_NONNULL_BEGIN

@interface Contact (CoreDataProperties)

@property (nullable, nonatomic, retain) NSString *avatarURLString;
@property (nullable, nonatomic, retain) NSString *emailAddress;
@property (nullable, nonatomic, retain) NSString *firstname;
@property (nullable, nonatomic, retain) NSString *lastname;
@property (nullable, nonatomic, retain) NSString *remoteID;
@property (nullable, nonatomic, retain) NSSet<Message *> *receivedMessages;
@property (nullable, nonatomic, retain) NSSet<Message *> *sentMessages;

@end

@interface Contact (CoreDataGeneratedAccessors)

- (void)addReceivedMessagesObject:(Message *)value;
- (void)removeReceivedMessagesObject:(Message *)value;
- (void)addReceivedMessages:(NSSet<Message *> *)values;
- (void)removeReceivedMessages:(NSSet<Message *> *)values;

- (void)addSentMessagesObject:(Message *)value;
- (void)removeSentMessagesObject:(Message *)value;
- (void)addSentMessages:(NSSet<Message *> *)values;
- (void)removeSentMessages:(NSSet<Message *> *)values;

@end

NS_ASSUME_NONNULL_END
