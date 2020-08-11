//
//  NSString+Helper.m
//  EducationAssistant
//
//  Created by 那道 on 2018/8/20.
//  Copyright © 2018年 LWH. All rights reserved.
//

#import "NSString+Helper.h"
#import <CommonCrypto/CommonCrypto.h>

@implementation NSString (Helper)


#pragma mark - 字符串是否为空----
- (BOOL)isNotEmpty {
    if (!self) return YES;
    NSCharacterSet *blank = [NSCharacterSet whitespaceAndNewlineCharacterSet];
    for (NSInteger i = 0; i < self.length; ++i) {
        unichar c = [self characterAtIndex:i];
        if (![blank characterIsMember:c]) {
            return YES;
        }
    }
    return NO;
}


#pragma mark - md5String---
- (NSString *)md5String {
    const char *str = self.UTF8String;
    uint8_t buffer[CC_MD5_DIGEST_LENGTH];
    
    CC_MD5(str, (CC_LONG)strlen(str), buffer);
    
    return [self stringFromBytes:buffer length:CC_MD5_DIGEST_LENGTH];
}
/**
 *  返回二进制 Bytes 流的字符串表示形式
 *
 *  @param bytes  二进制 Bytes 数组
 *  @param length 数组长度
 *
 *  @return 字符串表示形式
 */
- (NSString *)stringFromBytes:(uint8_t *)bytes length:(int)length {
    NSMutableString *strM = [NSMutableString string];
    
    for (int i = 0; i < length; i++) {
        [strM appendFormat:@"%02x", bytes[i]];
    }
    
    return [strM copy];
}

#pragma mark - 当前时间戳
+(NSString *)getNowTimeTimestamp{
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init] ;
    
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    
    [formatter setDateFormat:@"YYYY-MM-dd HH:mm:ss SSS"]; // ----------设置你想要的格式,hh与HH的区别:分别表示12小时制,24小时制
    
    //设置时区,这个对于时间的处理有时很重要
    
    NSTimeZone* timeZone = [NSTimeZone timeZoneWithName:@"Asia/Shanghai"];
    
    [formatter setTimeZone:timeZone];
    
    NSDate *datenow = [NSDate date];//现在时间,你可以输出来看下是什么格式
    
    NSString *timeSp = [NSString stringWithFormat:@"%ld", (long)[datenow timeIntervalSince1970]*1000];
    
    return timeSp;
}

#pragma mark - 获取当前年月日时分秒
+ (NSString*)getCurrentTimes
{
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    
    // ----------设置你想要的格式,hh与HH的区别:分别表示12小时制,24小时制
    
    [formatter setDateFormat:@"YYYY-MM-dd HH:mm:ss"];
    
    //现在时间,你可以输出来看下是什么格式
    
    NSDate *datenow = [NSDate date];
    
    //----------将nsdate按formatter格式转成nsstring
    
    NSString *currentTimeString = [formatter stringFromDate:datenow];
    
    return currentTimeString;
    
}

#pragma mark - 不同颜色的文字
+ (NSMutableAttributedString *)attributedStringWithColorTitle:(NSString *)title normalTitle:(NSString *)normalTitle frontTitle:(NSString *)frontTitle diffentColor:(UIColor *)color
{
    NSAttributedString *frontStr = [[NSAttributedString alloc]initWithString:[NSString stringWithFormat:@"%@",frontTitle]];
    
    //OrangeColor
    NSMutableAttributedString *goodsNameStr = [self multableAttributeStr:[NSString stringWithFormat:@"%@",title] stringColor:color];
    
    NSAttributedString *secondTipsStr = [[NSAttributedString alloc]initWithString:[NSString stringWithFormat:@"%@",normalTitle]];
    
    NSMutableAttributedString *finishTipMulStr = [[NSMutableAttributedString alloc]init];
    
    [finishTipMulStr appendAttributedString:frontStr];
    
    [finishTipMulStr appendAttributedString:goodsNameStr];
    
    [finishTipMulStr appendAttributedString:secondTipsStr];
    
    return finishTipMulStr;
    
}

