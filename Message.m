//
//  Message.m
//  MailByInVision
//
//  Created by Michal Kalis on 20/03/16.
//  Copyright © 2016 Michal Kalis. All rights reserved.
//

#import "Message.h"
#import "Contact.h"
#import "Group.h"
#import "Mark.h"
#import "UIColor+ApplicationSpecific.h"

@implementation Message

- (NSAttributedString *)formattedFromText {
    NSString *text = @"";
    
    if (self.threadID) {
        text = @"me, ";
    }
    
    text = [NSString stringWithFormat:@"%@%@ %@", text, self.from.firstname, self.from.lastname];
    
    // Format text color based on message attributes
    NSMutableAttributedString *attributedText = [[NSMutableAttributedString alloc] initWithString:text];
    if (self.read) {
        [attributedText addAttribute:NSForegroundColorAttributeName value:[UIColor applicationReadLabel] range:NSMakeRange(0, text.length - 1)];
    }
    else {
        [attributedText addAttribute:NSForegroundColorAttributeName value:[UIColor applicationUnreadLabel] range:NSMakeRange(0, text.length - 1)];
    }
    
    if (self.threadID) {
        [attributedText addAttribute:NSForegroundColorAttributeName value:[UIColor applicationReadLabel] range:NSMakeRange(0, 3)];
    }
    
    return attributedText;
}

@end
