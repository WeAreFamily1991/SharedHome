//
//  UILabel+AlertActionFont.m
//  CircleOfTrade
//
//  Created by 王猛 on 2019/8/14.
//  Copyright © 2019 LWH. All rights reserved.
//

#import "UILabel+AlertActionFont.h"

@implementation UILabel (AlertActionFont)

- (void)setAppearanceFont:(UIFont *)appearanceFont
{
    if(appearanceFont)
    {
        [self setFont:appearanceFont];
    }
}

- (UIFont *)appearanceFont
{
    return self.font;
}

@end
