//
//  YZMBPManager.h
//  YanZhi
//
//  Created by jm on 2017/10/10.
//  Copyright © 2017年 jm. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, YZMBPManagerType)
{
    YZMBPManagerTypeDone = 0,//成功
    YZMBPManagerTypeError,//错误
    YZMBPManagerTypeWarning,//警告
    YZMBPManagerTypeCancel,//取消
};

@interface YZMBPManager : NSObject

+(instancetype)sharedMBPManager;

-(void)showHUDWithText:(NSString *)textStr;

-(void)showRequestHUDWithText:(NSString *)textStr;
-(void)showHUDWithText:(NSString *)textStr toView:(UIView *)showView;

-(void)hideHUD;

//- (void)showHUDWithText:(NSString *)textStr type:(YZMBPManagerType)type;

@end
