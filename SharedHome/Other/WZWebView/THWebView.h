//
//  THWebView.h
//  TianHeProject
//
//  Created by 那道 on 2020/4/10.
//  Copyright © 2020 LWH. All rights reserved.
//

#import <WebKit/WebKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^WebviewLoadHeight)(CGFloat height);
@interface THWebView : WKWebView

@property (nonatomic, copy) NSString *showContent;
@property (nonatomic, copy) WebviewLoadHeight webviewLoadHeight;

@end

NS_ASSUME_NONNULL_END
