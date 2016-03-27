//
//  MessageParser.h
//  MailByInVision
//
//  Created by Michal Kalis on 23/03/16.
//  Copyright © 2016 Michal Kalis. All rights reserved.
//

@import Foundation;
@import CoreData;

@class Message;
extern NSString *kParserErrorDomain;
extern NSInteger kParserErrorCodeNotFound;
extern NSInteger kParserErrorCodeBadData;

@interface MessageParser : NSObject

+ (Message *)messageFromJSONData:(id)jsonData inContext:(NSManagedObjectContext *)context error:(__autoreleasing NSError **)error;

@end
