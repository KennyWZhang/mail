//
//  MenuDataSource.h
//  MailByInVision
//
//  Created by Michal Kalis on 17/03/16.
//  Copyright © 2016 Michal Kalis. All rights reserved.
//

@import UIKit;

@interface MenuDataSource : NSObject <UITableViewDataSource>

// Enums
typedef NS_ENUM(NSUInteger, MenuTableSection) {
    MenuTableSectionMailboxes = 0,
    MenuTableSectionGroups,
    MenuTableSectionMarked,
    MenuTableSectionCount
};

typedef NS_ENUM(NSUInteger, TableSectionMailboxes) {
    TableSectionMailboxesInbox,
    TableSectionMailboxesSent,
    TableSectionMailboxesPinned,
    TableSectionMailboxesDrafts,
    TableSectionMailboxesTrash,
    TableSectionMailboxesCount
};


- (instancetype)initWithTableView:(UITableView *)tableView;

@end
