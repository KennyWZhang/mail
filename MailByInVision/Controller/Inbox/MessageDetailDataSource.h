//
//  MessageDetailDataSource.h
//  MailByInVision
//
//  Created by Michal Kalis on 27/03/16.
//  Copyright © 2016 Michal Kalis. All rights reserved.
//

#import "DataSourceDelegate.h"

@import UIKit;

@class FetchedResultsDataProvider;
@class DataProviderUpdate;

@interface MessageDetailDataSource : NSObject

@property (nonatomic, weak) id<DataSourceDelegate> delegate;

- (instancetype)initWithTableView:(UITableView *)tableView dataProvider:(FetchedResultsDataProvider *)dataProvider delegate:(id<DataSourceDelegate>)delegate;

- (void)processUpdates:(NSArray<DataProviderUpdate *> *)updates;

@end
