//
//  CommonMethod.m
//  Thebluebees
//
//  Created by admin on 15/7/2.
//  Copyright (c) 2015年 admin. All rights reserved.
//

#import "CommonMethod.h"
#import <CommonCrypto/CommonDigest.h>
#import <Photos/Photos.h>
#import "SHLoginViewController.h"
#import "YMNavigationController.h"
@implementation CommonMethod

#pragma mark - 计算缓存
+ (float)caculateCache
{
    NSString * cachPath = [ NSSearchPathForDirectoriesInDomains ( NSCachesDirectory , NSUserDomainMask , YES ) firstObject ];
    
    return [CommonMethod folderSizeAtPath :cachPath];
    
}
//1:首先我们计算一下 单个文件的大小

+ (long long) fileSizeAtPath:( NSString *) filePath{
    
    NSFileManager * manager = [ NSFileManager defaultManager ];
    
    if ([manager fileExistsAtPath :filePath]){
        
        return [[manager attributesOfItemAtPath :filePath error : nil ] fileSize ];
    }
    
    return 0 ;
    
}
//2:遍历文件夹获得文件夹大小，返回多少 M（提示：你可以在工程界设置（)m）

+ (float) folderSizeAtPath:( NSString *) folderPath{
    
//var/mobile/Containers/Data/Application/E44DDE4A-E27B-4305-AC35-B5C6155ADFDD/Library/Caches/MuchTV/common/cache/downloadFile/978307200000_流畅_0303.mp4
   
    NSFileManager * manager = [ NSFileManager defaultManager ];
    
    if (![manager fileExistsAtPath :folderPath]) return 0 ;
    
    NSEnumerator *childFilesEnumerator = [[manager subpathsAtPath :folderPath] objectEnumerator ];
    
    NSString * fileName;
    
    long long folderSize = 0 ;
    
    while ((fileName = [childFilesEnumerator nextObject ]) != nil )
    {
        
        NSString * fileAbsolutePath = [folderPath stringByAppendingPathComponent :fileName];
        
        if (![fileAbsolutePath containsString:@"Library/Caches/MuchTV"]) {
             folderSize += [CommonMethod fileSizeAtPath :fileAbsolutePath];
        }
    }
    
    return folderSize/( 1024.0 * 1024.0 );
    
}


#pragma mark - 时间转换
+ (NSString *)changeToTimeStrWithTime:(NSString *)dateString
{
    //实例化一个NSDateFormatter对象
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    
    NSDate * needFormatDate = [dateFormatter dateFromString:dateString];
    
    NSTimeInterval time = [[NSDate date] timeIntervalSinceDate:needFormatDate];
    
    // 再然后，把间隔的秒数折算成天数和小时数：
    
    NSString *dateStr = @"";
    
    if (time<=60) {  // 不超过一分钟，提示1分钟前
        dateStr = @"1分钟前";
    }else if(time<=60*60){  //  超过一分钟但是不超过一小时，提示XX分钟前（例如36分钟前）
        
        int mins = time/60;
        dateStr = [NSString stringWithFormat:@"%d分钟前",mins];
        
    }else if(time<=60*60*24){   // 在两天内的
        //超过一小时但是不超过24小时，提示XX小时前（例如14小时前）
        int mins = time/(60*60);
        dateStr = [NSString stringWithFormat:@"%d小时前",mins];
        
    }else if(time<=60*60*24*30){
        //超过24小时但是不超过30天，提示XX天前（例如4天前）
        int mins = time/(60*60*24);
        dateStr = [NSString stringWithFormat:@"%d天前",mins];
    }else {
        //超过30天显示具体日期（例如2019-03-12）
        [dateFormatter setDateFormat:@"yyyy"];
        NSString * yearStr = [dateFormatter stringFromDate:needFormatDate];
        NSString *nowYear = [dateFormatter stringFromDate:[NSDate date]];
        
        if ([yearStr isEqualToString:nowYear]) {
            //  在同一年
            [dateFormatter setDateFormat:@"MM月dd日"];
            dateStr = [dateFormatter stringFromDate:needFormatDate];
        }else{
            [dateFormatter setDateFormat:@"yyyy-MM-dd"];
            dateStr = [dateFormatter stringFromDate:needFormatDate];
        }
    }
    
    return dateStr;
}

