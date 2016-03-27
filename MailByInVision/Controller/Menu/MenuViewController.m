//
//  MenuViewController.m
//  MailByInVision
//
//  Created by Michal Kalis on 16/03/16.
//  Copyright © 2016 Michal Kalis. All rights reserved.
//

#import "MenuViewController.h"
#import "MenuDataSource.h"
#import "MenuSectionHeaderView.h"
#import "UIColor+ApplicationSpecific.h"
#import "UITableViewHeaderFooterView+ReuseIdentifier.h"

@interface MenuViewController () <UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) MenuDataSource *menuDataSource;

@end

@implementation MenuViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupTableView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Setup

- (void)setupTableView {
    [self.tableView registerNib:[UINib nibWithNibName:@"MenuSectionHeaderView" bundle:nil] forHeaderFooterViewReuseIdentifier:[MenuSectionHeaderView automaticReuseIdentifier]];
    
    self.tableView.backgroundColor = [UIColor applicationMenuCellColor];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.contentInset = UIEdgeInsetsMake(CGRectGetHeight([UIApplication sharedApplication].statusBarFrame), 0, 0, 0);
    
    self.tableView.delegate = self;
    
    self.menuDataSource = [[MenuDataSource alloc] initWithTableView:self.tableView];
}

#pragma mark - Table View Delegate

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return [MenuSectionHeaderView heightInSection:section];
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    MenuSectionHeaderView *view = [tableView dequeueReusableHeaderFooterViewWithIdentifier:[MenuSectionHeaderView automaticReuseIdentifier]];
    
    switch (section) {
        case MenuTableSectionMailboxes: {
            view.topSection = YES;
            view.titleLabel.text = @"MAILBOXES";
            break;
        }
        case MenuTableSectionGroups: {
            view.topSection = NO;
            view.titleLabel.text = @"GROUPS";
            break;
        }
        case MenuTableSectionMarked: {
            view.topSection = NO;
            view.titleLabel.text = @"MARKED";
            break;
        }
            
        default:
            break;
    }
    
    return view;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([self.delegate respondsToSelector:@selector(didSelectMenuItemAtIndexPath:)]) {
        [self.delegate didSelectMenuItemAtIndexPath:indexPath];
    }
}

@end
