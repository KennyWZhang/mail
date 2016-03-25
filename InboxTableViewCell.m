//
//  InboxTableViewCell.m
//  MailByInVision
//
//  Created by Michal Kalis on 25/03/16.
//  Copyright © 2016 Michal Kalis. All rights reserved.
//

#import "InboxTableViewCell.h"
#import "Message.h"

@implementation InboxTableViewCell

- (void)configureForObject:(Message *)message {
    self.subjectLabel.text = message.subject;
}

@end
