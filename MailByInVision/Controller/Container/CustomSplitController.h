//
//  CustomSplitController.h
//  MailByInVision
//
//  Created by Michal Kalis on 17/03/16.
//  Copyright © 2016 Michal Kalis. All rights reserved.
//

@import UIKit;

@interface CustomSplitController : NSObject <UISplitViewControllerDelegate>

@property (strong, nonatomic) UISplitViewController *splitViewController;

/**
 *  The currently displayed detail view controller.
 */
@property (weak, nonatomic) UIViewController *detailViewController;

@property (weak, nonatomic) UIViewController *masterViewController;

- (void)dismissMasterAnimated:(BOOL)animated;

@end
