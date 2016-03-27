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

@implementation InboxTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.fromLabel.textColor = [UIColor applicationUnreadLabel];
    self.subjectLabel.textColor = [UIColor applicationUnreadLabel];
    self.bodyLabel.textColor = [UIColor applicationReadLabel];
    self.receivedAtLabel.textColor = [UIColor applicationBlue];
}

- (void)configureForObject:(Message *)message {
    self.fromLabel.attributedText = [message formattedFromText];
    self.subjectLabel.text = message.subject;
    self.bodyLabel.text = message.body;
    self.attachmentIcon.hidden = message.attachmentURLString == nil;
    self.receivedAtLabel.text = @"13:47";
    
    [self setupColorsWithMessage:message];
}

#pragma mark - Private

- (void)setupColorsWithMessage:(Message *)message {
    self.subjectLabel.textColor = message.read ? [UIColor applicationReadLabel] : [UIColor applicationUnreadLabel];
}

@end
