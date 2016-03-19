//
//  AppDelegate.h
//  MailByInVision
//
//  Created by Michal Kalis on 15/03/16.
//  Copyright © 2016 Michal Kalis. All rights reserved.
//

@import UIKit;
@import CoreData;
#import "WindowWithStatusBar.h"

@class CoreDataStack;

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) WindowWithStatusBar *window;
@property (strong, readonly) CoreDataStack *coreDataStack;

@end

