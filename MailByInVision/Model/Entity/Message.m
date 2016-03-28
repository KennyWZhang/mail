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

- (NSAttributedString *)formattedFromTextWithPrefix:(BOOL)prefix {
    NSString *text = @"";
    NSString *threadPrefixText = @"me, ";
    
    if (prefix && self.threadID) {
        text = threadPrefixText;
    }
    
    text = [NSString stringWithFormat:@"%@%@ %@", text, self.from.firstname, self.from.lastname];
    
    // Format text color based on message attributes
    NSMutableAttributedString *attributedText = [[NSMutableAttributedString alloc] initWithString:text];
    if (self.read) {
        [attributedText addAttribute:NSForegroundColorAttributeName value:[UIColor applicationReadLabelColor] range:NSMakeRange(0, text.length)];
    }
    else {
        [attributedText addAttribute:NSForegroundColorAttributeName value:[UIColor applicationUnreadLabelColor] range:NSMakeRange(0, text.length)];
    }
    
    if (prefix && self.threadID) {
        [attributedText addAttribute:NSForegroundColorAttributeName value:[UIColor applicationReadLabelColor] range:NSMakeRange(0, threadPrefixText.length)];
    }
    
    return attributedText;
}

- (NSString *)formattedToText {
    // For demo application using only random "to" contact
    Contact *aContact = (Contact *)self.to.anyObject;
    NSString *firstname = aContact.firstname;
    NSString *lastname = aContact.lastname;
    
    if (firstname && lastname) {
        return [NSString stringWithFormat:@"%@ %@", firstname, lastname];
    }
    else if (firstname) {
        return firstname;
    }
    else if (lastname) {
        return lastname;
    }
    
    return @"me";
}

@end
