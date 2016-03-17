//
//  MenuSectionHeaderView.h
//  MailByInVision
//
//  Created by Michal Kalis on 17/03/16.
//  Copyright © 2016 Michal Kalis. All rights reserved.
//

@import UIKit;

@interface MenuSectionHeaderView : UITableViewHeaderFooterView

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UIView *backgroundStripeView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *backgroundStripeViewHeightConstraint;

@property (nonatomic, assign, getter = isTopSection) BOOL topSection;

+ (CGFloat)heightInSection:(NSInteger)section;

@end
