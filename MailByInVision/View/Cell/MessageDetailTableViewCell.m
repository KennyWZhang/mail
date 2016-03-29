//
//  MessageDetailTableViewCell.m
//  MailByInVision
//
//  Created by Michal Kalis on 27/03/16.
//  Copyright © 2016 Michal Kalis. All rights reserved.
//

#import "MessageDetailTableViewCell.h"
#import "Message.h"
#import "Contact.h"
#import "NSDate+Utils.h"
#import "ImageCache.h"
#import "UIColor+ApplicationSpecific.h"

@implementation MessageDetailTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    // Hide labels in expanded state as default
    self.expanded = NO;
    
    // Rounded avatar image
    self.avatarImageView.layer.cornerRadius = CGRectGetHeight(self.avatarImageView.bounds) / 2;
    self.avatarImageView.layer.masksToBounds = YES;
    
    // Other UI customisation
    self.bodyLabel.textColor = [UIColor applicationGrayTextColor];
    self.receivedAtLabel.textColor = [UIColor applicationLightGrayTextColor];
    self.expandedToLabel.textColor = [UIColor applicationLightGrayTextColor];
    self.expandedReceivedAtLabel.textColor = [UIColor applicationLightGrayTextColor];
    self.expandedBodyLabel.textColor = [UIColor applicationReadLabelColor];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    [self.contentView setNeedsLayout];
    [self.contentView layoutIfNeeded];
    
    self.expandedBodyLabel.preferredMaxLayoutWidth = CGRectGetWidth(self.expandedBodyLabel.frame);
}

- (void)setExpanded:(BOOL)expanded {
    _expanded = expanded;
    
    if (expanded) {
        // expand cell
        self.expandedToLabel.hidden = NO;
        self.expandedReceivedAtLabel.hidden = NO;
        self.expandedBodyLabel.hidden = NO;
        self.expandedReplyButton.hidden = NO;
        self.receivedAtLabel.hidden = YES;
        self.bodyLabel.hidden = YES;
    }
    else {
        // collapse cell
        self.expandedToLabel.hidden = YES;
        self.expandedReceivedAtLabel.hidden = YES;
        self.expandedBodyLabel.hidden = YES;
        self.expandedReplyButton.hidden = YES;
        self.receivedAtLabel.hidden = NO;
        self.bodyLabel.hidden = NO;
    }
}

#pragma mark - Configurable Cell

- (void)configureForObject:(Message *)message {
    self.fromLabel.attributedText = [message formattedFromTextWithPrefix:NO];
    self.bodyLabel.text = message.body;
    self.expandedBodyLabel.text = message.body;
    self.expandedToLabel.text = [message formattedToText];
    
    // Set avatar image from URL
    __block NSURL *imageURL = [NSURL URLWithString:message.attachmentURLString];
    if (imageURL) {
        [[[ImageCache defaultCache] imageDownloadQueue] addOperationWithBlock:^{
            // Get image from cache
            __block UIImage *cachedImage = [[ImageCache defaultCache] imageCachedFromURL:imageURL];
            
            // Display the image
            [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                self.avatarImageView.image = cachedImage;
            }];
        }];
    }
    
    self.displayMoreButton.hidden = !message.lastMessage.boolValue;
    
    NSDate *receivedAtDate = [NSDate dateWithTimeIntervalSince1970:message.receivedAt.doubleValue];
    if (receivedAtDate) {
        self.expandedReceivedAtLabel.text = [receivedAtDate wordsExpression];
        self.receivedAtLabel.text = [receivedAtDate wordsExpression];
    }
}

@end
