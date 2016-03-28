//
//  MessageDetailDataSource.m
//  MailByInVision
//
//  Created by Michal Kalis on 27/03/16.
//  Copyright © 2016 Michal Kalis. All rights reserved.
//

#import "MessageDetailDataSource.h"
#import "FetchedResultsDataProvider.h"
#import "DataProviderUpdate.h"
#import "ConfigurableCell.h"
#import "DataProvider.h"
#import "Message.h"
#import "MessageDetailTableViewCell.h"

@import UIKit;

@interface MessageDetailDataSource () <UITableViewDataSource>

@property (nonatomic, weak) UITableView *tableView;
@property (nonatomic, strong) FetchedResultsDataProvider *dataProvider;

@end

@implementation MessageDetailDataSource

- (instancetype)initWithTableView:(UITableView *)tableView dataProvider:(FetchedResultsDataProvider *)dataProvider delegate:(id<DataSourceDelegate>)delegate {
    if (self = [super init]) {
        self.tableView = tableView;
        self.dataProvider = dataProvider;
        self.delegate = delegate;
        
        tableView.dataSource = self;
        [tableView reloadData];
    }
    
    return self;
}

- (void)processUpdates:(NSArray<DataProviderUpdate *> *)updates {
    if (!updates) {
        [self.tableView reloadData];
    }
    
    [self.tableView beginUpdates];
    
    for (DataProviderUpdate *update in updates) {
        switch (update.type) {
            case NSFetchedResultsChangeInsert: {
                [self.tableView insertRowsAtIndexPaths:@[update.indexPath] withRowAnimation:UITableViewRowAnimationFade];
                break;
            }
            case NSFetchedResultsChangeUpdate: {
                UITableViewCell<ConfigurableCell> *cell = [self.tableView cellForRowAtIndexPath:update.indexPath];
                
                if (!cell) {
                    break;
                }
                
                [cell configureForObject:update.object];
                
                break;
            }
            case NSFetchedResultsChangeMove: {
                [self.tableView deleteRowsAtIndexPaths:@[update.indexPath] withRowAnimation:UITableViewRowAnimationFade];
                [self.tableView insertRowsAtIndexPaths:@[update.movedToIndexPath] withRowAnimation:UITableViewRowAnimationFade];
                break;
            }
            case NSFetchedResultsChangeDelete: {
                [self.tableView deleteRowsAtIndexPaths:@[update.indexPath] withRowAnimation:UITableViewRowAnimationFade];
                break;
            }
                
            default:
                break;
        }
    }
    
    [self.tableView endUpdates];
}

#pragma mark - Table View Data Source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.dataProvider numberOfItemsInSection:section];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    Message *message = (Message *)[self.dataProvider objectAtIndexPath:indexPath];
    NSString *identifier = [self.delegate cellIdentifierForObject:message];
    
    MessageDetailTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier forIndexPath:indexPath];
    
    [cell configureForObject:message];
    
    return cell;
}

@end
