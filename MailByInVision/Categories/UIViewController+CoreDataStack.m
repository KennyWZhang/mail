//
//  UIViewController+CoreDataStack.m
//  MailByInVision
//
//  Created by Michal Kalis on 21/03/16.
//  Copyright © 2016 Michal Kalis. All rights reserved.
//

#import "UIViewController+CoreDataStack.h"
#import <objc/runtime.h>

@implementation UIViewController (CoreDataStack)

static const void *CoreDataStackKey = &CoreDataStackKey;

- (void)setCoreDataStack:(CoreDataStack *)coreDataStack {
    objc_setAssociatedObject(self, CoreDataStackKey, coreDataStack, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (CoreDataStack *)coreDataStack {
    return objc_getAssociatedObject(self, CoreDataStackKey);
}

@end
