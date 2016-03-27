//
//  NSManagedObject+SafeMapping.h
//  MailByInVision
//
//  Created by Michal Kalis on 24/03/16.
//  Copyright © 2016 Michal Kalis. All rights reserved.
//

@import CoreData;

@interface NSManagedObject (SafeMapping)

- (BOOL)safeSetValuesForKeysWithDictionary:(NSDictionary * _Nonnull)keyedValues beforeEachSet:(_Nullable id (^_Nullable)(NSString * _Nonnull key, id _Nullable value))beforeEach;

@end
