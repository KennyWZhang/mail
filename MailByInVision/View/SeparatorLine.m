//
//  SeparatorLine.m
//  MailByInVision
//
//  Created by Michal Kalis on 27/03/16.
//  Copyright © 2016 Michal Kalis. All rights reserved.
//

#import "SeparatorLine.h"
#import "UIColor+ApplicationSpecific.h"

@implementation SeparatorLine

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.backgroundColor = [UIColor applicationSeparatorLineColor];
}

@end
