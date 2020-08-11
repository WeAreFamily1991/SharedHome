//
//  HTTPRequest.h
//  NIMLiveDemo
//
//  Created by 那道 on 2017/9/20.
//  Copyright © 2017年 Netease. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface HTTPRequest : NSObject


+ (instancetype)sharedManager;

+ (void)postVisiteTokenURL:(NSString *)url parameters:(NSDictionary *)paramers success:(void (^)(id))success failure:(void (^)(NSError *))failure;

/// 请求接口
/// @param parameters 接口需要的参数
/// @param urlString 接口路径
/// @param enable 请求接口过程中是否可以点击屏幕
/// @param isShowTip 请求接口过程中是否显示“加载中”等提示
/// @param isHidden 请求接口成功后是否隐藏提示
/// @param title 请求接口过程中的提示文字，nil为默认“加载中”，是否显示根据参数isShowTip
/// @param isShowError 是否显示错误提示
/// @param success 成功的回调
/// @param failed 失败的回调
- (void)requestDataWithParameters:(NSDictionary *)parameters urlString:(NSString *)urlString userCanEnable:(BOOL)enable isShowTip:(BOOL)isShowTip isHiddenHUd:(BOOL)isHidden showTitle:(NSString *)title isShowErrorTip:(BOOL)isShowError withSuccess:(void (^)(id responseObject))success
                        withError:(void (^)(NSError* error))failed;

-(void)httpWithRequestParameters:(NSDictionary *)parameters urlString:(NSString *)urlString userCanEnable:(BOOL)enable isShowTip:(BOOL)isShowTip isHiddenHUd:(BOOL)isHidden showTitle:(NSString *)title isShowErrorTip:(BOOL)isShowError withSuccess:(void (^)(id responseObject))success
                       withError:(void (^)(NSError* error))failed;

- (void)requestCheckVersion;

@end

