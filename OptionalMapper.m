//
//  OptionalMapper.m
//  MailByInVision
//
//  Created by Michal Kalis on 23/03/16.
//  Copyright © 2016 Michal Kalis. All rights reserved.
//

#import "OptionalMapper.h"

@interface OptionalMapper ()

@property (nonatomic) id<Mapper> mapper;

@end

@implementation OptionalMapper

- (instancetype)init {
    [self doesNotRecognizeSelector:_cmd];
    return self;
}

- (instancetype)initWithMapper:(id<Mapper>)mapper {
    if (self = [super init]) {
        self.mapper = mapper;
    }
    
    return self;
}

- (id)objectFromSourceObject:(id)jsonObject error:(__autoreleasing NSError **)error {
    NSError *originalError = nil;
    id result = [self.mapper objectFromSourceObject:jsonObject error:&originalError];
    
    if (originalError) {
        NSMutableDictionary *userInfo = [originalError.userInfo mutableCopy];
        userInfo[kIsNonFatalKey] = @YES;
        *error = [NSError errorWithDomain:originalError.domain
                                     code:originalError.code
                                 userInfo:userInfo];
    }
    
    return result;
}

@end
