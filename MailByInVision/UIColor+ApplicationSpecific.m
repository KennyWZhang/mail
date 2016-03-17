//
//  UIColor+ApplicationSpecific.m
//  MailByInVision
//
//  Created by Michal Kalis on 17/03/16.
//  Copyright © 2016 Michal Kalis. All rights reserved.
//

#import "UIColor+ApplicationSpecific.h"
#import "UIColor+Hex.h"

@implementation UIColor (ApplicationSpecific)

+ (UIColor *)applicationMenuSectionColor {
    return [UIColor colorWithHexString:@"#3B3841"];
}

+ (UIColor *)applicationMenuCellColor {
    return [UIColor colorWithHexString:@"#35313A"];
}

+ (UIColor *)applicationMenuCellSelectedColor {
    return [UIColor colorWithHexString:@"#3D8BFA"];
}

+ (UIColor *)applicationMenuCellHighlightedColor {
    return [UIColor colorWithHexString:@"#9EC0F8"];
}

+ (UIColor *)applicationMenuSectionTextColor {
    return [UIColor colorWithHexString:@"#7A7482"];
}

+ (UIColor *)applicationMenuCellTextColor {
    return [UIColor colorWithHexString:@"#9F98AA"];
}

+ (UIColor *)applicationMenuMarked1 {
    return [UIColor colorWithHexString:@"#FF634C"];
}

+ (UIColor *)applicationMenuMarked2 {
    return [UIColor colorWithHexString:@"#4CD6FF"];
}

+ (UIColor *)applicationMenuMarked3 {
    return [UIColor colorWithHexString:@"#9B4CFF"];
}

+ (UIColor *)applicationMenuMarked4 {
    return [UIColor colorWithHexString:@"#F8FF4C"];
}

@end
