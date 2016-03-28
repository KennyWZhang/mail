//
//  CustomSplitController.m
//  MailByInVision
//
//  Created by Michal Kalis on 17/03/16.
//  Copyright © 2016 Michal Kalis. All rights reserved.
//

#import "CustomSplitController.h"
#import "ContentNavigationController.h"

@interface CustomSplitController ()

@property (nonatomic, retain) UIPopoverController *popoverController;

@end

@implementation CustomSplitController

- (void)setMasterViewController:(UIViewController *)masterViewController {
    self.splitViewController.viewControllers = @[masterViewController];
}

- (void)setDetailViewController:(ContentNavigationController *)detailViewController {
    if (self.splitViewController.viewControllers.count == 2 && [self.splitViewController.viewControllers[1] isKindOfClass:[ContentNavigationController class]]) {
        // for content view controller copy the left buttons because of the "menu" button in portrait mode
        ContentNavigationController *prevDetailViewController = self.splitViewController.viewControllers[1];
        detailViewController.topViewController.navigationItem.leftBarButtonItems = prevDetailViewController.topViewController.navigationItem.leftBarButtonItems;
    }
    
    UIViewController *masterViewController = [self.splitViewController.viewControllers objectAtIndex:0];
    self.splitViewController.viewControllers = @[masterViewController, detailViewController];
    self.splitViewController.presentsWithGesture = NO;
    
    // Dismiss the popover if one was present. This will only occur if the device is in portrait.
    [self dismissMasterAnimated:YES];
}

- (UIViewController *)detailViewController {
    UIViewController *detailViewController = nil;
    if (self.splitViewController.viewControllers.count == 2) {
        detailViewController = self.splitViewController.viewControllers[1];
    }
    return detailViewController;
}

#pragma mark - Actions

- (void)dismissMasterAnimated:(BOOL)animated {
    if (self.popoverController) {
        [self.popoverController dismissPopoverAnimated:animated];
    }
}

#pragma mark - Split view delegate

- (BOOL)splitViewController:(UISplitViewController *)svc shouldHideViewController:(UIViewController *)vc inOrientation:(UIInterfaceOrientation)orientation {
    return UIInterfaceOrientationIsPortrait(orientation);
}

- (void)splitViewController:(UISplitViewController *)svc willHideViewController:(UIViewController *)aViewController withBarButtonItem:(UIBarButtonItem *)barButtonItem
       forPopoverController:(UIPopoverController *)pc {
    UIImage *image = [UIImage imageNamed:@"menu-button-icon"];
    image = [image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    barButtonItem.image = image;
    self.popoverController = pc;
    ContentNavigationController *detailViewController = self.splitViewController.viewControllers[1];
    if (detailViewController.topViewController == detailViewController.viewControllers.firstObject) {
        detailViewController.topViewController.navigationItem.leftBarButtonItems = [@[barButtonItem] arrayByAddingObjectsFromArray:detailViewController.topViewController.navigationItem.leftBarButtonItems];
    }
}

- (void)splitViewController:(UISplitViewController *)svc willShowViewController:(UIViewController *)aViewController invalidatingBarButtonItem:(UIBarButtonItem *)barButtonItem {
    self.popoverController = nil;
    ContentNavigationController *detailViewController = self.splitViewController.viewControllers[1];
    if (detailViewController.topViewController.navigationItem.leftBarButtonItems.count > 2) {
        NSRange rangeOfOtherBarButtons = NSMakeRange(1, detailViewController.topViewController.navigationItem.leftBarButtonItems.count-1);
        detailViewController.topViewController.navigationItem.leftBarButtonItems = [detailViewController.topViewController.navigationItem.leftBarButtonItems subarrayWithRange:rangeOfOtherBarButtons];
    } else {
        detailViewController.topViewController.navigationItem.leftBarButtonItems = @[];
    }
}

@end
