//
//  MessageDetailViewController.m
//  MailByInVision
//
//  Created by Michal Kalis on 27/03/16.
//  Copyright © 2016 Michal Kalis. All rights reserved.
//

#import "MessageDetailViewController.h"
#import "UIViewController+CoreDataStack.h"
#import "FetchedResultsDataProvider.h"
#import "MessageDetailDataSource.h"
#import "NSManagedObject+CustomInit.h"
#import "DataSourceDelegate.h"
#import "MessageDetailTableViewCell.h"
#import "UITableViewCell+ReuseIdentifier.h"
#import "Message.h"
#import "MessageDetailHeaderView.h"
#import "MessageDetailAttachmentFooterView.h"
#import "UIColor+ApplicationSpecific.h"

@interface MessageDetailViewController () <DataProviderDelegate, DataSourceDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet MessageDetailAttachmentFooterView *attachmentFooterView;
@property (weak, nonatomic) IBOutlet MessageDetailHeaderView *subjectHeaderView;

@property (nonatomic, strong) MessageDetailDataSource *dataSource;

@end

@implementation MessageDetailViewController

#pragma mark - View Lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupTableView];
    
    [self addNavigationBarButtons];
    
    [self setupHeaderAndFooterViews];
}

#pragma mark - Private

- (void)setupTableView {
    // UI customisation
    self.tableView.contentInset = UIEdgeInsetsMake(-6, 0, 0, 0);
    self.tableView.separatorColor = [UIColor applicationSeparatorLineColor];
    self.tableView.separatorInset = UIEdgeInsetsZero;
    self.tableView.preservesSuperviewLayoutMargins = NO;
    self.tableView.layoutMargins = UIEdgeInsetsZero;
    
    // Data provider & data source
    NSFetchRequest *request = [[NSFetchRequest alloc] initWithEntityName:[Message entityName]];
    request.sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:@"receivedAt" ascending:true]];
    
    NSPredicate *predicate = nil;
    if (self.message.threadID) {
        predicate = [NSPredicate predicateWithFormat:@"threadID = %@", self.message.threadID];
    }
    else {
        predicate = [NSPredicate predicateWithFormat:@"remoteID = %@", self.message.remoteID];
    }
    request.predicate = predicate;
    request.returnsObjectsAsFaults = NO;
    NSFetchedResultsController *frc = [[NSFetchedResultsController alloc] initWithFetchRequest:request managedObjectContext:self.coreDataStack.mainContext sectionNameKeyPath:nil cacheName:nil];
    FetchedResultsDataProvider *dataProvider = [[FetchedResultsDataProvider alloc] initWithFetchedResultsController:frc delegate:self];
    self.dataSource = [[MessageDetailDataSource alloc] initWithTableView:self.tableView dataProvider:dataProvider delegate:self];
}

- (void)addNavigationBarButtons {
    UIBarButtonItem *downloadButton = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"message-download-button"] style:UIBarButtonItemStylePlain target:nil action:nil];
    UIBarButtonItem *trashButton = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"message-trash-button"] style:UIBarButtonItemStylePlain target:nil action:nil];
    UIBarButtonItem *moreButton = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"message-more-button"] style:UIBarButtonItemStylePlain target:nil action:nil];
    self.navigationItem.rightBarButtonItems = @[moreButton, trashButton, downloadButton];
}

- (void)setupHeaderAndFooterViews {
    // Subject header view
    self.subjectHeaderView.subjectLabel.text = self.message.subject;
    
    // Attachment footer view
    if (self.message.attachmentURLString) {
        // For demo purposes using only single attachment, hence no `Attachment` object. Otherwise the footer view should contain a table view of its own.
        self.attachmentFooterView.numberOfAttachmentsLabel.text = @"1 Attachment";
        [self.attachmentFooterView.attachmentFilenameButton setTitle:self.message.attachmentName forState:UIControlStateNormal];
    }
    else {
        // Hides empty cells
        UIView *footerView = [[UIView alloc] initWithFrame:CGRectZero];
        self.tableView.tableFooterView = footerView;
    }
}

#pragma mark - Data Source Delegate

- (NSString *)cellIdentifierForObject:(NSManagedObject *)object {
    return [MessageDetailTableViewCell automaticReuseIdentifier];
}

#pragma mark - Data Provider Delegate

- (void)dataProviderDidUpdateWithUpdates:(NSArray<DataProviderUpdate *> *)updates {
    [self.dataSource processUpdates:updates];
}

@end
