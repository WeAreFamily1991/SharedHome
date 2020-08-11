//
//  UIButton+Helper.h
//  EducationAssistant
//
//  Created by 那道 on 2018/8/20.
//  Copyright © 2018年 LWH. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, MKButtonEdgeInsetsStyle) {
    MKButtonEdgeInsetsStyleTop, // image在上，label在下
    MKButtonEdgeInsetsStyleLeft, // image在左，label在右
    MKButtonEdgeInsetsStyleBottom, // image在下，label在上
    MKButtonEdgeInsetsStyleRight // image在右，label在左
};

@interface UIButton (Helper)


/**
 *  设置button的titleLabel和imageView的布局样式，及间距
 *
 *  @param style titleLabel和imageView的布局样式
 *  @param space titleLabel和imageView的间距
 */
- (void)layoutButtonWithEdgeInsetsStyle:(MKButtonEdgeInsetsStyle)style
                        imageTitleSpace:(CGFloat)space;

/**
 *  基础按钮：字体，字体颜色，背景色，事件
 */
+ (instancetype)buttonWithTitle:(NSString *)title font:(UIFont *)font titleColor:(UIColor *)titleColor backGroundColor:(UIColor *)bgColor buttonTag:(NSInteger)tag target:(id)target action:(SEL)action showView:(UIView *)showView;


/**
 *  基础按钮：只显示一个图片
 */
+ (UIButton *)buttonWithImage:(NSString *)image target:(id)target action:(SEL)action showView:(UIView *)showView;

/**
 *  带有字体有选中&为选中颜色，带有tag&背景色的按钮
 */
+ (instancetype)buttonWithTitle:(NSString *)title font:(UIFont *)font normalColor:(UIColor *)normalColor selectedColor:(UIColor *)selectedColor buttonTag:(NSInteger)tag backGroundColor:(UIColor *)bgColor target:(id)target action:(SEL)action showView:(UIView *)showView;

/**
 *  带有字体\背景有选中&为选中，带有tag的按钮
 */
+ (instancetype)buttonWithTitle:(NSString *)title font:(UIFont *)font normalColor:(UIColor *)normalColor selectedColor:(UIColor *)selectedColor normalImage:(id)normalImage selectImage:(id)selectImage  buttonTag:(NSInteger)tag target:(id)target action:(SEL)action showView:(UIView *)showView;

/**
 *  左边带图标&字体颜色&背景色的按钮   系统自带的方式
 */
+ (instancetype)buttonWithLeftImage:(NSString *)imageName title:(NSString *)title font:(UIFont *)font titleColor:(UIColor *)titleColor backGroundColor:(UIColor *)bgColor target:(id)target action:(SEL)action showView:(UIView *)showView;



@end
