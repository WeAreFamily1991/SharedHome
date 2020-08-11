//
//  UIScrollView+Event.m
//  CircleOfTrade
//
//  Created by 王猛 on 2019/9/2.
//  Copyright © 2019 LWH. All rights reserved.
//

#import "UIScrollView+Event.h"

@implementation UIScrollView (Event)

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event

{
    
    [super touchesBegan:touches withEvent:event];
    
    [[[self nextResponder] nextResponder] touchesBegan:touches withEvent:event];
    
}

@end
