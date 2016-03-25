//
//  InboxTableViewCell.h
//  MailByInVision
//
//  Created by Michal Kalis on 25/03/16.
//  Copyright © 2016 Michal Kalis. All rights reserved.
//

#import "ConfigurableCell.h"

@import UIKit;

@interface InboxTableViewCell : UITableViewCell <ConfigurableCell>

@property (weak, nonatomic) IBOutlet UILabel *subjectLabel;

@end
