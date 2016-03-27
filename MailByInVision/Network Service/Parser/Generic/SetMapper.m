//
//  SetMapper.m
//  MailByInVision
//
//  Created by Michal Kalis on 25/03/16.
//  Copyright © 2016 Michal Kalis. All rights reserved.
//

#import "SetMapper.h"

@interface SetMapper ()

@property (nonatomic) id<Mapper> itemMapper;

@end

@implementation SetMapper

- (instancetype)init {
    [self doesNotRecognizeSelector:_cmd];
    return nil;
}

- (instancetype)initWithItemMapper:(id<Mapper>)itemMapper {
    if (self = [super init]) {
        self.itemMapper = itemMapper;
    }
    return self;
}

- (id)objectFromSourceObject:(id)jsonObject error:(__autoreleasing NSError **)error {
    NSMutableSet *transformedItems = [NSMutableSet set];
    NSError *itemError = nil;
    
    // If expected array in JSON is not existent, wrap the JSON object into array
    if (![jsonObject isKindOfClass:[NSArray class]]) {
        id object = [self.itemMapper objectFromSourceObject:jsonObject error:&itemError];
        
        if (itemError) {
            *error = itemError;
            return nil;
        }
        
        return [NSSet setWithObject:object];
    }
    
    // Normal handling of array/set
    for (id item in jsonObject) {
        id transformedItem = [self.itemMapper objectFromSourceObject:item error:&itemError];
        
        if (itemError && ![itemError.userInfo[kIsNonFatalKey] boolValue]) {
            *error = itemError;
            return nil;
        }
        else if (!itemError) {
            [transformedItems addObject:transformedItem];
        }
    }
    return transformedItems;
}

@end
