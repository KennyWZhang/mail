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

@interface AppDelegate () <UISplitViewControllerDelegate>

@property (nonatomic, strong) UIViewController *contentController;
@property (nonatomic, strong) CustomSplitController *splitController;

@property (strong, readwrite) CoreDataStack *coreDataStack;
- (void)completeUserInterface;

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    WindowWithStatusBar *window = [[WindowWithStatusBar alloc] initWithFrame:[UIScreen mainScreen].bounds];
    
    if (IS_IPAD) {
        self.contentController = [[UIStoryboard storyboardWithName:@"Main_iPad" bundle:nil] instantiateInitialViewController];
        UISplitViewController *splitViewController = (UISplitViewController *)self.contentController;
        
        self.splitController = [[CustomSplitController alloc] init];
        self.splitController.splitViewController = splitViewController;
        self.splitController.detailViewController = [[UIStoryboard storyboardWithName:@"Inbox" bundle:nil] instantiateInitialViewController];
        splitViewController.delegate = self.splitController;
        
        window.rootViewController = self.contentController;
    }
    else {
        window.rootViewController = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateInitialViewController];
    }
    
    [window makeKeyAndVisible];
    self.window = window;
    
    // After the whole view hierarchy and `rootViewController` are setup, add the global black status bar
    [window addBlackStatusBarView];
    
    [self customizeAppearance];
    
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

#pragma mark - Auxiliary

- (void)customizeAppearance {
    [[UINavigationBar appearance] setBackgroundImage:[UIImage imageNamed:@"navigation-bar-background"] forBarPosition:UIBarPositionTopAttached barMetrics:UIBarMetricsDefault];
}

- (void)completeUserInterface {
#warning TODO either add some UI setup or remove this code
}

@end
