//
//  SearchTextField.m
//  MailByInVision
//
//  Created by Michal Kalis on 28/03/16.
//  Copyright © 2016 Michal Kalis. All rights reserved.
//

#import "SearchTextField.h"
#import "UIColor+ApplicationSpecific.h"

@implementation SearchTextField

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super initWithCoder:aDecoder]) {
        UIButton *clearButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [clearButton setImage:[UIImage imageNamed:@"inbox-searchbar-clear-button"] forState:UIControlStateNormal];
        [clearButton addTarget:self action:@selector(clearTextField:) forControlEvents:UIControlEventTouchUpInside];
        [clearButton setFrame:CGRectMake(0, 0, 30, 30)];
        
        self.rightViewMode = UITextFieldViewModeWhileEditing;
        [self setRightView:clearButton];
        
        self.attributedPlaceholder = [[NSAttributedString alloc] initWithString:self.placeholder attributes:@{NSForegroundColorAttributeName: [UIColor applicationLightGrayTextColor]}];
    }
    
    return self;
}

- (CGRect)rightViewRectForBounds:(CGRect)bounds {
    return CGRectMake(CGRectGetWidth(bounds) - 30, 2, CGRectGetHeight(bounds), CGRectGetHeight(bounds));
}

- (void)clearTextField:(UITextField *)textField {
    [self sendActionsForControlEvents:UIControlEventEditingDidEnd];
}

@end
