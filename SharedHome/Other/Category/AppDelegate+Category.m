//
//  AppDelegate+Category.m
//  XMBasePj
//
//  Created by WenhuaLuo on  16/3/2.
//  Copyright © 2016年 WXIAOM. All rights reserved.
//

#import "AppDelegate+Category.h"
#import "AFNetworkActivityIndicatorManager.h"


@implementation AppDelegate (Category)
#pragma mark - *******************************  检测网络状况  *******************************
- (void)monitorNetWork{
    //电池条显示网络活动
    [[AFNetworkActivityIndicatorManager sharedManager] setEnabled:YES];
    //检测网络状态
    [[AFNetworkReachabilityManager sharedManager] setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        if (status<1) {
            UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:@"当前网络不可用，请检查！" message:nil preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            }];
            [alertVC addAction:cancelAction];
            //初始化UIWindows
            UIWindow *alertWindow = [[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
//            alertWindow.rootViewController = [[UIViewController alloc]init];
            alertWindow.windowLevel = UIWindowLevelAlert + 1;
            [alertWindow makeKeyAndVisible];
            alertVC.modalPresentationStyle = UIModalPresentationCustom;
            [alertWindow.rootViewController presentViewController:alertVC animated:YES completion:nil];
            
            
            //APPDELEGATE.window.rootViewController = [[ViewController alloc] init];
        }
    }];
    [[AFNetworkReachabilityManager sharedManager] startMonitoring];
}


@end
