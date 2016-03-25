//
//  ArrayMapper.h
//  MailByInVision
//
//  Created by Michal Kalis on 23/03/16.
//  Copyright © 2016 Michal Kalis. All rights reserved.
//

#import "Mapper.h"

@interface ArrayMapper: NSObject <Mapper>

- (instancetype)initWithItemMapper:(id<Mapper>)itemMapper;

@end
