//
//  ScreenTransitionService.h
//  MailByInVision
//
//  Created by Michal Kalis on 28/03/16.
//  Copyright © 2016 Michal Kalis. All rights reserved.
//

@import UIKit;

@class CoreDataStack;
@class WindowWithStatusBar;

@interface ScreenTransitionService : NSObject

@property (nonatomic, weak) WindowWithStatusBar *window;

- (instancetype)initWithCoreDataStack:(CoreDataStack *)coreDataStack;

- (UIViewController *)getContentViewController;

@end
