//
//  MessageDetailTableViewCell.h
//  MailByInVision
//
//  Created by Michal Kalis on 27/03/16.
//  Copyright © 2016 Michal Kalis. All rights reserved.
//

#import "ConfigurableCell.h"

@import UIKit;

@interface MessageDetailTableViewCell : UITableViewCell <ConfigurableCell>

@property (weak, nonatomic) IBOutlet UIImageView *avatarImageView;
@property (weak, nonatomic) IBOutlet UILabel *fromLabel;
@property (weak, nonatomic) IBOutlet UILabel *expandedToLabel;
@property (weak, nonatomic) IBOutlet UILabel *expandedReceivedAtLabel;
@property (weak, nonatomic) IBOutlet UILabel *bodyLabel;
@property (weak, nonatomic) IBOutlet UILabel *expandedBodyLabel;
@property (weak, nonatomic) IBOutlet UILabel *receivedAtLabel;
@property (weak, nonatomic) IBOutlet UIButton *expandedReplyButton;
@property (weak, nonatomic) IBOutlet UIButton *displayMoreButton;

@property (nonatomic, getter = isExpanded) BOOL expanded;

@end
