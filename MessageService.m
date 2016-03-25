//
//  MessageService.m
//  MailByInVision
//
//  Created by Michal Kalis on 21/03/16.
//  Copyright © 2016 Michal Kalis. All rights reserved.
//

#import "MessageService.h"
#import "APIClient.h"
#import "NSDictionary+Parsing.h"
#import "NSManagedObject+CustomInit.h"
#import "Message.h"
#import "CoreDataStack.h"
#import "MessageParser.h"

@implementation MessageService

+ (NSURLSessionDataTask *)fetchAllMessagesWithCoreDataStack:(CoreDataStack *)coreDataStack requestResult:(void (^)(NSArray *messages, NSError *error))requestResult {
    NSURLSessionDataTask *dataTask = [[APIClient sharedInstance] GET:@"s/hma5zdh4y4i8635/messages.json?dl=1" parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id _Nullable responseObject) {
        
        NSMutableArray *resultMessages = [@[] mutableCopy];
        
        NSArray *messages = [responseObject objectForKeyNotNull:@"messages"];
        for (NSDictionary *messageDictionary in messages) {
            NSError *error = nil;
            [resultMessages addObject:[MessageParser messageFromJSONData:messageDictionary inContext:coreDataStack.privateContext error:&error]];
        }
        
        [coreDataStack save];
        
        requestResult(resultMessages, nil);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        requestResult(nil, error);
    }];
    
    return dataTask;
}

@end
