//
//  FetchedResultsDataProvider.h
//  MailByInVision
//
//  Created by Michal Kalis on 25/03/16.
//  Copyright © 2016 Michal Kalis. All rights reserved.
//

#import "DataProvider.h"

@import Foundation;
@import CoreData;

@class DataProviderUpdate;

@protocol DataProviderDelegate <NSObject>

- (void)dataProviderDidUpdateWithUpdates:(NSArray<DataProviderUpdate *> *)updates;

@end

@interface FetchedResultsDataProvider : NSObject <NSFetchedResultsControllerDelegate, DataProvider>

- (instancetype)initWithFetchedResultsController:(NSFetchedResultsController *)fetchedResultsController delegate:(id<DataProviderDelegate>)delegate;

@property (nonatomic, weak) id<DataProviderDelegate> delegate;

@end
