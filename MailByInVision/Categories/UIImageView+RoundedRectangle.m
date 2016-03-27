//
//  UIImageView+RoundedRectangle.m
//  MailByInVision
//
//  Created by Michal Kalis on 17/03/16.
//  Copyright © 2016 Michal Kalis. All rights reserved.
//

#import "UIImageView+RoundedRectangle.h"

@implementation UIImageView (RoundedRectangle)

- (UIImage *)roundedRectangleImageWithColor:(UIColor *)color {
    UIGraphicsBeginImageContext(self.bounds.size);
    
    UIGraphicsGetCurrentContext();
    
    [color setFill];
    
    UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:CGRectInset(self.bounds, 2, 2) cornerRadius:3];
    [path fill];
    
    // make image out of bitmap context
    UIImage *retImage = UIGraphicsGetImageFromCurrentImageContext();
    
    // free the context
    UIGraphicsEndImageContext();
    
    return retImage;
}

@end
