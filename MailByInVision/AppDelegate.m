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
    UIWindow *window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    
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
    
    [self addBlackStatusBarView];
    
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

- (void)completeUserInterface {
}

- (void)addBlackStatusBarView {
    UIView *view = [[UIView alloc] initWithFrame:CGRectZero];
    view.translatesAutoresizingMaskIntoConstraints = NO;
    view.backgroundColor = [UIColor blackColor];
    [self.window.rootViewController.view addSubview:view];
    
    [self.window.rootViewController.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[view]|" options:0 metrics:nil views:@{@"view": view}]];
    [self.window.rootViewController.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[view]" options:0 metrics:nil views:@{@"view": view}]];
    [self.window.rootViewController.view addConstraint:[NSLayoutConstraint constraintWithItem:view attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:0 multiplier:1 constant:20]];
}

@end
