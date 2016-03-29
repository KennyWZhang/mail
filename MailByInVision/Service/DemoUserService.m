//
//  DemoUserService.m
//  MailByInVision
//
//  Created by Michal Kalis on 28/03/16.
//  Copyright © 2016 Michal Kalis. All rights reserved.
//

#import "DemoUserService.h"

NSString * const UserExistsKey = @"UserExistsKey";

NSString * const DidAuthoriseNotification = @"DidAuthoriseNotification";

@implementation DemoUserService

+ (void)saveUserWithEmail:(NSString *)email {
    [[NSUserDefaults standardUserDefaults] setObject:email forKey:UserExistsKey];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

+ (BOOL)isAuthorised {
    return [[NSUserDefaults standardUserDefaults] objectForKey:UserExistsKey] != nil;
}

@end
