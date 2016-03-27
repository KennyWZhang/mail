//
//  Message+CoreDataProperties.m
//  MailByInVision
//
//  Created by Michal Kalis on 20/03/16.
//  Copyright © 2016 Michal Kalis. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "Message+CoreDataProperties.h"

@implementation Message (CoreDataProperties)

@dynamic attachmentName;
@dynamic attachmentURLString;
@dynamic lastMessage;
@dynamic mailbox;
@dynamic remoteID;
@dynamic threadID;
@dynamic read;
@dynamic receivedAt;
@dynamic subject;
@dynamic body;
@dynamic from;
@dynamic groups;
@dynamic marks;
@dynamic to;

@end
