//
//  ErrorIfMapper.h
//  MailByInVision
//
//  Created by Michal Kalis on 23/03/16.
//  Copyright © 2016 Michal Kalis. All rights reserved.
//

#import "Mapper.h"

@interface ErrorIfMapper: NSObject <Mapper>

- (instancetype)initWithErrorDomain:(NSString *)errorDomain errorCode:(NSInteger)errorCode userInfo:(NSDictionary *)userInfo errorIfJSONKeyExists:(NSString *)jsonKey;

@end