+ (NSMutableAttributedString *)multableAttributeStr:(NSString *)str stringColor:(UIColor *)color
{
    NSMutableAttributedString *mulStr = [[NSMutableAttributedString alloc]initWithString:str];
    
    NSRange range = NSMakeRange(0, [mulStr length]);
    
    [mulStr setAttributes:@{NSForegroundColorAttributeName : color} range:range];
    
    return mulStr;
    
}

#pragma mark - 不同大小的文字---
+ (NSMutableAttributedString *)attributedStringWithDifferentTitle:(NSString *)title normalTitle:(NSString *)normalTitle frontTitle:(NSString *)frontTitle diffentFont:(UIFont *)font
{
    
    NSMutableAttributedString*mulAttriStr =  [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"%@%@%@", frontTitle, title, normalTitle]];
    
    [mulAttriStr addAttribute:NSFontAttributeName value:font range:NSMakeRange(frontTitle.length,title.length)];
    
    return mulAttriStr;
    
}


#pragma mark - 不同颜色&大小的字---
+ (NSMutableAttributedString *)attributedStringWithColorTitle:(NSString *)title normalTitle:(NSString *)normalTitle frontTitle:(NSString *)frontTitle normalColor:(UIColor *)normalColor diffentColor:(UIColor *)color normalFont:(UIFont *)normalFont differentFont:(UIFont *)font
{
    //不同颜色&大小的字
    NSMutableAttributedString*mulAttriStr =  [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"%@%@%@", frontTitle, title, normalTitle]];
    
    [mulAttriStr addAttribute:NSForegroundColorAttributeName value:normalColor range:NSMakeRange(0,frontTitle.length)];
    [mulAttriStr addAttribute:NSFontAttributeName value:normalFont range:NSMakeRange(0,frontTitle.length)];
    
    if (color) {
        [mulAttriStr addAttribute:NSForegroundColorAttributeName value:color range:NSMakeRange(frontTitle.length,title.length)];
        [mulAttriStr addAttribute:NSFontAttributeName value:font range:NSMakeRange(frontTitle.length,title.length)];
    }
    
    if (font) {
        [mulAttriStr addAttribute:NSForegroundColorAttributeName value:normalColor range:NSMakeRange(frontTitle.length+title.length,normalTitle.length)];
        [mulAttriStr addAttribute:NSFontAttributeName value:normalFont range:NSMakeRange(frontTitle.length+title.length,normalTitle.length)];
    }
    
    return mulAttriStr;
    
}

#pragma mark - 带有图片的富文本文字----
+ (NSMutableAttributedString *)attributeWithTitle:(NSString *)title behindText:(NSString *)behindText imageName:(NSString *)imageName
{
    NSString *frontText = title ? title : @"";
    // 创建一个富文本
    NSMutableAttributedString *attri = [[NSMutableAttributedString alloc] initWithString:frontText];
    
    // 添加表情
    NSTextAttachment *attch = [[NSTextAttachment alloc] init];
    // 表情图片
    attch.image = [UIImage imageNamed:imageName];
    //    attch.
    // 设置图片大小
    attch.bounds = CGRectMake(0, -2, attch.image.size.width, attch.image.size.height);
    
    // 创建带有图片的富文本
    NSAttributedString *string = [NSAttributedString attributedStringWithAttachment:attch];
    
    [attri appendAttributedString:string];
    
    if (behindText) {
        
        NSAttributedString *behind = [[NSAttributedString alloc]initWithString:behindText];
        
        [attri appendAttributedString:behind];
    }
    
    return attri;
}


#pragma mark - 上下行间隔的文字---
+ (NSMutableAttributedString *)attributedStringWithLineSpacing:(CGFloat)spacing paragrapString:(NSString *)title alignment:(NSTextAlignment)alignment
{
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc]initWithString:title];
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle setLineSpacing:spacing];
    paragraphStyle.alignment = alignment;
    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [title length])];
    
    return attributedString;
}

