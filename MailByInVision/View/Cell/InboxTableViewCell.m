//
//  InboxTableViewCell.m
//  MailByInVision
//
//  Created by Michal Kalis on 25/03/16.
//  Copyright © 2016 Michal Kalis. All rights reserved.
//

#import "InboxTableViewCell.h"
#import "Message.h"
#import "UIColor+ApplicationSpecific.h"
#import "NSDate+Utils.h"

@implementation InboxTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.fromLabel.textColor = [UIColor applicationUnreadLabelColor];
    self.subjectLabel.textColor = [UIColor applicationUnreadLabelColor];
    self.bodyLabel.textColor = [UIColor applicationReadLabelColor];
    self.receivedAtLabel.textColor = [UIColor applicationBlueColor];
}

#pragma mark - Private

- (void)setupColorsWithMessage:(Message *)message {
    UIColor *resultColor = message.read.boolValue ? [UIColor applicationReadLabelColor] : [UIColor applicationUnreadLabelColor];
    self.receivedAtLabel.textColor = message.read.boolValue ? [UIColor applicationLightGrayTextColor] : [UIColor applicationBlueColor];
    self.fromLabel.textColor = resultColor;
    self.subjectLabel.textColor = resultColor;
}

#pragma mark - Configurable Cell

- (void)configureForObject:(Message *)message {
    self.fromLabel.attributedText = [message formattedFromTextWithPrefix:YES];
    self.subjectLabel.text = message.subject;
    self.bodyLabel.text = message.body;
    self.unreadIcon.hidden = message.read.boolValue;
    self.attachmentIcon.hidden = message.attachmentURLString == nil;
    
    NSDate *receivedAtDate = [NSDate dateWithTimeIntervalSince1970:message.receivedAt.doubleValue];
    if (receivedAtDate) {
        self.receivedAtLabel.text = [receivedAtDate wordsExpression];
    }
    
    [self setupColorsWithMessage:message];
}

@end
