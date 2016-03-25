//
//  SetMapper.h
//  MailByInVision
//
//  Created by Michal Kalis on 25/03/16.
//  Copyright © 2016 Michal Kalis. All rights reserved.
//

#import "Mapper.h"

@interface SetMapper : NSObject <Mapper>

- (instancetype)initWithItemMapper:(id<Mapper>)itemMapper;

@end
