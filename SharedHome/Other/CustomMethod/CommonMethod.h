//
//  CommonMethod.h
//  Thebluebees
//
//  Created by admin on 15/7/2.
//  Copyright (c) 2015年 admin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFNetworking.h"

@interface CommonMethod : NSObject

+ (float)caculateCache;

+ (CGSize)caculateImageSizeWithPath:(id)imagePath showWithMaxSize:(CGSize)maxSize;
+ (NSString *)changeToStringWithAlipayCode:(NSInteger)code;

+ (BOOL)isLegalPsw:(NSString *)psw;
+ (BOOL)isMobileNumber:(NSString *)mobileNum;
+ (BOOL)image:(UIImage*)image1 isEqualTo:(UIImage*)image2;
+ (UIImageView*)findlineviw:(UIView*)view;

+ (NSDictionary *)dictionaryWithJsonString:(NSString *)jsonString;

+(int)initlabelwith:(NSString *)labelstr;

+(UIImageView *)setViewimag:(UIView *)taskview andimagename:(NSString *)imagestr;

+(UIBarButtonItem *)Setbarbtntextcolor:(UIColor *)textcolor andtitlestr:(NSString *)textstr;

+(void)altermethord:(NSString *)titlestr andmessagestr:(NSString *)messagestr andconcelstr:concelstr;

+(void)getVerificationCode:(UIButton *)Verificationbtn finish:(void (^)(void))finish;

+(BOOL)validateCarNo:(NSString *)carNo;

////////时间相关的
+ (NSInteger)caculateSurplusDayWithDate:(NSString *)dateStr;
//根据时间的NSDate获取年、月、日、时、分、秒
+ (NSDateComponents *)getComponentsWithDate:(NSDate *)date;
+ (NSString *)changeToTimeStrWithTime:(NSString *)dateString;
/**
 获得指定时间的 年、月、日、时、分、秒

 @param dateStr 如2019-08-09 18:24:00
 @return 年、月、日、时、分、秒
 */
+ (NSDateComponents *)getComponentsWithDateStr:(NSString *)dateStr;
/**
 指定格式的当前时间对应的NSDate

 @param type 时间格式如yyyy-MM-dd HH:mm:ss
 @return 指定格式的当前时间对应的NSDate值
 */
+ (NSDate *)getCurrentTimeWithType:(NSString *)type;

/**
 时间字符串转为NSDate

 @param dateStr 如2019-08-09 18:24:00
 @param type 时间格式如yyyy-MM-dd HH:mm:ss
 @return 时间字符串对应的NSDate值
 */
+ (NSDate *)getDateWithString:(NSString *)dateStr type:(NSString *)type;

+ (BOOL)judgeIsBeforeTodayWithDate:(NSDate *)giveDate;

/////////////////////////

+ (void)tipAlertWithTitle:(id)title leftColor:(UIColor *)leftColor leftTip:(NSString *)leftTip rightColor:(UIColor *)rightColor rightTip:(NSString *)rightTip showVC:(UIViewController *)showVC leftAction:(void (^)(void))leftAction rightAction:(void (^)(void))rightAction;

+ (void)tipAlertWithMessage:(NSString *)message leftColor:(UIColor *)leftColor leftTip:(NSString *)leftTip rightColor:(UIColor *)rightColor rightTip:(NSString *)rightTip showVC:(UIViewController *)showVC leftAction:(void (^)(void))leftAction rightAction:(void (^)(void))rightAction;

+ (void)tipAlertWithTitle:(id)title withMessage:(NSString *)message leftColor:(UIColor *)leftColor leftTip:(NSString *)leftTip rightTip:(NSString *)rightTip showVC:(UIViewController *)showVC leftAction:(void (^)(void))leftAction rightAction:(void (^)(void))rightAction;

+ (void)tipActionSheetWithTitle:(NSString *)title actionTitle1:(NSString *)title1 actionTitle2:(NSString *)title2 actionCancleTitle:(NSString *)cancleTitle  firstAction:(void (^)(void))firstAction secondAction:(void (^)(void))secondAction showVC:(UIViewController *)showVC;

+ (void)tipActionSheetWithTitle:(NSString *)title actionTitlesArr:(NSArray *)titlesArr actionCancleTitle:(NSString *)cancleTitle  titlesAction:(void (^)(id index))titlesAction showVC:(UIViewController *)showVC;
//判断相机的权限
+ (void)judgeOpenCameraWithShowVC:(UIViewController *)showVC openAction:(void (^)(void))openAction;
//判断相册的权限
+ (void)judgeCanOpenAlbumWithShowVC:(UIViewController *)showVC openAction:(void (^)(void))openAction;

+ (void)tipLoginFromController:(UIViewController *)showController finish:(void (^)(void))finish;
@end
