//
//  DataSourceDelegate.h
//  MailByInVision
//
//  Created by Michal Kalis on 25/03/16.
//  Copyright © 2016 Michal Kalis. All rights reserved.
//

@import Foundation;

@class NSManagedObject;

@protocol DataSourceDelegate <NSObject>

- (NSString *)cellIdentifierForObject:(NSManagedObject *)object;

@optional
- (void)didSelectRowWithObject:(NSManagedObject *)object;

@end
