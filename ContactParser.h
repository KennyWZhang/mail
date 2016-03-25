//
//  ContactParser.h
//  MailByInVision
//
//  Created by Michal Kalis on 24/03/16.
//  Copyright © 2016 Michal Kalis. All rights reserved.
//

@import Foundation;
@import CoreData;

#import "Mapper.h"

@interface ContactParser : NSObject

+ (id<Mapper>)contactMapperWithContext:(NSManagedObjectContext *)context;

@end
