//
//  NSString+Helper.h
//  EducationAssistant
//
//  Created by 那道 on 2018/8/20.
//  Copyright © 2018年 LWH. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Helper)

/**
 nil, @"", @"  ", @"\n" will Returns NO; otherwise Returns YES.
 
 @discussion 可用于判断用户名或者密码是否为空
 */
- (BOOL)isNotEmpty;

/**
 
 */
- (NSString *)md5String;


/**
 当前时间戳
 */
+(NSString *)getNowTimeTimestamp;

#pragma mark - 获取当前年月日时分秒
+ (NSString*)getCurrentTimes;
/**
 不同颜色的文字
 
 @param title 不同颜色的文字
 @param normalTitle 后面的文字
 @param frontTitle 前面的文字
 @param color 不同的颜色
 @return 不同颜色的文字
 */
+ (NSMutableAttributedString *)attributedStringWithColorTitle:(NSString *)title normalTitle:(NSString *)normalTitle frontTitle:(NSString *)frontTitle diffentColor:(UIColor *)color;


/**
 不同大小的文字

 @param title 不同大小的文字
 @param normalTitle 后面的文字
 @param frontTitle 前面的文字
 @param font 不同大小的文字
 @return 不同大小的文字
 */
+ (NSMutableAttributedString *)attributedStringWithDifferentTitle:(NSString *)title normalTitle:(NSString *)normalTitle frontTitle:(NSString *)frontTitle diffentFont:(UIFont *)font;


/**
 不同颜色不同大小的文字
 
 @param title 不同颜色的文字
 @param normalTitle 后面的文字
 @param frontTitle 前面的文字
 @param normalColor 默认的文字颜色
 @param color 不同的文字颜色
 @param normalFont 默认的字体大小
 @param font 不同的字体大小
 @return 不同颜色不同大小的文字
 */
+ (NSMutableAttributedString *)attributedStringWithColorTitle:(NSString *)title normalTitle:(NSString *)normalTitle frontTitle:(NSString *)frontTitle normalColor:(UIColor *)normalColor diffentColor:(UIColor *)color normalFont:(UIFont *)normalFont differentFont:(UIFont *)font;

/**
 带有图片的富文本文字
 
 @param title 图前的文字
 @param behindText 图后的文字
 @param imageName 图的name
 @return 富文本文字
 */
+ (NSMutableAttributedString *)attributeWithTitle:(NSString *)title behindText:(NSString *)behindText imageName:(NSString *)imageName;

/**
 上下行间隔的文字
 
 @param spacing 间距
 @param title 内容
 @return 上下行间隔的文字
 */
+ (NSMutableAttributedString *)attributedStringWithLineSpacing:(CGFloat)spacing paragrapString:(NSString *)title alignment:(NSTextAlignment)alignment;

/**
 遇到数字变色&变字体
 
 @param content 所显示的全部内容
 @param font 数字的字体
 @param color 数字的颜色
 @return 遇到数字变色&变字体
 */
+ (NSMutableAttributedString *)attributeWithContent:(NSString *)content diffentFont:(UIFont *)font differentColor:(UIColor *)color;


/**
 计算文字所占的size

 @param text 文字
 @param font 字体大小
 @param maxSize 最大size
 @return 计算文字所占的size
 */
+ (CGSize)sizeWithText:(NSString *)text font:(UIFont *)font maxSize:(CGSize)maxSize;


/**
 转换成JSON字符串

 @param data 被转换的对象
 @return JSON字符串
 */
+ (NSString *)JSONString:(id)data;


/**
 *  返回字符串所占用的尺寸
 *
 *  @param font    字体
 *  @param maxSize 最大尺寸
 */
- (CGSize)sizeWithFont:(UIFont *)font maxSize:(CGSize)maxSize;

/**
 *  添加行间距并返回字符串所占用的尺寸
 *
 *  @param font    字体
 *  @param maxSize 最大尺寸
 *  @param lineSpaceing 行间距
 */
- (CGSize)sizeWithFont:(UIFont *)font maxSize:(CGSize)maxSize andlineSpacing:(CGFloat) lineSpaceing;

/**
 *  自适应图片url
 */
- (NSString *)self_adaptionHost;

- (NSString *)timing;


@end
