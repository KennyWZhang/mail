//
//  UIColor+ApplicationSpecific.h
//  MailByInVision
//
//  Created by Michal Kalis on 17/03/16.
//  Copyright © 2016 Michal Kalis. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (ApplicationSpecific)

+ (UIColor *)applicationSeparatorLineColor;
+ (UIColor *)applicationLightGrayTextColor;
+ (UIColor *)applicationGrayTextColor;
+ (UIColor *)applicationLightGrayBackgroundColor;

+ (UIColor *)applicationMenuSectionColor;
+ (UIColor *)applicationMenuCellColor;
+ (UIColor *)applicationMenuCellSelectedColor;
+ (UIColor *)applicationMenuCellHighlightedColor;

+ (UIColor *)applicationMenuSectionTextColor;
+ (UIColor *)applicationMenuCellTextColor;

+ (UIColor *)applicationMenuMarked1Color;
+ (UIColor *)applicationMenuMarked2Color;
+ (UIColor *)applicationMenuMarked3Color;
+ (UIColor *)applicationMenuMarked4Color;

+ (UIColor *)applicationBlueColor;
+ (UIColor *)applicationUnreadLabelColor;
+ (UIColor *)applicationReadLabelColor;

@end
