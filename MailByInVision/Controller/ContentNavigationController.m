//
//  ContentNavigationController.m
//  MailByInVision
//
//  Created by Michal Kalis on 16/03/16.
//  Copyright © 2016 Michal Kalis. All rights reserved.
//

#import "ContentNavigationController.h"

@interface ContentNavigationController ()

@property (nonatomic, strong) UIBarButtonItem *menuButton;

@end

@implementation ContentNavigationController

#pragma mark - View Lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.delegate = self;
}

#pragma mark - Actions

- (void)toggleMenu:(UIBarButtonItem *)button {
    if ([self.menuButtonDelegate respondsToSelector:@selector(toggleMenu)]) {
        [self.menuButtonDelegate toggleMenu];
    }
}

#pragma mark - Navigation Controller Delegate

- (void)navigationController:(UINavigationController *)navigationController didShowViewController:(UIViewController *)viewController animated:(BOOL)animated {
    if (viewController == self.viewControllers.firstObject) {
        // Poping back to the root
        if (self.presentingViewController == nil) {
            UIBarButtonItem *menuButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(toggleMenu:)];
            self.menuButton = menuButton;
            viewController.navigationItem.leftBarButtonItems = @[menuButton];
        }
    }
    else {
        // Push
        viewController.navigationItem.leftBarButtonItems = @[];
    }
    
}

@end
