//
//  NSManagedObject+SafeMapping.m
//  MailByInVision
//
//  Created by Michal Kalis on 24/03/16.
//  Copyright © 2016 Michal Kalis. All rights reserved.
//

#import "NSManagedObject+SafeMapping.h"

@implementation NSManagedObject (SafeMapping)

- (BOOL)safeSetValuesForKeysWithDictionary:(NSDictionary * _Nonnull)keyedValues beforeEachSet:(_Nullable id (^_Nullable)(NSString *  _Nonnull key, id _Nullable value))beforeEach {
    NSDictionary *attributes = [[self entity] attributesByName];
    
    for (NSString *attributeKey in attributes) {
        id value = [keyedValues objectForKey:attributeKey];
        
        NSAttributeDescription *attributeDescription = [attributes objectForKey:attributeKey];
        
        // If attribute is not optional, has no default value and there's no value in JSON, object creation is stopped
        if (value == nil && attributeDescription.defaultValue == nil && ![attributeDescription isOptional]) {
            return NO;
        }
        
        NSAttributeType attributeType = [attributeDescription attributeType];
        if ((attributeType == NSStringAttributeType) && ([value isKindOfClass:[NSNumber class]])) {
            value = [value stringValue];
        }
        else if (((attributeType == NSInteger16AttributeType) || (attributeType == NSInteger32AttributeType) || (attributeType == NSInteger64AttributeType) || (attributeType == NSBooleanAttributeType)) && ([value isKindOfClass:[NSString class]])) {
            value = [NSNumber numberWithInteger:[value  integerValue]];
        }
        else if ((attributeType == NSFloatAttributeType) && ([value isKindOfClass:[NSString class]])) {
            value = [NSNumber numberWithDouble:[value doubleValue]];
        }
        
        // Give a chance to adjust value before setting it
        if (beforeEach) {
            beforeEach(attributeKey, value);
        }
        
        [self setValue:value forKey:attributeKey];
    }
    
    NSDictionary *relations = [[self entity] relationshipsByName];
    
    for (NSString *relationKey in relations) {
        id value = [keyedValues objectForKey:relationKey];
        
        NSRelationshipDescription *relationDescription = [relations objectForKey:relationKey];
        
        // If relation is not optional and there's no value in JSON, object creation is stopped
        if (value == nil && ![relationDescription isOptional]) {
            return NO;
        }
        
        // Give a chance to adjust value before setting it
        if (beforeEach) {
            value = beforeEach(relationKey, value);
        }
        
        [self setValue:value forKey:relationKey];
    }
    
    return YES;
}

@end
