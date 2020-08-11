//
//  UIImageView+Extension.m
//  Coffee
//
//  Created by 罗浩 on 2019/3/28.
//  Copyright © 2019 nado. All rights reserved.
//

#import "UIImageView+Extension.h"

@implementation UIImageView (Extension)

- (BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event
{
    unsigned char pixel[1] = {0};
    CGContextRef context = CGBitmapContextCreate(pixel,
                                                 1, 1, 8, 1, NULL,
                                                 kCGImageAlphaOnly);
    UIGraphicsPushContext(context);
    [self.image drawAtPoint:CGPointMake(-point.x, -point.y)];
    UIGraphicsPopContext();
    CGContextRelease(context);
    CGFloat alpha = pixel[0]/255.0f;
    BOOL transparent = alpha < 0.01f;
    
    return !transparent;
}

@end
