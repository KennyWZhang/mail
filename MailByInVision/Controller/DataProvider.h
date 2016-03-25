//
//  DataProvider.h
//  MailByInVision
//
//  Created by Michal Kalis on 25/03/16.
//  Copyright © 2016 Michal Kalis. All rights reserved.
//

@import Foundation;

@class NSManagedObject;

@protocol DataProvider <NSObject>

- (NSManagedObject *)objectAtIndexPath:(NSIndexPath *)indexPath;
- (NSInteger)numberOfItemsInSection:(NSInteger)section;

@end
