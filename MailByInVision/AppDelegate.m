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

@interface AppDelegate () <UISplitViewControllerDelegate>

@property (nonatomic, strong) UIViewController *contentController;
@property (nonatomic, strong) CustomSplitController *splitController;

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
    
    if (IS_IPAD) {
        self.contentController = [[UIStoryboard storyboardWithName:@"Main_iPad" bundle:nil] instantiateInitialViewController];
        UISplitViewController *splitViewController = (UISplitViewController *)self.contentController;
        
        self.splitController = [[CustomSplitController alloc] init];
        self.splitController.splitViewController = splitViewController;
        self.splitController.detailViewController = [[UIStoryboard storyboardWithName:@"Inbox" bundle:nil] instantiateInitialViewController];
        splitViewController.delegate = self.splitController;
        
        window.rootViewController = self.contentController;
        
#warning TODO add mainContext to controller
    }
    else {
        MainContainerViewController *controller = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateInitialViewController];
        
        // Pass the `CoreDataStack` instance to initial controller
        controller.coreDataStack = self.coreDataStack;
        
        window.rootViewController = controller;
    }
    
    [window makeKeyAndVisible];
    self.window = window;
    
    // After the whole view hierarchy and `rootViewController` are setup, add the global black status bar
    [window addBlackStatusBarView];
}

@end
