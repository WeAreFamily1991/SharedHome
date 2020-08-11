//
//  UIButton+Helper.m
//  EducationAssistant
//
//  Created by 那道 on 2018/8/20.
//  Copyright © 2018年 LWH. All rights reserved.
//

#import "UIButton+Helper.h"

@implementation UIButton (Helper)


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event

{
    
   [super touchesBegan:touches withEvent:event];
    
   [[[self nextResponder] nextResponder] touchesBegan:touches withEvent:event];
    
}

- (void)layoutButtonWithEdgeInsetsStyle:(MKButtonEdgeInsetsStyle)style
                        imageTitleSpace:(CGFloat)space
{
    //    self.backgroundColor = [UIColor cyanColor];
    
    /**
     *  前置知识点：titleEdgeInsets是title相对于其上下左右的inset，跟tableView的contentInset是类似的，
     *  如果只有title，那它上下左右都是相对于button的，image也是一样；
     *  如果同时有image和label，那这时候image的上左下是相对于button，右边是相对于label的；title的上右下是相对于button，左边是相对于image的。
     */
    
    
    // 1. 得到imageView和titleLabel的宽、高
    CGFloat imageWith = self.imageView.frame.size.width;
    CGFloat imageHeight = self.imageView.frame.size.height;
    
    CGFloat labelWidth = 0.0;
    CGFloat labelHeight = 0.0;
    if ([UIDevice currentDevice].systemVersion.floatValue >= 8.0) {
        // 由于iOS8中titleLabel的size为0，用下面的这种设置
        labelWidth = self.titleLabel.intrinsicContentSize.width;
        labelHeight = self.titleLabel.intrinsicContentSize.height;
    } else {
        labelWidth = self.titleLabel.frame.size.width;
        labelHeight = self.titleLabel.frame.size.height;
    }
    
    // 2. 声明全局的imageEdgeInsets和labelEdgeInsets
    UIEdgeInsets imageEdgeInsets = UIEdgeInsetsZero;
    UIEdgeInsets labelEdgeInsets = UIEdgeInsetsZero;
    
    // 3. 根据style和space得到imageEdgeInsets和labelEdgeInsets的值
    switch (style) {
        case MKButtonEdgeInsetsStyleTop:
        {
            imageEdgeInsets = UIEdgeInsetsMake(-labelHeight-space/2.0, 0, 0, -labelWidth);
            labelEdgeInsets = UIEdgeInsetsMake(0, -imageWith, -imageHeight-space/2.0, 0);
        }
            break;
        case MKButtonEdgeInsetsStyleLeft:
        {
            imageEdgeInsets = UIEdgeInsetsMake(0, -space/2.0, 0, space/2.0);
            labelEdgeInsets = UIEdgeInsetsMake(0, space/2.0, 0, -space/2.0);
        }
            break;
        case MKButtonEdgeInsetsStyleBottom:
        {
            imageEdgeInsets = UIEdgeInsetsMake(0, 0, -labelHeight-space/2.0, -labelWidth);
            labelEdgeInsets = UIEdgeInsetsMake(-imageHeight-space/2.0, -imageWith, 0, 0);
        }
            break;
        case MKButtonEdgeInsetsStyleRight:
        {
            imageEdgeInsets = UIEdgeInsetsMake(0, labelWidth+space/2.0, 0, -labelWidth-space/2.0);
            labelEdgeInsets = UIEdgeInsetsMake(0, -imageWith-space/2.0, 0, imageWith+space/2.0);
        }
            break;
        default:
            break;
    }
    
    // 4. 赋值
    self.titleEdgeInsets = labelEdgeInsets;
    self.imageEdgeInsets = imageEdgeInsets;
}