//根据时间的NSDate获取年、月、日、时、分、秒
+ (NSDateComponents *)getComponentsWithDate:(NSDate *)date
{
    NSTimeZone *zone = [NSTimeZone systemTimeZone];//取到系统所在地时间差
    NSInteger interval = [zone secondsFromGMTForDate:date];
    NSDate *localeDate = [date  dateByAddingTimeInterval: interval];//当前当地时间
    
    NSDateComponents *comps = [[NSDateComponents alloc] init];
    NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSInteger unitFlags = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitWeekday |
    NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
    comps = [gregorian components:unitFlags fromDate:localeDate];
    
    return comps;
}
//获得指定时间的 年、月、日、时、分、秒
+ (NSDateComponents *)getComponentsWithDateStr:(NSString *)dateStr {
    /*
     时间获取  年月日时分秒
     Calendar Year: 2015
     Month: 9
     Leap month: no
     Day: 12
     Hour: 2
     Minute: 29
     Second: 12
     Weekday: 7
     **/
    NSDate *datenow = [self getDateWithString:dateStr type:@"yyyy-MM-dd HH:mm:ss"];//现在时间
    NSTimeZone *zone = [NSTimeZone systemTimeZone];//取到系统所在地时间差
    NSInteger interval = [zone secondsFromGMTForDate:datenow];
    NSDate *localeDate = [datenow  dateByAddingTimeInterval: interval];//当前当地时间
    
    NSDateComponents *comps = [[NSDateComponents alloc] init];
    NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSInteger unitFlags = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitWeekday |
    NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
    comps = [gregorian components:unitFlags fromDate:localeDate];
    
    //    NSInteger year = [comps year];
    //    NSInteger month = [comps month];
    //    NSInteger day = [comps day];
    //    NSInteger week = [comps weekday];
    //    NSInteger hour = [comps hour];
    //    NSInteger minute = [comps minute];
    //    NSInteger second = [comps second];
    
    return comps;
}

+ (CGSize)caculateImageSizeWithPath:(id)imagePath showWithMaxSize:(CGSize)maxSize
{
    CGSize size = [UIImage getImageSizeWithURL:imagePath];
    CGFloat maxHeight = maxSize.height;
    CGFloat maxWidth = maxSize.width;
    CGFloat nW = maxWidth;
    CGFloat nH = maxHeight;
    if (size.width<=maxWidth && size.height<=maxHeight) {
        BOOL isWidthMin = maxHeight-size.height>=maxWidth-size.width;
        if (isWidthMin) {
            nW = maxWidth;
            nH = maxWidth*(size.height/size.width);
        }
        else
        {
            nH = maxHeight;
            nW = maxHeight*((size.width*1.0)/size.height);
        }
    }
    else if (size.width>maxWidth && size.height>maxHeight)
    {
        BOOL isWidthM = size.width-maxWidth>=size.height-maxHeight;//宽度差大于高度差，计算宽
        if (isWidthM) {
            nW = maxHeight*(size.width/size.height);
            if (nW>maxWidth) {
                //计算结果还是大于屏高
                nW = maxWidth;
                nH = maxWidth*(size.height/size.width);
            }
        }
        else
        {
            nH = maxWidth*(size.height/size.width);
            if (nH>maxHeight) {
                //计算结果还是大于屏高
                nH = maxHeight;
                nW = maxHeight*(size.width/size.height);
            }
        }
    }
    else if (size.width<=maxWidth && size.height>maxHeight) {
        nW = maxHeight*(size.width/size.height);
        if(nW>maxWidth)
        {
            NZLog(@"宽在屏内----计算结果大maxHeight");
            nW = maxWidth;
        }
    }
    else if(size.width>maxWidth && size.height<=maxHeight)
    {
        nH = maxWidth*(size.height/size.width);
        if (nH>maxHeight) {
            nH = maxHeight;
            NZLog(@"高在屏内---计算结果大maxWidth");
        }
        
    }
    if (nH>maxHeight) {
        nH = maxHeight;
        NZLog(@"111计算结果大maxWidth");
    }
    if(nW>maxWidth)
    {
        NZLog(@"111计算结果大maxHeight");
        nW = maxWidth;
    }
    return CGSizeMake(nW, nH);
}
+ (NSString *)changeToStringWithAlipayCode:(NSInteger)code
{
    NSString *payResult;
    if (code == 9000) {
        payResult=@"支付成功";
    }else if (code == 8000){
        payResult=@"正在处理";
    }else if (code == 4000){
        payResult=@"支付失败";
    }else if (code == 5000){
        payResult=@"重复请求";
    }else if (code == 6001){
        payResult=@"取消支付";
    }else if (code == 6002){
        payResult=@"网络错误";
    }else{
        payResult=@"未知错误";
    }
    return payResult;
}

