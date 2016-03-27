//
//  UIViewController+CoreDataStack.h
//  MailByInVision
//
//  Created by Michal Kalis on 21/03/16.
//  Copyright © 2016 Michal Kalis. All rights reserved.
//

@import UIKit;

#import "CoreDataStack.h"

@interface UIViewController (CoreDataStack)

@property (nonatomic, strong) CoreDataStack *coreDataStack;

@end
