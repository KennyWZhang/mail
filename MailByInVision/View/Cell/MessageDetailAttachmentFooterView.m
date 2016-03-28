//
//  MessageDetailAttachmentFooterView.m
//  MailByInVision
//
//  Created by Michal Kalis on 27/03/16.
//  Copyright © 2016 Michal Kalis. All rights reserved.
//

#import "MessageDetailAttachmentFooterView.h"
#import "UIColor+ApplicationSpecific.h"

@implementation MessageDetailAttachmentFooterView

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.numberOfAttachmentsLabel.textColor = [UIColor applicationUnreadLabelColor];
    self.attachmentFilenameButton.titleLabel.textColor = [UIColor applicationBlueColor];
}

@end
