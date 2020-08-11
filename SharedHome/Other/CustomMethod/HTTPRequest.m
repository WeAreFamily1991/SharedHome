//
//  HTTPRequest.m
//  NIMLiveDemo
//
//  Created by 那道 on 2017/9/20.
//  Copyright © 2017年 Netease. All rights reserved.
//

#import "HTTPRequest.h"

@implementation HTTPRequest



static AFHTTPSessionManager *manager;

+ (AFHTTPSessionManager *)httpRequestInit
{
    static dispatch_once_t once;
    dispatch_once(&once, ^{
        manager = [AFHTTPSessionManager manager];
            
            //申明返回的结果是json类型
        manager.responseSerializer = [AFJSONResponseSerializer serializer];
        
//        NSString *resultStr = [NSString stringWithFormat:@"%@%@%@",[XMToolClass getTimeStamp],@"IOS",@"ipzoe*2020"];
//        [manager.requestSerializer setValue:@"IOS" forHTTPHeaderField:@"API_DEVICE"];
//        [manager.requestSerializer setValue:[XMToolClass md5:resultStr] forHTTPHeaderField:@"API_SIGN"];
//        [manager.requestSerializer setValue:[XMToolClass getTimeStamp] forHTTPHeaderField:@"API_TIMESTAMP"];

            //申明请求的数据是json类型
        //    manager.requestSerializer =  [AFJSONRequestSerializer serializer];
            //返回类型
//            manager.responseSerializer.acceptableContentTypes =  [NSSet setWithObjects:@"text/html", @"application/json", @"text/json", @"text/javascript", @"text/plain",@"application/x-javascript",@"image/png",@"text/html",@"text/plain",@"application/x-javascript",@"application/javascript", @"json/text", nil];
//
            [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
            
//            [manager.requestSerializer willChangeValueForKey:@"timeoutInterval"];
//            //请求时间
//            manager.requestSerializer.timeoutInterval= 60;
//            [manager.requestSerializer didChangeValueForKey:@"timeoutInterval"];
//
//            AFSecurityPolicy *securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeNone];
//
//            securityPolicy.allowInvalidCertificates = YES;
//            securityPolicy.validatesDomainName = NO;
//            manager.securityPolicy = securityPolicy;
    });
    
    return manager;
}

+ (instancetype)sharedManager
{
    static HTTPRequest *instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[HTTPRequest alloc] init];
    });
    return instance;
}

