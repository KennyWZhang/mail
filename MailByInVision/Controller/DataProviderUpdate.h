//
//  DataProviderUpdate.h
//  MailByInVision
//
//  Created by Michal Kalis on 25/03/16.
//  Copyright © 2016 Michal Kalis. All rights reserved.
//

@import Foundation;
@import CoreData;

@interface DataProviderUpdate : NSObject

@property (nonatomic) NSFetchedResultsChangeType type;
@property (nonatomic, strong) NSIndexPath *indexPath;
@property (nonatomic, strong) NSIndexPath *movedToIndexPath;
@property (nonatomic, strong) NSManagedObject *object;

+ (DataProviderUpdate *)dataProviderUpdate:(NSFetchedResultsChangeType)updateType indexPath:(NSIndexPath *)indexPath;
+ (DataProviderUpdate *)dataProviderUpdate:(NSFetchedResultsChangeType)updateType indexPath:(NSIndexPath *)indexPath object:(NSManagedObject *)object;
+ (DataProviderUpdate *)dataProviderUpdate:(NSFetchedResultsChangeType)updateType indexPath:(NSIndexPath *)indexPath object:(NSManagedObject *)object movedToIndexPath:(NSIndexPath *)movedToIndexPath;

@end
