//
//  MessageDetailBottomView.m
//  MailByInVision
//
//  Created by Michal Kalis on 27/03/16.
//  Copyright © 2016 Michal Kalis. All rights reserved.
//

#import "MessageDetailBottomView.h"
#import "UIColor+ApplicationSpecific.h"

@implementation MessageDetailBottomView

- (void)awakeFromNib {
    [super awakeFromNib];
    
    [self.replyButton setTitleColor:[UIColor applicationLightGrayTextColor] forState:UIControlStateNormal];
    [self.forwardButton setTitleColor:[UIColor applicationLightGrayTextColor] forState:UIControlStateNormal];
    self.leftContainerView.backgroundColor = [UIColor applicationLightGrayBackgroundColor];
    self.rightContainerView.backgroundColor = [UIColor applicationLightGrayBackgroundColor];
}

@end