-(void)httpWithRequestParameters:(NSDictionary *)parameters urlString:(NSString *)urlString userCanEnable:(BOOL)enable isShowTip:(BOOL)isShowTip isHiddenHUd:(BOOL)isHidden showTitle:(NSString *)title isShowErrorTip:(BOOL)isShowError withSuccess:(void (^)(id responseObject))success
withError:(void (^)(NSError* error))failed
{
    dispatch_async(dispatch_get_main_queue(), ^{
           //回调或者说是通知主线程刷新，
           APPDELEGATE.window.userInteractionEnabled = enable;
           if (isShowTip) {
               [[YZMBPManager sharedMBPManager] hideHUD];
               [[YZMBPManager sharedMBPManager] showRequestHUDWithText:title?:@"加载中"];
           }
       });
    
      NSString *urlString2 = [NSString stringWithFormat:@"%@%@",HttpRequestURL,urlString];
      NSURL *url = [NSURL URLWithString:urlString2];
      //创建请求request
      NSMutableURLRequest *request =[NSMutableURLRequest requestWithURL:url cachePolicy:0 timeoutInterval:30];
      //设置请求方式为POST
      request.HTTPMethod = @"POST";
      //设置请求内容格式
      [request setValue:@"application/json;charset=utf-8" forHTTPHeaderField:@"Content-Type"];
     
      //这是设置请求体，把参数放进请求体(这部分的参数也叫请求参数)
      NSString *paramJsonStr = [self convertToJsonData:parameters];
      NSData *data = [paramJsonStr dataUsingEncoding:NSUTF8StringEncoding];
      request.HTTPBody = [paramJsonStr dataUsingEncoding:NSUTF8StringEncoding];
      
      AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
      manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript", @"text/html",@"image/jpeg",@"text/plain", nil];
      [[manager dataTaskWithRequest:request completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
         // NSLog(@"请求成功---%@---%@",responseObject,[responseObject class]);
          if (!error) {
              dispatch_async(dispatch_get_main_queue(), ^{
                  //回调或者说是通知主线程刷新，
                  if (isHidden) {
                      [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
                      [[YZMBPManager sharedMBPManager] hideHUD];
                      APPDELEGATE.window.userInteractionEnabled = YES;
                  }
              });
              
              if (success) {
                  success(responseObject);
              }
              if ([responseObject[@"code"] integerValue]!=0)
              {
                  dispatch_async(dispatch_get_main_queue(), ^{
                      //回调或者说是通知主线程刷新，
                      [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
                      [[YZMBPManager sharedMBPManager] hideHUD];
                      APPDELEGATE.window.userInteractionEnabled = YES;
                      BOOL isLoginVerify = [urlString containsString:@"Login"]&&[responseObject[@"code"] intValue]==3;
                      if (isShowError && !isLoginVerify) {
                          [[YZMBPManager sharedMBPManager] showHUDWithText:responseObject[@"info"]];
                      }
                  });
                  
              }
          }
          else
          {
              dispatch_async(dispatch_get_main_queue(), ^{
                            //回调或者说是通知主线程刷新，
                            [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
                            APPDELEGATE.window.userInteractionEnabled = YES;
                            [[YZMBPManager sharedMBPManager] hideHUD];
                            if (isShowError) {
                                [[YZMBPManager sharedMBPManager] showHUDWithText:@"网络错误"];
                            }
                        });
                        if (failed) {
                            failed(error);
                        }
          }
      }] resume];
}

#pragma mark - gettoken请求方法
+ (void)postVisiteTokenURL:(NSString *)url parameters:(NSDictionary *)paramers success:(void (^)(id))success failure:(void (^)(NSError *))failure {
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
//    NSString *resultStr = [NSString stringWithFormat:@"%@%@%@",[XMToolClass getTimeStamp],@"IOS",@"ipzoe*2020"];
//    [manager.requestSerializer setValue:@"IOS" forHTTPHeaderField:@"API_DEVICE"];
//    [manager.requestSerializer setValue:[XMToolClass md5:resultStr] forHTTPHeaderField:@"API_SIGN"];
//    [manager.requestSerializer setValue:[XMToolClass getTimeStamp] forHTTPHeaderField:@"API_TIMESTAMP"];
    __weak typeof(self) weakSelf = self;
    
//    [manager GET:url parameters:paramers progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
//
//         NSDictionary*jsonDict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableLeaves error:nil];
//        NZLog(@"lllll == %@",jsonDict);
//    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
//
//    }];
    NSError *error;
    
    
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:paramers options:NSJSONWritingPrettyPrinted error:&error];
    
    NSString *jsonString;
    
    if (!jsonData) {
        
        NSLog(@"%@",error);
        
    }else{
        
        jsonString = [[NSString alloc]initWithData:jsonData encoding:NSUTF8StringEncoding];
        
    }
    
    NSMutableString *mutStr = [NSMutableString stringWithString:jsonString];
    
    NSRange range = {0,jsonString.length};
    
    //去掉字符串中的空格
    
    [mutStr replaceOccurrencesOfString:@" " withString:@"" options:NSLiteralSearch range:range];
    
    NSRange range2 = {0,mutStr.length};
    
    //去掉字符串中的换行符
    
    [mutStr replaceOccurrencesOfString:@"\n" withString:@"" options:NSLiteralSearch range:range2];
    [manager POST:url parameters:mutStr progress:^(NSProgress * _Nonnull uploadProgress) {

    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [weakSelf printResponse:responseObject url:url parameters:paramers];
       // [weakSelf cheakTokenWithResponse:responseObject];
        if (success) {
            success(responseObject);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {

        [weakSelf printError:error url:url parameters:paramers];

        if (failure) {
            failure(error);
        }
    }];
}

+ (void)printResponse:(id)response url:(NSString *)url parameters:(NSDictionary *)params {
    
//    if (![SNAPIManager shareAPIManager].isShowLog) {
//        return;
//    }
//
//    NSString *responseStr = [[response mj_JSONObject] descriptionUTF8];
   NSString *responseStr = [[NSString alloc] initWithData:response encoding:NSUTF8StringEncoding];
    
  //  NSString *urlStr = [self spliceUrlWithUrl:url parameters:params];
    
    NZLog(@"LLL0000 == %@",responseStr);
}

+ (void)printError:(NSError *)error url:(NSString *)url parameters:(NSDictionary *)params {
    
    NZLog(@"LLL22 == %@",error);
//    if (![SNAPIManager shareAPIManager].isShowLog) {
//        return;
//    }
//
//    NSString *urlStr = [self spliceUrlWithUrl:url parameters:params];
//
//    [SNLog log:@"\nURL:\n%@\n错误：\n%@", urlStr, error];
}


- (void)requestDataWithParameters:(NSDictionary *)parameters urlString:(NSString *)urlString userCanEnable:(BOOL)enable isShowTip:(BOOL)isShowTip isHiddenHUd:(BOOL)isHidden showTitle:(NSString *)title isShowErrorTip:(BOOL)isShowError withSuccess:(void (^)(id responseObject))success
withError:(void (^)(NSError* error))failed
{
//    RCNetworkStatus status = [[RCIMClient sharedRCIMClient] getCurrentNetworkStatus];
//
//    if (RC_NotReachable == status) {
//        dispatch_async(dispatch_get_main_queue(), ^{
//            //回调或者说是通知主线程刷新，
//            [[YZMBPManager sharedMBPManager] showHUDWithText:StringWithName(@"network_can_not_use_please_check")];
//
//        });
//        return;
//    }
    dispatch_async(dispatch_get_main_queue(), ^{
        //回调或者说是通知主线程刷新，
        APPDELEGATE.window.userInteractionEnabled = enable;
        if (isShowTip) {
            [[YZMBPManager sharedMBPManager] hideHUD];
            [[YZMBPManager sharedMBPManager] showRequestHUDWithText:title?:@"加载中"];
        }

    });
    
    
    
    AFHTTPSessionManager *manager = [HTTPRequest httpRequestInit];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    if (![urlString containsString:@"http"]) {
        urlString = [NSString stringWithFormat:@"%@%@",HttpRequestURL,urlString];
    }
    
    NZLog(@"UUUUU == %@",urlString);
    //[XMToolClass parseParams:parameters]
    
    NSError *error;
    
    
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:parameters options:NSJSONWritingPrettyPrinted error:&error];
    
    NSString *jsonString;
    
    if (!jsonData) {
        
        NSLog(@"%@",error);
        
    }else{
        
        jsonString = [[NSString alloc]initWithData:jsonData encoding:NSUTF8StringEncoding];
        
    }
    
    NSMutableString *mutStr = [NSMutableString stringWithString:jsonString];
    
    NSRange range = {0,jsonString.length};
    
    //去掉字符串中的空格
    
    [mutStr replaceOccurrencesOfString:@" " withString:@"" options:NSLiteralSearch range:range];
    
    NSRange range2 = {0,mutStr.length};
    
    //去掉字符串中的换行符
    
    [mutStr replaceOccurrencesOfString:@"\n" withString:@"" options:NSLiteralSearch range:range2];
    
    [manager POST:urlString parameters:mutStr progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        dispatch_async(dispatch_get_main_queue(), ^{
            //回调或者说是通知主线程刷新，
            if (isHidden) {
                [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
                [[YZMBPManager sharedMBPManager] hideHUD];
                APPDELEGATE.window.userInteractionEnabled = YES;
            }
        });
        
        if (success) {
            success(responseObject);
        }
        if ([responseObject[@"code"] integerValue]!=0)
        {
            dispatch_async(dispatch_get_main_queue(), ^{
                //回调或者说是通知主线程刷新，
                [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
                [[YZMBPManager sharedMBPManager] hideHUD];
                APPDELEGATE.window.userInteractionEnabled = YES;
                BOOL isLoginVerify = [urlString containsString:@"Login"]&&[responseObject[@"code"] intValue]==3;
                if (isShowError && !isLoginVerify) {
                    [[YZMBPManager sharedMBPManager] showHUDWithText:responseObject[@"info"]];
                }
            });
            
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        dispatch_async(dispatch_get_main_queue(), ^{
            //回调或者说是通知主线程刷新，
            [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
            APPDELEGATE.window.userInteractionEnabled = YES;
            [[YZMBPManager sharedMBPManager] hideHUD];
            if (isShowError) {
                [[YZMBPManager sharedMBPManager] showHUDWithText:@"网络错误"];
            }
        });
        if (failed) {
            failed(error);
        }
    }];
}

- (void)requestUserInfo
{
  
//    if (![Save isLogin]) {
//        return;
//    }
//    [[HTTPRequest sharedManager] requestDataWithParameters:@{@"customer_id":[Save userID]} urlString:[NSString stringWithFormat:@"%@UserinfoDetail", HttpRequestURL] userCanEnable:YES isShowTip:NO isHiddenHUd:YES showTitle:nil isShowErrorTip:YES withSuccess:^(id responseObject) {
//        if ([responseObject[@"code"] integerValue]==0) {
//            User *user = [User mj_objectWithKeyValues:responseObject[@"data"]];
//            User *tempUser = [Save user];
//            user.phone = tempUser.phone;
//            user.password = tempUser.password;
//            user.token = tempUser.token;
//            user.serviceID = tempUser.serviceID;
//            user.loginType = tempUser.loginType;
//            [Save saveUser:user];
//        }
//    } withError:nil];
   
}

- (void)requestCheckVersion
{
    return;
    [self requestUserInfo];
    
    [[HTTPRequest sharedManager] requestDataWithParameters:@{} urlString:[NSString stringWithFormat:@"%@CheckVersionforios", HttpRequestURL] userCanEnable:YES isShowTip:NO isHiddenHUd:YES showTitle:nil isShowErrorTip:NO withSuccess:^(id responseObject) {
        if ([responseObject[@"code"] integerValue]==0) {
            NSDictionary *infoDict = [[NSBundle mainBundle] infoDictionary];
            NSString *appVersion = infoDict[@"CFBundleShortVersionString"];
            NSString *getVersion = responseObject[@"version"];
            if ([self judgeNewVersion:getVersion withOldVersion:appVersion])
            {
                [CommonMethod tipAlertWithTitle:@"检测到最新版本,是否更新?" leftColor:BlackColor leftTip:@"取消" rightColor:BlackColor rightTip:@"确定" showVC:APPDELEGATE.window.rootViewController leftAction:^{
                    exit(1);
                } rightAction:^{
                    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:responseObject[@"data"]]];
                    exit(1);
                }];
            }
            else
            {
            }
        }
    } withError:nil];
}
- (BOOL)judgeNewVersion:(NSString *)newVersion withOldVersion:(NSString *)oldVersion
{
    if (newVersion.length != oldVersion.length) {
        if (newVersion.length >oldVersion.length) {
           oldVersion = [oldVersion stringByAppendingFormat:@".0"];
        }
        else
        {
            newVersion = [newVersion stringByAppendingFormat:@".0"];
        }
    }
    NSArray *newArray = [newVersion componentsSeparatedByCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@"."]];
    NSArray *oldArray = [oldVersion componentsSeparatedByCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@"."]];
    for (NSInteger i = 0; i < newArray.count; i ++) {
        if ([newArray[i] integerValue] > [oldArray[i] integerValue]) {
            return YES;
        } else if ([newArray[i] integerValue] < [oldArray[i] integerValue]) {
            return NO;
        } else { }
    }
    return NO;
}

-(NSString *)convertToJsonData:(NSDictionary *)dict

{

    NSError *error;


    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dict options:NSJSONWritingPrettyPrinted error:&error];

    NSString *jsonString;

    if (!jsonData) {

        NSLog(@"%@",error);

    }else{

        jsonString = [[NSString alloc]initWithData:jsonData encoding:NSUTF8StringEncoding];

    }

    NSMutableString *mutStr = [NSMutableString stringWithString:jsonString];

    NSRange range = {0,jsonString.length};

    //去掉字符串中的空格

    [mutStr replaceOccurrencesOfString:@" " withString:@"" options:NSLiteralSearch range:range];

    NSRange range2 = {0,mutStr.length};

    //去掉字符串中的换行符

    [mutStr replaceOccurrencesOfString:@"\n" withString:@"" options:NSLiteralSearch range:range2];

    return mutStr;

}
@end