#pragma mark - 基础按钮：字体，字体颜色，背景色，事件
+ (instancetype)buttonWithTitle:(NSString *)title font:(UIFont *)font titleColor:(UIColor *)titleColor backGroundColor:(UIColor *)bgColor buttonTag:(NSInteger)tag target:(id)target action:(SEL)action showView:(UIView *)showView
{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    
    btn.titleLabel.font = font;
    
    btn.tag = tag;
    
    btn.backgroundColor = bgColor;
    
    btn.titleLabel.numberOfLines = 0;
    
    btn.clipsToBounds = YES;
    
    [btn setTitleColor:titleColor forState:UIControlStateNormal];
    
    [btn setTitle:title forState:UIControlStateNormal];
    [btn setShowsTouchWhenHighlighted:NO];
    [btn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    [btn setAdjustsImageWhenHighlighted:NO];
    [showView addSubview:btn];
    
    return btn;
}

#pragma mark - 只显示一个图片
+ (UIButton *)buttonWithImage:(NSString *)image target:(id)target action:(SEL)action showView:(UIView *)showView
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    
    button.clipsToBounds = YES;
    [button setShowsTouchWhenHighlighted:NO];
    [button setImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
    
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    [button setAdjustsImageWhenHighlighted:NO];
    [showView addSubview:button];
    
    return button;
}

#pragma mark - 带有字体有选中&为选中颜色，带有tag&背景色的按钮
+ (instancetype)buttonWithTitle:(NSString *)title font:(UIFont *)font normalColor:(UIColor *)normalColor selectedColor:(UIColor *)selectedColor buttonTag:(NSInteger)tag backGroundColor:(UIColor *)bgColor target:(id)target action:(SEL)action showView:(UIView *)showView
{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    
    btn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    
    btn.titleLabel.font = font;
    
    btn.backgroundColor = bgColor;
    [btn setShowsTouchWhenHighlighted:NO];
    [btn setTitleColor:selectedColor forState:UIControlStateSelected];
    
    [btn setTitleColor:normalColor forState:UIControlStateNormal];
    
    [btn setTitle:title forState:UIControlStateNormal];
    
    [btn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    
    btn.tag = tag;
    [btn setAdjustsImageWhenHighlighted:NO];
    [showView addSubview:btn];
    
    return btn;
}

#pragma mark - 带有字体\背景有选中&为选中，带有tag的按钮
+ (instancetype)buttonWithTitle:(NSString *)title font:(UIFont *)font normalColor:(UIColor *)normalColor selectedColor:(UIColor *)selectedColor normalImage:(id)normalImage selectImage:(id)selectImage  buttonTag:(NSInteger)tag target:(id)target action:(SEL)action showView:(UIView *)showView
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    
    button.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 10);
    
    [button setTitle:title forState:UIControlStateNormal];
    
    [button setTitleColor:selectedColor forState:UIControlStateSelected];
    
    [button setTitleColor:normalColor forState:UIControlStateNormal];
    [button setShowsTouchWhenHighlighted:NO];
    if ([normalImage isKindOfClass:[UIImage class]]) {
        [button setBackgroundImage:normalImage forState:UIControlStateNormal];
    }
    else
        [button setBackgroundImage:[UIImage imageNamed:normalImage] forState:UIControlStateNormal];
    
    if ([selectImage isKindOfClass:[UIImage class]]) {
        [button setBackgroundImage:selectImage forState:UIControlStateNormal];
    }
    else
        [button setBackgroundImage:[UIImage imageNamed:selectImage] forState:UIControlStateSelected];
    
    button.titleLabel.font = font;
    
    button.tag = tag;
    
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    [button setAdjustsImageWhenHighlighted:NO];
    [showView addSubview:button];
    
    return button;
}

#pragma mark - 左边带图标&字体颜色&背景色的按钮

+ (instancetype)buttonWithLeftImage:(NSString *)imageName title:(NSString *)title font:(UIFont *)font titleColor:(UIColor *)titleColor backGroundColor:(UIColor *)bgColor target:(id)target action:(SEL)action showView:(UIView *)showView
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    
    button.titleEdgeInsets = UIEdgeInsetsMake(0, 10 / 2, 0, 0);
    
    [button setTitle:title forState:UIControlStateNormal];
    
    [button setTitleColor:titleColor forState:UIControlStateNormal];
    
    [button setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
    
    button.titleLabel.font = font;
    
    button.backgroundColor = bgColor;
    [button setShowsTouchWhenHighlighted:NO];
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    [button setAdjustsImageWhenHighlighted:NO];
    [showView addSubview:button];
    
    return button;
}


@end
