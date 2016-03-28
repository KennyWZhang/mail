//
//  NSIndexPath+Equality.m
//  MailByInVision
//
//  Created by Michal Kalis on 28/03/16.
//  Copyright © 2016 Michal Kalis. All rights reserved.
//

#import "NSIndexPath+Equality.h"

@implementation NSIndexPath (Equality)

- (BOOL)isEqualToIndexPath:(NSIndexPath *)indexPath {
    return ([self compare:indexPath] == NSOrderedSame);
}

@end
