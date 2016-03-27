//
//  ContactParser.m
//  MailByInVision
//
//  Created by Michal Kalis on 24/03/16.
//  Copyright © 2016 Michal Kalis. All rights reserved.
//

#import "ContactParser.h"
#import "Contact.h"
#import "ManagedObjectMapper.h"

@implementation ContactParser

#pragma mark - Public

+ (id<Mapper>)contactMapperWithContext:(NSManagedObjectContext *)context {
    NSDictionary *jsonKeysToFields = @{@"id": @"remoteID",
                                       @"firstname": @"firstname",
                                       @"lastname": @"lastname",
                                       @"email": @"emailAddress",
                                       @"avatarUrl": @"avatarURLString"};
    id<Mapper> objectMapper = [[ManagedObjectMapper alloc] initWithGeneratorOfClass:[Contact class]
                                                                   jsonKeysToFields:jsonKeysToFields
                                                                    fieldsToMappers:@{}
                                                                            context:context];
    return objectMapper;
}

@end
