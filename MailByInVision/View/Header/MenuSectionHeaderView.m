//
//  MenuSectionHeaderView.m
//  MailByInVision
//
//  Created by Michal Kalis on 17/03/16.
//  Copyright © 2016 Michal Kalis. All rights reserved.
//

#import "MenuSectionHeaderView.h"
#import "UIColor+ApplicationSpecific.h"

@implementation MenuSectionHeaderView

const CGFloat SectionHeight = 52;
const CGFloat TopSectionHeight = 50;
const CGFloat SectionTopInset = 17;

- (void)awakeFromNib {
    [super awakeFromNib];
    
    [self setupUI];
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super initWithCoder:aDecoder]) {
        [self setupUI];
    }
    
    return self;
}

+ (CGFloat)heightInSection:(NSInteger)section {
    if (section == 0) {
        return TopSectionHeight;
    }
    
    return SectionHeight;
}

- (void)setTopSection:(BOOL)topSection {
    self.backgroundStripeViewHeightConstraint.constant = topSection ? TopSectionHeight : SectionHeight - SectionTopInset;
    
    _topSection = topSection;
}

- (void)setupUI {
    self.backgroundStripeView.backgroundColor = [UIColor applicationMenuSectionColor];
    self.titleLabel.textColor = [UIColor applicationMenuSectionTextColor];
}

@end
