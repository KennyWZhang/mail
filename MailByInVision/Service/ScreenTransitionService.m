//
//  ScreenTransitionService.m
//  MailByInVision
//
//  Created by Michal Kalis on 28/03/16.
//  Copyright © 2016 Michal Kalis. All rights reserved.
//

#import "ScreenTransitionService.h"
#import "CoreDataStack.h"
#import "MainContainerViewController.h"
#import "UIViewController+CoreDataStack.h"
#import "WindowWithStatusBar.h"
#import "CustomSplitController.h"
#import "DemoUserService.h"

@interface ScreenTransitionService ()

@property (nonatomic, strong) CoreDataStack *coreDataStack;

// iPad
@property (nonatomic, strong) UIViewController *contentController;
@property (nonatomic, strong) CustomSplitController *splitController;

@end

@implementation ScreenTransitionService

- (instancetype)initWithCoreDataStack:(CoreDataStack *)coreDataStack {
    if (self = [super init]) {
        self.coreDataStack = coreDataStack;
        
        [self startHandlingScreenTransitions];
    }
    
    return self;
}

- (UIViewController *)getContentViewController {
    UIViewController *controller = nil;
    
    if ([DemoUserService isAuthorised]) {
        if (IS_IPAD) {
            self.contentController = [[UIStoryboard storyboardWithName:@"Main_iPad" bundle:nil] instantiateInitialViewController];
            UISplitViewController *splitViewController = (UISplitViewController *)self.contentController;
            
            self.splitController = [[CustomSplitController alloc] init];
            self.splitController.splitViewController = splitViewController;
            self.splitController.masterViewController = [[UIStoryboard storyboardWithName:@"Menu" bundle:nil] instantiateInitialViewController];
            self.splitController.detailViewController = [[UIStoryboard storyboardWithName:@"Inbox" bundle:nil] instantiateInitialViewController];
            splitViewController.delegate = self.splitController;
            
            // Pass the `CoreDataStack` instance to initial controller
            ((UINavigationController *)self.splitController.detailViewController).topViewController.coreDataStack = self.coreDataStack;
            
            controller = self.contentController;
        }
        else {
            MainContainerViewController *contentController = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateInitialViewController];
            
            // Pass the `CoreDataStack` instance to initial controller
            contentController.coreDataStack = self.coreDataStack;
            
            controller = contentController;
        }
    }
    else {
        controller = [[UIStoryboard storyboardWithName:@"Login" bundle:nil] instantiateInitialViewController];
    }
    
    return controller;
}

- (void)startHandlingScreenTransitions {
    NSNotificationCenter *defaultCenter = [NSNotificationCenter defaultCenter];
    [defaultCenter addObserverForName:DidAuthoriseNotification object:nil queue:[NSOperationQueue mainQueue] usingBlock:^(NSNotification * _Nonnull note) {
        [self transitionToContentHierarchy];
    }];
}

- (void)transitionToContentHierarchy {
    UIViewController *currentController = self.window.rootViewController;
    
    UIViewController *newController = [self getContentViewController];
    
    newController.coreDataStack = self.coreDataStack;
    
    CGRect frame = CGRectMake(0, 0, CGRectGetWidth(newController.view.frame), CGRectGetHeight(newController.view.frame));
    UIView *subview = [[UIView alloc] initWithFrame:frame];
    
    self.window.rootViewController = newController;
    
    if (currentController) {
        [newController willMoveToParentViewController:nil];
        [subview addSubview:currentController.view];
        [newController.view addSubview:subview];
    }
    
    [UIView animateWithDuration:0.22 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        CGRect newFrame = CGRectMake(0, CGRectGetHeight(newController.view.frame), CGRectGetWidth(newController.view.frame), CGRectGetHeight(newController.view.frame));
        subview.frame = newFrame;
    } completion:^(BOOL finished) {
        if (currentController) {
            [currentController removeFromParentViewController];
            
            [newController didMoveToParentViewController:nil];
            
            [subview removeFromSuperview];
        }
    }];
}

@end
