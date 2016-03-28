//
//  MessageDetailHeaderView.m
//  MailByInVision
//
//  Created by Michal Kalis on 27/03/16.
//  Copyright © 2016 Michal Kalis. All rights reserved.
//

#import "MessageDetailHeaderView.h"
#import "UIColor+ApplicationSpecific.h"

@implementation MessageDetailHeaderView

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.subjectLabel.textColor = [UIColor applicationUnreadLabelColor];
    self.backgroundColor = [UIColor applicationLightGrayBackgroundColor];
}

@end
