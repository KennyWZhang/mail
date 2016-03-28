//
//  InboxViewController.m
//  MailByInVision
//
//  Created by Michal Kalis on 16/03/16.
//  Copyright © 2016 Michal Kalis. All rights reserved.
//

#import "InboxViewController.h"
#import "MessageService.h"
#import "UIViewController+CoreDataStack.h"
#import "FetchedResultsDataProvider.h"
#import "InboxDataSource.h"
#import "Message.h"
#import "NSManagedObject+CustomInit.h"
#import "DataSourceDelegate.h"
#import "InboxTableViewCell.h"
#import "UITableViewCell+ReuseIdentifier.h"
#import "MessageDetailViewController.h"
#import "UIColor+ApplicationSpecific.h"

@interface InboxViewController () <DataProviderDelegate, DataSourceDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) InboxDataSource *dataSource;

@end

@implementation InboxViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"Inbox";
    
    [self setupTableView];
    
    [MessageService fetchAllMessagesWithCoreDataStack:self.coreDataStack requestResult:^(NSArray *messages, NSError *error) {
        NSLog(@"messages %@", messages);
    }];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    // Unselect the selected row if any
    NSIndexPath *selection = self.tableView.indexPathForSelectedRow;
    if (selection) {
        [self.tableView deselectRowAtIndexPath:selection animated:YES];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Private

- (void)setupTableView {
    // UI customisation
    self.tableView.separatorColor = [UIColor applicationSeparatorLineColor];
    self.tableView.separatorInset = UIEdgeInsetsZero;
    self.tableView.preservesSuperviewLayoutMargins = NO;
    self.tableView.layoutMargins = UIEdgeInsetsZero;
    
    // Data provider & data source
    NSFetchRequest *request = [[NSFetchRequest alloc] initWithEntityName:[Message entityName]];
    request.sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:@"receivedAt" ascending:false]];
    // Fetch only message that are not part of a thread or only the newest message in a thread
    NSPredicate *singleMessage = [NSPredicate predicateWithFormat:@"threadID = nil"];
    NSPredicate *lastMessageInThread = [NSPredicate predicateWithFormat:@"lastMessage == YES"];
    request.predicate = [NSCompoundPredicate orPredicateWithSubpredicates:@[singleMessage, lastMessageInThread]];
    request.returnsObjectsAsFaults = NO;
    request.fetchBatchSize = 40;
    NSFetchedResultsController *frc = [[NSFetchedResultsController alloc] initWithFetchRequest:request managedObjectContext:self.coreDataStack.mainContext sectionNameKeyPath:nil cacheName:nil];
    FetchedResultsDataProvider *dataProvider = [[FetchedResultsDataProvider alloc] initWithFetchedResultsController:frc delegate:self];
    self.dataSource = [[InboxDataSource alloc] initWithTableView:self.tableView dataProvider:dataProvider delegate:self];
}

#pragma mark - Data Source Delegate

- (NSString *)cellIdentifierForObject:(NSManagedObject *)object {
    return [InboxTableViewCell automaticReuseIdentifier];
}

#pragma mark - Data Provider Delegate

- (void)dataProviderDidUpdateWithUpdates:(NSArray<DataProviderUpdate *> *)updates {
    [self.dataSource processUpdates:updates];
}

- (void)didSelectRowWithObject:(NSManagedObject *)object {
    MessageDetailViewController *controller = [[UIStoryboard storyboardWithName:@"Inbox" bundle:nil] instantiateViewControllerWithIdentifier:@"MessageDetailViewController"];
    
    controller.message = (Message *)object;
    controller.coreDataStack = self.coreDataStack;
    
    [self.navigationController pushViewController:controller animated:true];
}

@end
