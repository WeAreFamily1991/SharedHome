//
//  THWebView.m
//  TianHeProject
//
//  Created by 那道 on 2020/4/10.
//  Copyright © 2020 LWH. All rights reserved.
//

#import "THWebView.h"

@interface THWebView ()<WKNavigationDelegate,WKUIDelegate>

@end

@implementation THWebView

- (instancetype)init
{
    //初始化一个WKWebViewConfiguration对象
    WKWebViewConfiguration *config = [WKWebViewConfiguration new];
    //初始化偏好设置属性：preferences
    config.preferences = [WKPreferences new];
    //The minimum font size in points default is 0;
    //config.preferences.minimumFontSize = 10;
    //是否支持JavaScript
    config.preferences.javaScriptEnabled = YES;
    //不通过用户交互，是否可以打开窗口
    config.preferences.javaScriptCanOpenWindowsAutomatically = NO;
    if (self = [super initWithFrame:CGRectZero configuration:config]) {
        
        self.UIDelegate = self;
        self.navigationDelegate = self;
        
    }
    return self;
}

- (void)setShowContent:(NSString *)showContent
{
    _showContent = showContent;
    [self loadHTMLString:showContent baseURL:nil];
}

//页面加载完成之后调用
-(void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation{
    //获取网页的高度
    [webView evaluateJavaScript:@"document.body.scrollHeight"completionHandler:^(id _Nullable result,NSError * _Nullable error){
        CGFloat wbContentHeight = [result floatValue];
        if (self->_webviewLoadHeight) {
            self->_webviewLoadHeight(wbContentHeight);
        }
    }];
}
//开始加载时调用
-(void)webView:(WKWebView *)webView didStartProvisionalNavigation:(WKNavigation *)navigation{
    
}
//当内容开始返回时调用
-(void)webView:(WKWebView *)webView didCommitNavigation:(WKNavigation *)navigation{
}

// 页面加载失败时调用
- (void)webView:(WKWebView *)webView didFailProvisionalNavigation:(WKNavigation *)navigation{
    
}
@end
