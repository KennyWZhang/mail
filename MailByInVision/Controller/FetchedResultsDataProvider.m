//
//  FetchedResultsDataProvider.m
//  MailByInVision
//
//  Created by Michal Kalis on 25/03/16.
//  Copyright © 2016 Michal Kalis. All rights reserved.
//

#import "FetchedResultsDataProvider.h"
#import "DataProviderUpdate.h"
#import "DataProviderUpdate.h"

@interface FetchedResultsDataProvider ()

@property (nonatomic, strong) NSFetchedResultsController *fetchedResultsController;
@property (nonatomic, strong) NSMutableArray<DataProviderUpdate *> *updates;

@end

@implementation FetchedResultsDataProvider

- (instancetype)initWithFetchedResultsController:(NSFetchedResultsController *)fetchedResultsController delegate:(id<DataProviderDelegate>)delegate {
    if (self = [super init]) {
        self.fetchedResultsController = fetchedResultsController;
        self.delegate = delegate;
        fetchedResultsController.delegate = self;
        
        NSError *error = nil;
        [fetchedResultsController performFetch:&error];
#warning TODO handle error
    }
    
    return self;
}

- (NSManagedObject *)objectAtIndexPath:(NSIndexPath *)indexPath {
    NSManagedObject *object = [self.fetchedResultsController objectAtIndexPath:indexPath];
    
    return object;
}

- (NSInteger)numberOfItemsInSection:(NSInteger)section {
     id<NSFetchedResultsSectionInfo> sectionInfo = self.fetchedResultsController.sections[section];
    return [sectionInfo numberOfObjects];
}

#pragma mark - Fetched Results Controller Delegate

- (void)controllerWillChangeContent:(NSFetchedResultsController *)controller {
    self.updates = [NSMutableArray array];
}

- (void)controller:(NSFetchedResultsController *)controller didChangeObject:(id)anObject atIndexPath:(NSIndexPath *)indexPath forChangeType:(NSFetchedResultsChangeType)type newIndexPath:(NSIndexPath *)newIndexPath {
    switch (type) {
        case NSFetchedResultsChangeUpdate: {
            [self.updates addObject:[DataProviderUpdate dataProviderUpdate:type indexPath:indexPath object:anObject]];
            break;
        }
        case NSFetchedResultsChangeMove: {
            [self.updates addObject:[DataProviderUpdate dataProviderUpdate:type indexPath:indexPath object:anObject movedToIndexPath:newIndexPath]];
            break;
        }
            
        default: {
            [self.updates addObject:[DataProviderUpdate dataProviderUpdate:type indexPath:indexPath]];
            break;
        }
    }
}

- (void)controllerDidChangeContent:(NSFetchedResultsController *)controller {
    if ([self.delegate respondsToSelector:@selector(dataProviderDidUpdateWithUpdates:)]) {
        [self.delegate dataProviderDidUpdateWithUpdates:self.updates];
    }
}

@end
