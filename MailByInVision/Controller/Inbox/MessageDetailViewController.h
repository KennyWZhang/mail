//
//  MessageDetailViewController.h
//  MailByInVision
//
//  Created by Michal Kalis on 27/03/16.
//  Copyright © 2016 Michal Kalis. All rights reserved.
//

@import UIKit;

@class Message;

@interface MessageDetailViewController : UIViewController

// Passed here via segue from `InboxViewController`
@property (nonatomic, weak) Message *message;

@end
