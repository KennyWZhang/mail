//
//  UIImage+TemplateImage.m
//  MailByInVision
//
//  Created by Michal Kalis on 17/03/16.
//  Copyright © 2016 Michal Kalis. All rights reserved.
//

#import "UIImage+TemplateImage.h"

@implementation UIImage (TemplateImage)

+ (UIImage *)templateImageWithName:(NSString *)name {
    return [[UIImage imageNamed:name] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
}

@end