#pragma mark - 遇到数字变色&变字体---
+ (NSMutableAttributedString *)attributeWithContent:(NSString *)content diffentFont:(UIFont *)font differentColor:(UIColor *)color
{
    
    content = content ? : @"";
    
    NSArray *number = @[@"0",@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9"];
    NSMutableAttributedString *attributeString  = [[NSMutableAttributedString alloc]initWithString:content];
    for (int i = 0; i < content.length; i ++) {
        //这里的小技巧，每次只截取一个字符的范围
        NSString *a = [content substringWithRange:NSMakeRange(i, 1)];
        //判断装有0-9的字符串的数字数组是否包含截取字符串出来的单个字符，从而筛选出符合要求的数字字符的范围NSMakeRange
        if ([number containsObject:a]) {
            [attributeString setAttributes:@{NSForegroundColorAttributeName:color,NSFontAttributeName:font} range:NSMakeRange(i, 1)];
        }//NSUnderlineStyleAttributeName:[NSNumber numberWithInteger:NSUnderlineStyleSingle]下划线
        
    }
    return attributeString;
}


#pragma mark - 计算文字所占的size---
+ (CGSize)sizeWithText:(NSString *)text font:(UIFont *)font maxSize:(CGSize)maxSize
{
    text = text?:@"";
    NSDictionary *attrs = @{NSFontAttributeName : font?:[UIFont systemFontOfSize:14]};
    return [text boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:attrs context:nil].size;
}


#pragma mark 转换成JSON字符串----
+ (NSString *)JSONString:(id)data{
    NSError *error = nil;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:data options:NSJSONWritingPrettyPrinted error:&error];
    if (jsonData == nil) {
#ifdef DEBUG
        NSLog(@"fail to get JSON from dictionary: %@, error: %@", self, error);
#endif
        return nil;
    }
    NSString *jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    return jsonString;
}

- (NSString *)self_adaptionHost
{
    
    NSString * imgUrlStr = @"";
    if ([self containsString:@"http://"]) {
        imgUrlStr = self;
    }else if([self containsString:@"https://"]){
        imgUrlStr = self;
    }

    return imgUrlStr;
}

- (NSString *)timing{
    return [self stringByTrimmingCharactersInSet: [NSCharacterSet whitespaceCharacterSet]];
}

- (CGSize)sizeWithFont:(UIFont *)font maxSize:(CGSize)maxSize
{
//    if (self.length <= 0) {
//        CGSize sizee = CGSizeMake(0.01f, 0.01f);
//        return sizee;
//    }else{
        NSDictionary *attrs = @{NSFontAttributeName : font};
        return [self boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:attrs context:nil].size;
//    }
}

- (CGSize)sizeWithFont:(UIFont *)font maxSize:(CGSize)maxSize andlineSpacing:(CGFloat) lineSpaceing {
    
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.lineBreakMode = NSLineBreakByWordWrapping;
    paragraphStyle.alignment = NSTextAlignmentLeft;
    paragraphStyle.hyphenationFactor = 1.0;
    paragraphStyle.lineSpacing = lineSpaceing;
    paragraphStyle.firstLineHeadIndent = 0.0;
    paragraphStyle.paragraphSpacingBefore = 0.0;
    paragraphStyle.headIndent = 0;
    paragraphStyle.tailIndent = 0;
    NSDictionary *dict = @{NSFontAttributeName : font,NSParagraphStyleAttributeName:paragraphStyle.copy};
    
    CGSize originSize = [self boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:dict context:nil].size;
    
    NSString *test = @"我们";
    CGSize wordSize = [test sizeWithFont:font maxSize:maxSize];
    
    CGFloat selfHeight = [self sizeWithFont:font maxSize:maxSize].height;
    
    if (selfHeight <= wordSize.height) {
        
        CGSize newSize = CGSizeMake(originSize.width, font.pointSize);
        
        if (selfHeight == 0) {
            
            newSize = CGSizeMake(originSize.width, 0);
        }
        
        originSize = newSize;
    }
    
    return originSize;
}
@end