+ (BOOL)isLegalPsw:(NSString *)psw
{
    if ([psw stringByReplacingOccurrencesOfString:@" " withString:@""].length==0) {
        return NO;
    }
    if (psw.length<6 || psw.length>16) {
        return NO;
    }
    return YES;
}

//手机号码正则
+ (BOOL)isMobileNumber:(NSString *)mobileNum
{
    if (mobileNum.length != 11)
    {
        return NO;
    }
    /**
     * 手机号码:
     * 13[0-9], 14[5,7], 15[0, 1, 2, 3, 5, 6, 7, 8, 9], 17[6, 7, 8], 18[0-9], 170[0-9]
     * 移动号段: 134,135,136,137,138,139,150,151,152,157,158,159,182,183,184,187,188,147,178,1705
     * 联通号段: 130,131,132,155,156,185,186,145,176,1709
     * 电信号段: 133,153,180,181,189,177,1700
     */
    NSString *MOBILE = @"(^1\\d{10}$)";
    /**
     * 中国移动：China Mobile
     * 134,135,136,137,138,139,150,151,152,157,158,159,182,183,184,187,188,147,178,1705
     */
    NSString *CM = @"(^1(3[4-9]|4[7]|5[0-27-9]|7[8]|8[2-478])\\d{8}$)|(^1705\\d{7}$)";
    /**
     * 中国联通：China Unicom
     * 130,131,132,155,156,185,186,145,176,1709
     */
    NSString *CU = @"(^1(3[0-2]|4[5]|5[56]|7[6]|8[56])\\d{8}$)|(^1709\\d{7}$)";
    /**
     * 中国电信：China Telecom
     * 133,153,180,181,189,177,1700
     */
    NSString *CT = @"(^1(33|53|77|8[019])\\d{8}$)|(^1700\\d{7}$)";
    
    
    NSPredicate *regextestmobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", MOBILE];
    NSPredicate *regextestcm = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CM];
    NSPredicate *regextestcu = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CU];
    NSPredicate *regextestct = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CT];
    //([regextestmobile evaluateWithObject:mobileNum] == YES)
    //||
    if (([regextestcm evaluateWithObject:mobileNum] == YES)
        || ([regextestct evaluateWithObject:mobileNum] == YES)
        || ([regextestcu evaluateWithObject:mobileNum] == YES))
    {
        return YES;
    }
    else
    {
        return NO;
    }
}
#pragma mark - 导航栏的底部横线
+ (UIImageView*)findlineviw:(UIView*)view
{
    
    if ([view isKindOfClass:[UIImageView class]]&&view.bounds.size.height<=1.0) {
        return (UIImageView*) view;
    }
    for (UIImageView *subview in view.subviews) {
        UIImageView *lineview = [self findlineviw:subview];
        if (lineview) {
            return lineview;
        }
    }
    return nil;
}

