//
//  NSDictionary+Parsing.m
//  MailByInVision
//
//  Created by Michal Kalis on 21/03/16.
//  Copyright © 2016 Michal Kalis. All rights reserved.
//

#import "NSDictionary+Parsing.h"

@implementation NSDictionary (Parsing)

- (id)objectForKeyNotNull:(NSString *)key {
    id object = [self objectForKey:key];
    if ((NSNull *)object == [NSNull null] || (__bridge CFNullRef)object == kCFNull)
        return nil;
    
    return object;
}

@end
