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
#import "SearchTextField.h"

@interface InboxViewController () <DataProviderDelegate, DataSourceDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;
@property (nonatomic, strong) InboxDataSource *dataSource;

// Search
@property (weak, nonatomic) IBOutlet UIView *searchContainerView;
@property (weak, nonatomic) IBOutlet SearchTextField *searchTextField;
@property (weak, nonatomic) IBOutlet UIImageView *searchIcon;
@property (nonatomic, strong) NSCompoundPredicate *messagesPredicate;

@end

@implementation InboxViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"Inbox";
    
    [self setupTableView];
    
    [self customizeUI];
    
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

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    [self.view endEditing:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Private

- (void)customizeUI {
    self.searchContainerView.backgroundColor = [UIColor applicationLightGrayBackgroundColor];
    
    UIImage *image = [[UIImage imageNamed:@"inbox-new-message-icon"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UIBarButtonItem *button = [[UIBarButtonItem alloc] initWithImage:image style:UIBarButtonItemStylePlain target:nil action:nil];
    [button setImageInsets:UIEdgeInsetsMake(0, -7, 0, 7)];
    self.navigationItem.rightBarButtonItem = button;
}

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
    NSPredicate *singleMessagePredicate = [NSPredicate predicateWithFormat:@"threadID = nil"];
    NSPredicate *lastMessageInThreadPredicate = [NSPredicate predicateWithFormat:@"lastMessage == YES"];
    self.messagesPredicate = [NSCompoundPredicate orPredicateWithSubpredicates:@[singleMessagePredicate, lastMessageInThreadPredicate]];
    request.predicate = self.messagesPredicate;
    
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
    [self.activityIndicator stopAnimating];
    self.tableView.hidden = NO;
    
    [self.dataSource processUpdates:updates];
}

- (void)didSelectRowWithObject:(NSManagedObject *)object {
    MessageDetailViewController *controller = [[UIStoryboard storyboardWithName:@"Inbox" bundle:nil] instantiateViewControllerWithIdentifier:@"MessageDetailViewController"];
    
    controller.message = (Message *)object;
    controller.coreDataStack = self.coreDataStack;
    
    [self.navigationController pushViewController:controller animated:true];
}

#pragma mark - Search

- (void)filterContentForSearchText:(NSString *)searchText {
    // Actual search predicates
    NSPredicate *bodyPredicate = [NSPredicate predicateWithFormat:@"body contains[c] %@", searchText];
    NSPredicate *subjectPredicate = [NSPredicate predicateWithFormat:@"subject contains[c] %@", searchText];
    NSPredicate *fromFirstnamePredicate = [NSPredicate predicateWithFormat:@"from.firstname contains[c] %@", searchText];
    NSPredicate *fromLastnamePredicate = [NSPredicate predicateWithFormat:@"from.lastname contains[c] %@", searchText];
    NSCompoundPredicate *searchPredicate = [NSCompoundPredicate orPredicateWithSubpredicates:@[bodyPredicate, subjectPredicate, fromFirstnamePredicate, fromLastnamePredicate]];
    
    // Combine search predicates with default messages predicate used to filter out unneccessary messages from threads
    NSCompoundPredicate *compoundPredicate = searchText.length > 0 ? [NSCompoundPredicate andPredicateWithSubpredicates:@[self.messagesPredicate, searchPredicate]] : self.messagesPredicate;
    
    [self.dataSource filteredMessagesUsingPredicate:compoundPredicate];
}

- (IBAction)textFieldValueChanged:(UITextField *)textField {
    // Search and reload data source
    [self filterContentForSearchText:textField.text];
    [self.tableView reloadData];
}

- (IBAction)textFieldEditingDidEnd:(UITextField *)sender {
    self.searchIcon.image = [UIImage imageNamed:@"inbox-search-icon"];
    [self cancelSearch];
    
    self.searchContainerView.layer.masksToBounds = YES;
}

- (IBAction)textFieldEditingDidBegin:(UITextField *)sender {
    self.searchIcon.image = [UIImage imageNamed:@"inbox-search-icon-active"];
    
    self.searchContainerView.layer.masksToBounds = NO;
    self.searchContainerView.layer.shadowColor = [UIColor blackColor].CGColor;
    self.searchContainerView.layer.shadowOffset = CGSizeMake(0, 1);
    self.searchContainerView.layer.shadowRadius = 2;
    self.searchContainerView.layer.shadowOpacity = 0.3;
}

- (void)cancelSearch {
    [self filterContentForSearchText:@""];
    [self.view endEditing:YES];
    self.searchTextField.text  = @"";
    
    [self.tableView reloadData];
}

@end