+ (BOOL)image:(UIImage*)image1 isEqualTo:(UIImage*)image2{
    NSData *data1 = UIImagePNGRepresentation(image1);
    NSData *data2 = UIImagePNGRepresentation(image2);
    return[data1 isEqual:data2];
}


+ (NSDictionary *)dictionaryWithJsonString:(NSString *)jsonString
{
    if (jsonString == nil) {
        return nil;
    }
    
    NSData *jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    NSError *err;
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData
                                                        options:NSJSONReadingMutableContainers
                                                          error:&err];
    if(err)
    {
        NSLog(@"json解析失败：%@",err);
        return nil;
    }
    return dic;
}

+ (void)tipAlertWithTitle:(id)title leftColor:(UIColor *)leftColor leftTip:(NSString *)leftTip rightColor:(UIColor *)rightColor rightTip:(NSString *)rightTip showVC:(UIViewController *)showVC leftAction:(void (^)(void))leftAction rightAction:(void (^)(void))rightAction
{
    NSString *tempTitle = title;
    NSString *message = @"";
    if ([title isKindOfClass:[NSDictionary class]]) {
        NSDictionary *tempDict = (NSDictionary *)title;
        tempTitle = tempDict[@"title"];
        message = tempDict[@"message"];
    }
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:tempTitle message:message preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *leftAlert = [UIAlertAction actionWithTitle:leftTip style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
        
        [alertController dismissViewControllerAnimated:YES completion:nil];
        if (leftAction) {
            leftAction();
        }
        
    }];
    
    if (leftTip.length >0) {
       [alertController addAction:leftAlert];
    }
    
    UIAlertAction *rightAlert = [UIAlertAction actionWithTitle:rightTip style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        
        if (rightAction) {
            rightAction();
        }
        [alertController dismissViewControllerAnimated:NO completion:nil];
    }];
    
    [alertController addAction:rightAlert];
    
    [leftAlert setValue:leftColor forKey:@"_titleTextColor"];
    [rightAlert setValue:rightColor forKey:@"_titleTextColor"];

    alertController.modalPresentationStyle = UIModalPresentationCustom;
    [showVC presentViewController:alertController animated:YES completion:nil];
}

+ (void)tipAlertWithMessage:(NSString *)message leftColor:(UIColor *)leftColor leftTip:(NSString *)leftTip rightColor:(UIColor *)rightColor rightTip:(NSString *)rightTip showVC:(UIViewController *)showVC leftAction:(void (^)(void))leftAction rightAction:(void (^)(void))rightAction
{
    NSString *tempTitle = @"";
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:tempTitle message:message preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *leftAlert = [UIAlertAction actionWithTitle:leftTip style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
        
        [alertController dismissViewControllerAnimated:YES completion:nil];
        if (leftAction) {
            leftAction();
        }
        
    }];
    
    if (leftTip.length >0) {
       [alertController addAction:leftAlert];
    }
    
    UIAlertAction *rightAlert = [UIAlertAction actionWithTitle:rightTip style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        
        if (rightAction) {
            rightAction();
        }
        [alertController dismissViewControllerAnimated:NO completion:nil];
    }];
    
    [alertController addAction:rightAlert];
    
    [leftAlert setValue:leftColor forKey:@"_titleTextColor"];
    [rightAlert setValue:rightColor forKey:@"_titleTextColor"];

    alertController.modalPresentationStyle = UIModalPresentationCustom;
    [showVC presentViewController:alertController animated:YES completion:nil];
}

