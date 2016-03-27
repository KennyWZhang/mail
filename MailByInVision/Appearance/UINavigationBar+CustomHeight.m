//
//  UINavigationBar+CustomHeight.m
//  MailByInVision
//
//  Created by Michal Kalis on 18/03/16.
//  Copyright © 2016 Michal Kalis. All rights reserved.
//

#import "UINavigationBar+CustomHeight.h"
#import "objc/runtime.h"

static char const *const heightKey = "Height";

@implementation UINavigationBar (CustomHeight)

- (void)setHeight:(CGFloat)height {
    objc_setAssociatedObject(self, heightKey, @(height), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (NSNumber *)height {
    return objc_getAssociatedObject(self, heightKey);
}

- (CGSize)sizeThatFits:(CGSize)size {
    CGSize newSize;
    
    if (self.height) {
        newSize = CGSizeMake(CGRectGetWidth(self.superview.bounds), [self.height floatValue]);
    }
    else {
        newSize = [super sizeThatFits:size];
    }
    
    return newSize;
}

@end
