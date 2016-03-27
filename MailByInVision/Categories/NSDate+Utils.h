//
//  NSDate+Utils.h
//  MailByInVision
//
//  Created by Michal Kalis on 27/03/16.
//  Copyright © 2016 Michal Kalis. All rights reserved.
//

@import Foundation;

@interface NSDate (Utils)

- (NSString *)stringFromDateWithFormat:(NSString *)formatString;
- (NSString *)stringFromDateWithLongFormat;
- (NSString *)wordsExpression;

@end
