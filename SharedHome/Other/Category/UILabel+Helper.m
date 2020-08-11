//
//  UILabel+Helper.m
//  EducationAssistant
//
//  Created by 那道 on 2018/8/20.
//  Copyright © 2018年 LWH. All rights reserved.
//

#import "UILabel+Helper.h"

@implementation UILabel (Helper)

+ (instancetype)labelWithText:(NSString *)text font:(UIFont *)font textColor:(UIColor *)textColor backGroundColor:(UIColor *)bgColor superView:(UIView *)superView
{
    UILabel *label = [[UILabel alloc]init];
    
    label.textAlignment = NSTextAlignmentLeft;
    
    label.textColor = textColor;
    label.clipsToBounds = YES;
    label.backgroundColor = bgColor;
    
    label.numberOfLines = 0;
    
    label.font = font;
    
    label.text = text?:@"";
    
    [superView addSubview:label];
    
    return label;
}

@end
