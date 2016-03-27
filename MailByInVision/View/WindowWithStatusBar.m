//
//  WindowWithStatusBar.m
//  MailByInVision
//
//  Created by Michal Kalis on 19/03/16.
//  Copyright © 2016 Michal Kalis. All rights reserved.
//

#import "WindowWithStatusBar.h"

@interface WindowWithStatusBar ()

@property (nonatomic, strong) UIView *statusBar;

@end

@implementation WindowWithStatusBar

- (void)layoutSubviews {
    [super layoutSubviews];
    
    if (self.statusBar != nil) {
        [self bringSubviewToFront:self.statusBar];
    }
}

- (void)addBlackStatusBarView {
    UIView *view = [[UIView alloc] initWithFrame:CGRectZero];
    view.translatesAutoresizingMaskIntoConstraints = NO;
    view.backgroundColor = [UIColor blackColor];
    [self addSubview:view];
    
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[view]|" options:0 metrics:nil views:@{@"view": view}]];
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[view]" options:0 metrics:nil views:@{@"view": view}]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:view attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:0 multiplier:1 constant:20]];
    
    self.statusBar = view;
}

@end
