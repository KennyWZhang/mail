//
//  MenuViewController.h
//  MailByInVision
//
//  Created by Michal Kalis on 16/03/16.
//  Copyright © 2016 Michal Kalis. All rights reserved.
//

@import UIKit;

@protocol MenuViewControllerDelegate <NSObject>

- (void)didSelectMenuItemAtIndexPath:(NSIndexPath *)indexPath;

@end


@interface MenuViewController : UIViewController

@property (nonatomic, weak) id<MenuViewControllerDelegate> delegate;

@end
