//
//  DemoUserService.h
//  MailByInVision
//
//  Created by Michal Kalis on 28/03/16.
//  Copyright © 2016 Michal Kalis. All rights reserved.
//

@import UIKit;

UIKIT_EXTERN NSString * const DidAuthoriseNotification;

@interface DemoUserService : NSObject

+ (void)saveUserWithEmail:(NSString *)email;
+ (BOOL)isAuthorised;

@end
