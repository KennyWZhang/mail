//
//  InboxDataSource.h
//  MailByInVision
//
//  Created by Michal Kalis on 25/03/16.
//  Copyright © 2016 Michal Kalis. All rights reserved.
//

#import "DataSourceDelegate.h"

@import UIKit;

@class FetchedResultsDataProvider;
@class DataProviderUpdate;
@class Message;

@interface InboxDataSource : NSObject

@property (nonatomic, weak) id<DataSourceDelegate> delegate;

- (instancetype)initWithTableView:(UITableView *)tableView dataProvider:(FetchedResultsDataProvider *)dataProvider delegate:(id<DataSourceDelegate>)delegate;

- (void)processUpdates:(NSArray<DataProviderUpdate *> *)updates;

- (void)filteredMessagesUsingPredicate:(NSPredicate *)predicate;

@end
