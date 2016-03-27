//
//  ContentNavigationController.m
//  MailByInVision
//
//  Created by Michal Kalis on 16/03/16.
//  Copyright © 2016 Michal Kalis. All rights reserved.
//

#import "ContentNavigationController.h"
#import "UINavigationBar+CustomHeight.h"

@interface ContentNavigationController ()

@property (nonatomic, strong) UIBarButtonItem *menuButton;

@end

@implementation ContentNavigationController

#pragma mark - View Lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.navigationBar setHeight:50];
    
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
            // Custom bar button item
            UIImage *image = [[UIImage imageNamed:@"menu-button-icon"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
            UIBarButtonItem *menuButton = [[UIBarButtonItem alloc] initWithImage:image style:UIBarButtonItemStylePlain target:self action:@selector(toggleMenu:)];
            [menuButton setImageInsets:UIEdgeInsetsMake(0, -7, 0, 0)];
            
            viewController.navigationItem.leftBarButtonItems = @[menuButton];
            self.menuButton = menuButton;
        }
    }
    else {
        // Push
        viewController.navigationItem.leftBarButtonItems = @[];
    }
    
}

@end
