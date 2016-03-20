//
//  Message.h
//  MailByInVision
//
//  Created by Michal Kalis on 20/03/16.
//  Copyright © 2016 Michal Kalis. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Contact, Group, Mark, Thread;

NS_ASSUME_NONNULL_BEGIN

@interface Message : NSManagedObject

// Insert code here to declare functionality of your managed object subclass

@end

NS_ASSUME_NONNULL_END

#import "Message+CoreDataProperties.h"
