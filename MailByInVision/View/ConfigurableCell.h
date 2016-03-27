//
//  ConfigurableCell.h
//  MailByInVision
//
//  Created by Michal Kalis on 25/03/16.
//  Copyright © 2016 Michal Kalis. All rights reserved.
//

@import Foundation;

@class NSManagedObject;

@protocol ConfigurableCell <NSObject>

- (void)configureForObject:(NSManagedObject *)object;

@end
