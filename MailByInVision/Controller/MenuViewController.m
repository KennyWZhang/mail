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

@interface MenuViewController ()

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
    
    self.menuDataSource = [[MenuDataSource alloc] initWithTableView:self.tableView];
}

@end
