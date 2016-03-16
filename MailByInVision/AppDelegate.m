//
//  AppDelegate.m
//  MailByInVision
//
//  Created by Michal Kalis on 15/03/16.
//  Copyright © 2016 Michal Kalis. All rights reserved.
//

#import "AppDelegate.h"
#import "MainContainerViewController.h"
#import "CoreDataStack.h"

@interface AppDelegate () <UISplitViewControllerDelegate>

@property (strong, readwrite) CoreDataStack *coreDataStack;
- (void)completeUserInterface;

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Initialize Core Data stack
    [self setCoreDataStack:[[CoreDataStack alloc] initWithCallback:^{
        [self completeUserInterface];
    }]];
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    [[self coreDataStack] save];
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    [[self coreDataStack] save];
}

- (void)applicationWillTerminate:(UIApplication *)application {
    [[self coreDataStack] save];
}

- (void)completeUserInterface {
}

@end
