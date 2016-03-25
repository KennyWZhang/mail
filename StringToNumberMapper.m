//
//  StringToNumberMapper.m
//  MailByInVision
//
//  Created by Michal Kalis on 23/03/16.
//  Copyright © 2016 Michal Kalis. All rights reserved.
//

#import "StringToNumberMapper.h"

@implementation StringToNumberMapper

- (id)objectFromSourceObject:(id)jsonObject error:(__autoreleasing NSError **)error {
    NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
    NSString *heightObject;
    
    if ([jsonObject isEqual:[NSNull null]]) {
        heightObject = @"";
    }
    else {
        heightObject = [jsonObject description];
    }
    
    return [formatter numberFromString:heightObject];
}

@end