+ (void)tipActionSheetWithTitle:(NSString *)title actionTitle1:(NSString *)title1 actionTitle2:(NSString *)title2 actionCancleTitle:(NSString *)cancleTitle  firstAction:(void (^)(void))firstAction secondAction:(void (^)(void))secondAction showVC:(UIViewController *)showVC
{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction *action1 = [UIAlertAction actionWithTitle:title1 style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        if (firstAction) {
            firstAction();
        }
    }];
    [action1 setValue:BlackColor forKey:@"_titleTextColor"];
    if ([title1 isEqualToString:@"删除"]) {
       [action1 setValue:[UIColor redColor] forKey:@"_titleTextColor"];
    }
    
    [alertController addAction:action1];
    if (title2) {
        UIAlertAction *action2 = [UIAlertAction actionWithTitle:title2 style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            if (secondAction) {
                secondAction();
            }
        }];
        [action2 setValue:BlackColor forKey:@"_titleTextColor"];
        [alertController addAction:action2];
    }
    
    UIAlertAction *action3 = [UIAlertAction actionWithTitle:cancleTitle?:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
    }];
    [action3 setValue:BlackColor forKey:@"_titleTextColor"];
    [alertController addAction:action3];
    alertController.modalPresentationStyle = UIModalPresentationCustom;
    [showVC presentViewController:alertController animated:YES completion:nil];
}

+ (void)tipActionSheetWithTitle:(NSString *)title actionTitlesArr:(NSArray *)titlesArr actionCancleTitle:(NSString *)cancleTitle  titlesAction:(void (^)(id index))titlesAction showVC:(UIViewController *)showVC
{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    for (int i=0; i<titlesArr.count; i++) {
        UIAlertAction *action = [UIAlertAction actionWithTitle:titlesArr[i] style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            if (titlesAction) {
                titlesAction(@(i));
            }
        }];
        [action setValue:BlackColor forKey:@"_titleTextColor"];
        [alertController addAction:action];
    }
    
    UIAlertAction *action3 = [UIAlertAction actionWithTitle:cancleTitle?:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
    }];
    [action3 setValue:BlackColor forKey:@"_titleTextColor"];
    [alertController addAction:action3];
    alertController.modalPresentationStyle = UIModalPresentationCustom;
    [showVC presentViewController:alertController animated:YES completion:nil];
}

+ (void)tipAlertWithTitle:(id)title withMessage:(NSString *)message leftColor:(UIColor *)leftColor leftTip:(NSString *)leftTip rightTip:(NSString *)rightTip showVC:(UIViewController *)showVC leftAction:(void (^)(void))leftAction rightAction:(void (^)(void))rightAction
{
    NSString *tempTitle = title;
    if ([title isKindOfClass:[NSDictionary class]]) {
        NSDictionary *tempDict = (NSDictionary *)title;
        tempTitle = tempDict[@"title"];
        message = tempDict[@"message"];
    }
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:tempTitle message:message preferredStyle:UIAlertControllerStyleAlert];
    
    if (leftTip) {
        UIAlertAction *leftAlert = [UIAlertAction actionWithTitle:leftTip style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
            
            [alertController dismissViewControllerAnimated:YES completion:nil];
            if (leftAction) {
                leftAction();
            }
            
        }];
        [alertController addAction:leftAlert];
        [leftAlert setValue:leftColor forKey:@"_titleTextColor"];
        
    }
    if (rightTip) {
        UIAlertAction *rightAlert = [UIAlertAction actionWithTitle:rightTip style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
            
            [alertController dismissViewControllerAnimated:NO completion:nil];
            if (rightAction) {
                rightAction();
            }
        }];
        
        [alertController addAction:rightAlert];
        [rightAlert setValue:UIColorFromRGB(0xfa5151) forKey:@"_titleTextColor"];
    }
    
    
    alertController.modalPresentationStyle = UIModalPresentationCustom;
    [showVC presentViewController:alertController animated:YES completion:nil];
}


