//
//  ManagedObjectMapper.m
//  MailByInVision
//
//  Created by Michal Kalis on 23/03/16.
//  Copyright © 2016 Michal Kalis. All rights reserved.
//

#import "ManagedObjectMapper.h"
#import "NSManagedObject+SafeMapping.h"
#import "NSManagedObject+CustomInit.h"
#import "AppDelegate.h"
#import "CoreDataStack.h"

@interface ManagedObjectMapper ()

@property (nonatomic) Class classOfObjectToCreate;
@property (nonatomic, copy) NSDictionary *jsonKeysToFields;
@property (nonatomic, copy) NSDictionary *fieldsToMappers;
@property (nonatomic, strong) NSManagedObjectContext *context;

@end


@implementation ManagedObjectMapper

- (instancetype)initWithGeneratorOfClass:(Class)classOfObjectToCreate jsonKeysToFields:(NSDictionary *)jsonKeysToFields fieldsToMappers:(NSDictionary *)fieldsToMappers context:(NSManagedObjectContext *)context {
    if (self = [super init]) {
        self.classOfObjectToCreate = classOfObjectToCreate;
        self.jsonKeysToFields = jsonKeysToFields;
        self.fieldsToMappers = fieldsToMappers;
        self.context = context;
    }
    return self;
}

- (id)objectFromSourceObject:(id)jsonObject error:(__autoreleasing NSError **)error {
    *error = nil;
    if (![self.classOfObjectToCreate isSubclassOfClass:[NSManagedObject class]]) {
        return nil;
    }
    
    NSManagedObject *object = [self.classOfObjectToCreate findOrCreateElementWithID:jsonObject[@"id"] inContext:self.context];
    
    // Based on keys from `jsonKeysToFields` map JSON values (if exist) to new dictionary with fields as keys and values as actual values from JSON
    NSMutableDictionary *fieldsToJSONValues = [NSMutableDictionary dictionary];
    for (id jsonKey in self.jsonKeysToFields) {
        id field = self.jsonKeysToFields[jsonKey];
        
        id value = [jsonObject valueForKeyPath:jsonKey];
        
        if (value) {
            [fieldsToJSONValues setObject:value forKey:field];
        }
    }
    
    // Safely set values from JSON to fields checked against existing managed object attributes
    BOOL valueSettingSuccess = [object safeSetValuesForKeysWithDictionary:fieldsToJSONValues beforeEachSet:^(NSString *key, id value) {
        id<Mapper> valueMapper = self.fieldsToMappers[key];
        if (valueMapper) {
            return [valueMapper objectFromSourceObject:value error:error];
        }
        
        return value;
    }];
    
    // In case there's a non-optional attribute missing value in JSON, skip creating the object
    if (!valueSettingSuccess) {
        return nil;
    }
    
    if (*error) {
        return nil;
    }
    
    return object;
}

@end
