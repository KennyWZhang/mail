//
//  MenuTableViewCell.m
//  MailByInVision
//
//  Created by Michal Kalis on 17/03/16.
//  Copyright © 2016 Michal Kalis. All rights reserved.
//

#import "MenuTableViewCell.h"
#import "UIColor+ApplicationSpecific.h"

@implementation MenuTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.contentView.backgroundColor = [UIColor applicationMenuCellColor];
    self.titleLabel.textColor = [UIColor applicationMenuCellTextColor];
    self.iconImageView.tintColor = [UIColor applicationMenuCellTextColor];
    
    self.separatorLine.backgroundColor = [UIColor applicationMenuSectionColor];
    self.separatorLine.hidden = YES;
}

- (void)setHighlighted:(BOOL)highlighted animated:(BOOL)animated {
    [super setHighlighted:highlighted animated:animated];
    
    if (highlighted) {
        self.titleLabel.textColor = [UIColor whiteColor];
        self.iconImageView.tintColor = [UIColor whiteColor];
        self.contentView.backgroundColor = [UIColor applicationMenuCellHighlightedColor];
    }
    else {
        self.titleLabel.textColor = [UIColor applicationMenuCellTextColor];
        self.iconImageView.tintColor = [UIColor applicationMenuCellTextColor];
        self.contentView.backgroundColor = [UIColor applicationMenuCellColor];
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    if (selected) {
        self.titleLabel.textColor = [UIColor whiteColor];
        self.iconImageView.tintColor = [UIColor whiteColor];
        self.contentView.backgroundColor = [UIColor applicationMenuCellSelectedColor];
    }
    else {
        self.titleLabel.textColor = [UIColor applicationMenuCellTextColor];
        self.iconImageView.tintColor = [UIColor applicationMenuCellTextColor];
        self.contentView.backgroundColor = [UIColor applicationMenuCellColor];
    }
}

@end
