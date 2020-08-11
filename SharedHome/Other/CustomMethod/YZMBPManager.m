//
//  YZMBPManager.m
//  YanZhi
//
//  Created by jm on 2017/10/10.
//  Copyright © 2017年 jm. All rights reserved.
//

#import "YZMBPManager.h"
#import "MBProgressHUD.h"

@interface YZMBPManager ()

@property (nonatomic, strong) MBProgressHUD *hud;

@end

@implementation YZMBPManager

+ (instancetype)sharedMBPManager {
    static YZMBPManager *sharedManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedManager = [[self alloc] init];
    });
    return sharedManager;
}

-(void)showRequestHUDWithText:(NSString *)textStr{
    
    UIWindow *window = [[UIApplication sharedApplication] keyWindow];
    self.hud=[[MBProgressHUD alloc]initWithView:window];
    [window addSubview:self.hud];
    self.hud.mode = MBProgressHUDModeText;
    self.hud.detailsLabel.text=textStr;
    self.hud.detailsLabel.font=[UIFont systemFontOfSize:15];
    self.hud.detailsLabel.textColor=[UIColor whiteColor];
    //修改样式，否则等待框背景色将为半透明
    self.hud.bezelView.style = MBProgressHUDBackgroundStyleSolidColor;
    self.hud.bezelView.backgroundColor=RGBACOLOR(0, 0, 0, 0.75);
    [self.hud showAnimated:YES];
}

-(void)showHUDWithText:(NSString *)textStr{
    dispatch_async(dispatch_get_main_queue(), ^{
        //回调或者说是通知主线程刷新，
        UIWindow *window = [[UIApplication sharedApplication] keyWindow];
        self.hud=[[MBProgressHUD alloc]initWithView:window];
        [window addSubview:self.hud];
        self.hud.mode = MBProgressHUDModeText;
        self.hud.detailsLabel.text=textStr;
        self.hud.detailsLabel.font=[UIFont systemFontOfSize:15];
        self.hud.detailsLabel.textColor=[UIColor whiteColor];
        //修改样式，否则等待框背景色将为半透明
        self.hud.bezelView.style = MBProgressHUDBackgroundStyleSolidColor;
        self.hud.bezelView.backgroundColor=RGBACOLOR(0, 0, 0, 0.75);
        [self.hud showAnimated:YES];
        [self.hud hideAnimated:YES afterDelay:1.0];
    });
    
}

-(void)showHUDWithText:(NSString *)textStr toView:(UIView *)showView{
    
    self.hud=[[MBProgressHUD alloc]initWithView:showView];
    [showView addSubview:self.hud];
    self.hud.mode = MBProgressHUDModeIndeterminate;
    self.hud.label.text=textStr;
    self.hud.label.textColor=[UIColor whiteColor];
    self.hud.label.font=[UIFont systemFontOfSize:15];
    //修改样式，否则等待框背景色将为半透明
    self.hud.bezelView.style = MBProgressHUDBackgroundStyleSolidColor;
    self.hud.bezelView.backgroundColor=RGBACOLOR(0, 0, 0, 0.75);
    //self.hud.activityIndicatorColor=[UIColor whiteColor];
    [self.hud showAnimated:YES];
}

-(void)hideHUD{
    
    [self.hud hideAnimated:YES];
    UIWindow *window = [[UIApplication sharedApplication] keyWindow];
    for (MBProgressHUD *hud in window.subviews) {
        if ([hud isKindOfClass:[MBProgressHUD class]]) {
            [hud hideAnimated:NO];
            [hud removeFromSuperview];
        }
    }
}

/*
- (void)showHUDWithText:(NSString *)textStr type:(YZMBPManagerType)type {
    
    UIWindow *window = [[UIApplication sharedApplication] keyWindow];
    self.hud=[[MBProgressHUD alloc]initWithView:window];
    [window addSubview:self.hud];
    self.hud.mode = MBProgressHUDModeCustomView;
    self.hud.label.text=textStr;
    [self.hud showAnimated:YES];
    [self.hud hideAnimated:YES afterDelay:1.0];
}
*/

@end
