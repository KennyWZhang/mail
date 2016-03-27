//
//  ArrayMapper.m
//  MailByInVision
//
//  Created by Michal Kalis on 23/03/16.
//  Copyright © 2016 Michal Kalis. All rights reserved.
//

#import "ArrayMapper.h"

@interface ArrayMapper ()

@property (nonatomic) id<Mapper> itemMapper;

@end

@implementation ArrayMapper

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
    NSMutableArray *transformedItems = [NSMutableArray array];
    NSError *itemError = nil;
    
    // If expected array in JSON is not existent, wrap the JSON object into set
    if (![jsonObject isKindOfClass:[NSArray class]]) {
        id object = [self.itemMapper objectFromSourceObject:jsonObject error:&itemError];
        
        if (itemError) {
            *error = itemError;
            return nil;
        }
        
        return [NSArray arrayWithObject:object];
    }
    
    // Normal handling of array/set
    for (id item in jsonObject) {
        NSError *itemError = nil;
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
