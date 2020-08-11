//
//  UIImage+Helper.h
//  EducationAssistant
//
//  Created by 那道 on 2018/8/20.
//  Copyright © 2018年 LWH. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Helper)

/**
 *  利用颜色填充的图片
 */
+ (UIImage *)imageWithColor:(UIColor *)color;

+ (UIImage *)imageWithColor2:(UIColor *)color;

//获取视频第一贞图
+ (UIImage*)getVideoPreViewImage:(NSURL *)path;

+ (UIImage *)compressImageSize:(UIImage *)image toByte:(NSUInteger)maxLength;

+ (CGSize)getImageSizeWithURL:(id)URL;

@end
