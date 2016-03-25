//
//  ManagedObjectMapper.h
//  MailByInVision
//
//  Created by Michal Kalis on 23/03/16.
//  Copyright © 2016 Michal Kalis. All rights reserved.
//

#import "Mapper.h"

@interface ManagedObjectMapper: NSObject <Mapper>

- (instancetype)initWithGeneratorOfClass:(Class)classOfObjectToCreate jsonKeysToFields:(NSDictionary *)jsonKeysToFields fieldsToMappers:(NSDictionary *)fieldsToMappers context:(NSManagedObjectContext *)context;

@end
