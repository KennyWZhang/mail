//
//  DataProviderUpdate.m
//  MailByInVision
//
//  Created by Michal Kalis on 25/03/16.
//  Copyright © 2016 Michal Kalis. All rights reserved.
//

#import "DataProviderUpdate.h"

@implementation DataProviderUpdate

+ (DataProviderUpdate *)dataProviderUpdate:(NSFetchedResultsChangeType)updateType indexPath:(NSIndexPath *)indexPath {
    return [self dataProviderUpdate:updateType indexPath:indexPath object:nil movedToIndexPath:nil];
}

+ (DataProviderUpdate *)dataProviderUpdate:(NSFetchedResultsChangeType)updateType indexPath:(NSIndexPath *)indexPath object:(NSManagedObject *)object {
    return [self dataProviderUpdate:updateType indexPath:indexPath object:object movedToIndexPath:nil];
}

+ (DataProviderUpdate *)dataProviderUpdate:(NSFetchedResultsChangeType)updateType indexPath:(NSIndexPath *)indexPath object:(NSManagedObject *)object movedToIndexPath:(NSIndexPath *)movedToIndexPath {
    DataProviderUpdate *update = [[DataProviderUpdate alloc] init];
    
    update.type = updateType;
    update.indexPath = indexPath;
    update.object = object;
    update.movedToIndexPath = movedToIndexPath;
    
    return update;
}

@end
