//
//  MessageDetailAttachmentFooterView.h
//  MailByInVision
//
//  Created by Michal Kalis on 27/03/16.
//  Copyright © 2016 Michal Kalis. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MessageDetailAttachmentFooterView : UIView

@property (weak, nonatomic) IBOutlet UILabel *numberOfAttachmentsLabel;
@property (weak, nonatomic) IBOutlet UILabel *attachmentFilenameLabel;

@end
