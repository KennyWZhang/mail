//
//  UIColor+Hex.h
//  MailByInVision
//
//  Created by Michal Kalis on 17/03/16.
//  Copyright © 2016 Michal Kalis. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (Hex)

/**
 *  Assumes input like "#00FF00" (#RRGGBB).
 *
 *  @param hexString Input hex value with "#" prefix
 *
 *  @return UIColor representation
 */
+ (UIColor *)colorWithHexString:(NSString *)hexString;

@end
