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
#import "NSIndexPath+Equality.h"
#import "UITableViewCell+ReuseIdentifier.h"

@import UIKit;

@interface MessageDetailDataSource () <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, weak) UITableView *tableView;
@property (nonatomic, strong) FetchedResultsDataProvider *dataProvider;

@property (nonatomic, strong) NSMutableSet<NSIndexPath *> *expandedRowIndexPaths;

@end

@implementation MessageDetailDataSource

- (instancetype)initWithTableView:(UITableView *)tableView dataProvider:(FetchedResultsDataProvider *)dataProvider delegate:(id<DataSourceDelegate>)delegate {
    if (self = [super init]) {
        self.tableView = tableView;
        self.dataProvider = dataProvider;
        self.delegate = delegate;
        
        self.expandedRowIndexPaths = [NSMutableSet set];
        
        tableView.dataSource = self;
        tableView.delegate = self;
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

#pragma mark - Private

- (BOOL)determineExpandedIndexPath:(NSIndexPath *)indexPath {
    __block BOOL isCellExpanded = NO;
    [self.expandedRowIndexPaths enumerateObjectsUsingBlock:^(NSIndexPath * _Nonnull expandedIndexPath, BOOL * _Nonnull stop) {
        if ([indexPath isEqualToIndexPath:expandedIndexPath]) {
            isCellExpanded = YES;
        }
    }];
    
    return isCellExpanded;
}

- (void)removeExpandedIndexPath:(NSIndexPath *)indexPath {
    NSIndexPath *indexPathToRemove = nil;
    for (NSIndexPath *expandedIndexPath in self.expandedRowIndexPaths) {
        if ([indexPath isEqualToIndexPath:expandedIndexPath]) {
            indexPathToRemove = indexPath;
            break;
        }
    }
    
    [self.expandedRowIndexPaths removeObject:indexPathToRemove];
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
    
    MessageDetailTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier forIndexPath:indexPath];
    
    [cell configureForObject:message];
    
    cell.expanded = [self determineExpandedIndexPath:indexPath];
    
    return cell;
}

#pragma mark - Table View Delegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([self determineExpandedIndexPath:indexPath]) {
        Message *message = (Message *)[self.dataProvider objectAtIndexPath:indexPath];
        NSString *identifier = [self.delegate cellIdentifierForObject:message];
        
        MessageDetailTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        
        [cell configureForObject:message];
        
        cell.bounds = CGRectMake(0.0f, 0.0f, CGRectGetWidth(tableView.bounds), CGRectGetHeight(cell.bounds));
        [cell setNeedsLayout];
        [cell layoutIfNeeded];
        
        CGFloat height = [cell.contentView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize].height;
        
        // + 1 because of separator
        height += 1;
        
        return height;
    }
    return 86;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    // Expand or collapse message
    if ([self determineExpandedIndexPath:indexPath]) {
        [self removeExpandedIndexPath:indexPath];
    }
    else {
        [self.expandedRowIndexPaths addObject:indexPath];
    }
    
    [self.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
}

@end
