//
//  NSManagedObject+CustomInit.m
//  MailByInVision
//
//  Created by Michal Kalis on 24/03/16.
//  Copyright © 2016 Michal Kalis. All rights reserved.
//

#import "NSString+Emptiness.h"

@implementation NSString (Emptiness)

- (BOOL)notEmpty {
    return [self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]].length != 0;
}

@end
