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
@dynamic attachmentURL;
@dynamic lastMessage;
@dynamic mailbox;
@dynamic read;
@dynamic receivedAt;
@dynamic subject;
@dynamic from;
@dynamic groups;
@dynamic marks;
@dynamic relationship;
@dynamic thread;
@dynamic to;

@end