+ (void)judgeOpenCameraWithShowVC:(UIViewController *)showVC openAction:(void (^)(void))openAction
{
    PHAuthorizationStatus status = [PHPhotoLibrary authorizationStatus];
    
    if (status == PHAuthorizationStatusDenied) {
        //用户拒绝访问相机
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"提示" message:@"请从[设置-隐私-相机]打开相机访问权限" preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction *cancleAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        }];
        UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"去设置" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            [[UIApplication sharedApplication] openURL:[NSURL  URLWithString:UIApplicationOpenSettingsURLString] options:@{} completionHandler:nil];
        }];
        [alertController addAction:cancleAction];
        [alertController addAction:okAction];
        alertController.modalPresentationStyle = UIModalPresentationCustom;
        [showVC presentViewController:alertController animated:YES completion:nil];
        
    }
    else if (status == PHAuthorizationStatusNotDetermined) {
        //用户还没有做出选择
        //弹框请求用户授权
        [PHPhotoLibrary requestAuthorization:^(PHAuthorizationStatus status1) {
            if (status1 == PHAuthorizationStatusAuthorized) {
                //用户点击了好
                if (openAction) {
                    openAction();
                }
            }
        }];
    }else if (status == PHAuthorizationStatusAuthorized) {
        //用户允许访问相机
        if (openAction) {
            openAction();
        }
    }else{
        [[YZMBPManager sharedMBPManager] showHUDWithText:@"系统原因，无法打开相机"];
    }
}

+ (void)judgeCanOpenAlbumWithShowVC:(UIViewController *)showVC openAction:(void (^)(void))openAction
{
    AVAuthorizationStatus authStatus = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
    
    if (authStatus == AVAuthorizationStatusAuthorized) {
        //允许状态
        if (openAction) {
            openAction();
        }
    }else if (authStatus == AVAuthorizationStatusDenied){
        //拒绝访问相册
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"提示" message:@"请允许访问照片" preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction *cancleAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        }];
        UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"去设置" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            [[UIApplication sharedApplication] openURL:[NSURL  URLWithString:UIApplicationOpenSettingsURLString] options:@{} completionHandler:nil];
        }];
        [alertController addAction:cancleAction];
        
        [alertController addAction:okAction];
        alertController.modalPresentationStyle = UIModalPresentationCustom;
        [showVC presentViewController:alertController animated:YES completion:nil];
        
    }else if (authStatus == AVAuthorizationStatusNotDetermined){
        //未知，第一次申请权限
        [AVCaptureDevice requestAccessForMediaType:AVMediaTypeVideo completionHandler:^(BOOL granted) {
            if (granted) {
                if (openAction) {
                    openAction();
                }
            }
        }];
    }else if (authStatus == PHAuthorizationStatusAuthorized) {
        //用户允许访问相机
        if (openAction) {
            openAction();
        }
    }else{
        [[YZMBPManager sharedMBPManager] showHUDWithText:@"系统原因，无法打开相册"];
    }
    
}

+ (NSDate *)getCurrentTimeWithType:(NSString *)type
{
    NSDateFormatter *formatter=[[NSDateFormatter alloc]init];
    [formatter setDateFormat:type];
    NSString *dateTime=[formatter stringFromDate:[NSDate date]];
    NSDate *date = [formatter dateFromString:dateTime];
    return date;
}

+ (NSDate *)getDateWithString:(NSString *)dateStr type:(NSString *)type
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:type];
    return [dateFormatter dateFromString:dateStr];
}

+ (BOOL)judgeIsBeforeTodayWithDate:(NSDate *)giveDate
{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    unsigned unitFlags = NSCalendarUnitYear | NSCalendarUnitMonth |  NSCalendarUnitDay;
    // 要比较的那个日期，NSDate类型
    NSDateComponents* comp1 = [calendar components:unitFlags fromDate:giveDate];
    // 跟现在的时间相比
    NSDateComponents* comp2 = [calendar components:unitFlags fromDate:[NSDate date]];
    BOOL isSameDay = [comp1 day]==[comp2 day] && [comp1 month]==[comp2 month] && [comp1 year]==[comp2 year];
    if (isSameDay) {
        return YES;
    }
    
    NSTimeInterval inter = [giveDate timeIntervalSinceDate:[NSDate date]];
    return inter<0;
}

