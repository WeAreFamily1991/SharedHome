//
//  UILabel+Helper.h
//  EducationAssistant
//
//  Created by 那道 on 2018/8/20.
//  Copyright © 2018年 LWH. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UILabel (Helper)

/**
 初始化
 */
+ (instancetype)labelWithText:(NSString *)text font:(UIFont *)font textColor:(UIColor *)textColor backGroundColor:(UIColor *)GamesBGCOLOR superView:(UIView *)superView;

@end
