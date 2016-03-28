//
//  MessageDetailBottomView.h
//  MailByInVision
//
//  Created by Michal Kalis on 27/03/16.
//  Copyright © 2016 Michal Kalis. All rights reserved.
//

@import UIKit;

@interface MessageDetailBottomView : UIView

@property (weak, nonatomic) IBOutlet UIButton *replyButton;
@property (weak, nonatomic) IBOutlet UIButton *forwardButton;
@property (weak, nonatomic) IBOutlet UIView *leftContainerView;
@property (weak, nonatomic) IBOutlet UIView *rightContainerView;

@end
