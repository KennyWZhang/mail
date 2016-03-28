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
#import "CustomSplitController.h"
#import "AFNetworkActivityIndicatorManager.h"
#import "MainContainerViewController.h"
#import "UIViewController+CoreDataStack.h"
#import "ScreenTransitionService.h"
#import "LoginViewController.h"

@interface AppDelegate () <UISplitViewControllerDelegate>

@property (nonatomic, strong) ScreenTransitionService *transitionService;

@property (strong, readwrite) CoreDataStack *coreDataStack;
- (void)completeUserInterface;

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Initialize Core Data stack
    [self setCoreDataStack:[[CoreDataStack alloc] initWithCallback:^{
        [self completeUserInterface];
    }]];
    
    [self customizeAppearance];
    
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

#pragma mark - Auxiliary

- (void)customizeAppearance {
    [[UINavigationBar appearance] setBackgroundImage:[UIImage imageNamed:@"navigation-bar-background"] forBarPosition:UIBarPositionTopAttached barMetrics:UIBarMetricsDefault];
}

- (void)completeUserInterface {
    [AFNetworkActivityIndicatorManager sharedManager].enabled = YES;
    
    WindowWithStatusBar *window = [[WindowWithStatusBar alloc] initWithFrame:[UIScreen mainScreen].bounds];
    
    self.transitionService = [[ScreenTransitionService alloc] initWithCoreDataStack:self.coreDataStack];
    window.rootViewController = [self.transitionService getContentViewController];
    
    [window makeKeyAndVisible];
    self.window = window;
    
    // After the whole view hierarchy and `rootViewController` are setup, add the global black status bar
    [window addBlackStatusBarView];
    
    self.transitionService.window = window;
}

@end
