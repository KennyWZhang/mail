//
//  MessageParser.m
//  MailByInVision
//
//  Created by Michal Kalis on 23/03/16.
//  Copyright © 2016 Michal Kalis. All rights reserved.
//

#import "MessageParser.h"
#import "Message.h"
#import "Mapper.h"
#import "ManagedObjectMapper.h"
#import "ArrayMapper.h"
#import "SetMapper.h"
#import "ErrorIfMapper.h"
#import "ChainMapper.h"
#import "OptionalMapper.h"
#import "NSManagedObject+CustomInit.h"
#import "ContactParser.h"

NSString *kParserErrorDomain = @"kParserErrorDomain";
NSInteger kParserErrorCodeNotFound = 1;
NSInteger kParserErrorCodeBadData = 2;

@implementation MessageParser

#pragma mark - Public

+ (Message *)messageFromJSONData:(id)jsonData inContext:(NSManagedObjectContext *)context error:(__autoreleasing NSError **)error {
    ErrorIfMapper *errorMapper = [[ErrorIfMapper alloc] initWithErrorDomain:kParserErrorDomain
                                                                  errorCode:kParserErrorCodeNotFound
                                                                   userInfo:@{NSLocalizedDescriptionKey: @"No message was found"}
                                                       errorIfJSONKeyExists:@"error"];
    
    NSArray *mappersToTry = @[errorMapper, [MessageParser messageMapperWithContext:context]];
    ChainMapper *mapper = [[ChainMapper alloc] initWithMappers:mappersToTry];
    
    return [mapper objectFromSourceObject:jsonData error:error];
}

#pragma mark - Private

+ (id<Mapper>)messageMapperWithContext:(NSManagedObjectContext *)context {
    NSDictionary *jsonKeysToFields = @{@"id": @"remoteID",
                                       @"attachmentName": @"attachmentName",
                                       @"attachmentUrl": @"attachmentURLString",
                                       @"body": @"body",
                                       @"mailbox": @"mailbox",
                                       @"read": @"read",
                                       @"receivedAt": @"receivedAt",
                                       @"subject": @"subject",
                                       @"from": @"from",
                                       @"to": @"to"};
    
    id<Mapper> contactMapper = [ContactParser contactMapperWithContext:context];
    id<Mapper> objectToContactsMapper = [[SetMapper alloc] initWithItemMapper:contactMapper];
    id<Mapper> objectMapper = [[ManagedObjectMapper alloc] initWithGeneratorOfClass:[Message class]
                                                            jsonKeysToFields:jsonKeysToFields
                                                             fieldsToMappers:@{@"from": contactMapper,
                                                                               @"to": objectToContactsMapper}
                                                                     context:context];
    return objectMapper;
}

@end