+ (NSInteger)caculateSurplusDayWithDate:(NSString *)dateStr
{
    NSDate *endDate = [CommonMethod getDateWithString:dateStr type:@"yyyy-MM-dd"];
    NSTimeInterval inter = [endDate timeIntervalSinceDate:[NSDate date]];
    if (inter<=0) {
        return 0;
    }
    return inter/(3600*24);
}


+(void)getVerificationCode:(UIButton *)Verificationbtn finish:(void (^)(void))finish{
    
    __block int timeout = 60; //倒计时时间
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_source_t _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0,queue);
    dispatch_source_set_timer(_timer,dispatch_walltime(NULL, 0),1.0*NSEC_PER_SEC, 0); //每秒执行
    dispatch_source_set_event_handler(_timer, ^{
        
        if(timeout<=0)
        {
            //倒计时结束，关闭
            dispatch_source_cancel(_timer);
            dispatch_async(dispatch_get_main_queue(), ^{
                //设置界面的按钮显示 根据自己需求设置
                Verificationbtn.userInteractionEnabled = YES;
                [Verificationbtn setTitle:[NSString stringWithFormat:@"获取验证码"] forState:UIControlStateNormal];
                Verificationbtn.userInteractionEnabled = YES;
                if (finish) {
                    finish();
                }
            });
        }
        else
        {
            int seconds = timeout % 60;
            if (seconds != 0) {
                NSString *strTime = [NSString stringWithFormat:@"%.2d", seconds];
                dispatch_async(dispatch_get_main_queue(), ^{
                    [Verificationbtn setBackgroundImage:[UIImage imageWithColor:UIColorFromRGB(0xfefcec)] forState:UIControlStateSelected];
                    [Verificationbtn setTitle:[NSString stringWithFormat:@"%@s",strTime] forState:UIControlStateNormal];
                    Verificationbtn.userInteractionEnabled = NO;
                });
            }
            timeout--;
            
        }
    });
    dispatch_resume(_timer);
    
}

+(int)initlabelwith:(NSString *)labelstr{
    
    CGRect rect = [labelstr boundingRectWithSize:CGSizeMake(1000, 20) options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingTruncatesLastVisibleLine|NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:17.0f]} context:nil];
    return rect.size.width;
}

+(UIImageView *)setViewimag:(UIView *)taskview andimagename:(NSString *)imagestr{
    
    UIImageView *homepagebacimg = [[UIImageView alloc]initWithImage:[UIImage imageNamed:imagestr]];
    homepagebacimg.frame = taskview.bounds;
    homepagebacimg.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    return homepagebacimg;
    
}//设置View背景图片

+(UIBarButtonItem *)Setbarbtntextcolor:(UIColor *)textcolor andtitlestr:(NSString *)textstr{
    
    UIBarButtonItem *barButton = [[UIBarButtonItem alloc] init];
    barButton.title = textstr;
    barButton.tintColor = textcolor;
    return barButton;
}//设置btnitem

+(void)altermethord:(NSString *)titlestr andmessagestr:(NSString *)messagestr andconcelstr:concelstr{
    
    UIAlertView* alert = [[UIAlertView alloc] init];
    alert.title = titlestr;
    alert.message =messagestr;
    [alert addButtonWithTitle:concelstr];
    [alert show];
    
}//提示信息方法//提示信息方法



+(BOOL)validateCarNo:(NSString *)carNo
{
    NSString *carRegex = @"^[A-Za-z]{1}[A-Za-z_0-9]{5}$";
    NSPredicate *carTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",carRegex];
//    NSLog(@"carTest is %@",carTest);
    return [carTest evaluateWithObject:carNo];
    

}


+ (void)tipLoginFromController:(UIViewController *)showController finish:(void (^)(void))finish
{
    SHLoginViewController *loginVC = [[SHLoginViewController alloc]init];
    YMNavigationController *navVc = [[YMNavigationController alloc] initWithRootViewController:loginVC];
    navVc.modalPresentationStyle = UIModalPresentationFullScreen;
    [showController presentViewController:navVc animated:YES completion:nil];
   // [showController.navigationController pushViewController:loginVC animated:NO];
}
@end
