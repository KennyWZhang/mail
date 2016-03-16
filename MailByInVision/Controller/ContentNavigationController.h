//
//  ContentNavigationController.h
//  MailByInVision
//
//  Created by Michal Kalis on 16/03/16.
//  Copyright © 2016 Michal Kalis. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol MenuButtonDelegate <NSObject>

- (void)toggleMenu;

@end

@interface ContentNavigationController : UINavigationController <UINavigationControllerDelegate>

@property (nonatomic, weak) id<MenuButtonDelegate> menuButtonDelegate;

@end
