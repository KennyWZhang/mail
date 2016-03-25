//
//  MessageService.h
//  MailByInVision
//
//  Created by Michal Kalis on 21/03/16.
//  Copyright © 2016 Michal Kalis. All rights reserved.
//

@import Foundation;

@class CoreDataStack;

@interface MessageService : NSObject

+ (NSURLSessionDataTask *)fetchAllMessagesWithCoreDataStack:(CoreDataStack *)coreDataStack requestResult:(void (^)(NSArray *messages, NSError *error))requestResult;

@end
