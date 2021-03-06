//
//  InboxDataSource.m
//  MailByInVision
//
//  Created by Michal Kalis on 25/03/16.
//  Copyright © 2016 Michal Kalis. All rights reserved.
//

#import "InboxDataSource.h"
#import "FetchedResultsDataProvider.h"
#import "DataProviderUpdate.h"
#import "ConfigurableCell.h"
#import "DataProvider.h"
#import "Message.h"
#import "InboxTableViewCell.h"

@import UIKit;

@interface InboxDataSource () <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, weak) UITableView *tableView;
@property (nonatomic, strong) FetchedResultsDataProvider *dataProvider;

@end

@implementation InboxDataSource

- (instancetype)initWithTableView:(UITableView *)tableView dataProvider:(FetchedResultsDataProvider *)dataProvider delegate:(id<DataSourceDelegate>)delegate {
    if (self = [super init]) {
        self.tableView = tableView;
        self.dataProvider = dataProvider;
        self.delegate = delegate;
        
        tableView.delegate = self;
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

- (void)filteredMessagesUsingPredicate:(NSPredicate *)predicate {
    [self.dataProvider filteredMessagesUsingPredicate:predicate];
}

#pragma mark - Table View Data Source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.dataProvider numberOfItemsInSection:section];
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([tableView respondsToSelector:@selector(setSeparatorInset:)]) {
        [tableView setSeparatorInset:UIEdgeInsetsZero];
    }
    
    if ([tableView respondsToSelector:@selector(setLayoutMargins:)]) {
        [tableView setLayoutMargins:UIEdgeInsetsZero];
    }
    
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        [cell setLayoutMargins:UIEdgeInsetsZero];
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    Message *message = (Message *)[self.dataProvider objectAtIndexPath:indexPath];
    NSString *identifier = [self.delegate cellIdentifierForObject:message];
    
    InboxTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier forIndexPath:indexPath];
    
    [cell configureForObject:message];
    
    return cell;
}

#pragma mark - Table View Delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([self.delegate respondsToSelector:@selector(didSelectRowWithObject:)]) {
        [self.delegate didSelectRowWithObject:[self.dataProvider objectAtIndexPath:indexPath]];
    }
}

@end
