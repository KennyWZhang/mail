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

// Global

+ (UIColor *)applicationSeparatorLineColor {
    return [UIColor colorWithHexString:@"#E2E2E2"];
}

+ (UIColor *)applicationLightGrayTextColor {
    return [UIColor colorWithHexString:@"#B7B7B7"];
}

+ (UIColor *)applicationGrayTextColor {
    return [UIColor colorWithHexString:@"#A4A4A4"];
}

+ (UIColor *)applicationLightGrayBackgroundColor {
    return [UIColor colorWithHexString:@"#F9F9F9"];
}

// Menu

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

+ (UIColor *)applicationMenuMarked1Color {
    return [UIColor colorWithHexString:@"#FF634C"];
}

+ (UIColor *)applicationMenuMarked2Color {
    return [UIColor colorWithHexString:@"#4CD6FF"];
}

+ (UIColor *)applicationMenuMarked3Color {
    return [UIColor colorWithHexString:@"#9B4CFF"];
}

+ (UIColor *)applicationMenuMarked4Color {
    return [UIColor colorWithHexString:@"#F8FF4C"];
}

// Inbox

+ (UIColor *)applicationBlueColor {
    return [UIColor colorWithHexString:@"#79BFFF"];
}

+ (UIColor *)applicationUnreadLabelColor {
    return [UIColor colorWithHexString:@"#444444"];
}

+ (UIColor *)applicationReadLabelColor {
    return [UIColor colorWithHexString:@"#6C6D6D"];
}


@end
