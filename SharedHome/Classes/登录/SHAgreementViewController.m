//
//  SHAgreementViewController.m
//  SharedHome
//
//  Created by 解辉 on 2020/7/28.
//  Copyright © 2020 NaDao. All rights reserved.
//

#import "SHAgreementViewController.h"

@interface SHAgreementViewController ()<HHWZWebViewDelegate>

@property (nonatomic, strong) HHWZWebView *webView;

@end

@implementation SHAgreementViewController

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = WhiteColor;
    [self setNavView];
    [self requestData];
}
#pragma mark *****************  按钮的点击事件
#pragma mark 返回
-(void)backBtnClick
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)requestData
{
//    [[HTTPRequest sharedManager] requestDataWithParameters:@{@"type":@(self.type)} urlString:@"/social/getAboutUs.do" userCanEnable:NO isHiddenHUd:YES showTitle:nil withSuccess:^(id responseObject) {
//        if ([responseObject[@"code"] integerValue]==0) {
//            self.webView.htmlStr =  [NSString stringWithFormat:@"<body style=\"word-wrap:break-word;\"> </body> %@", responseObject[@"data"][@"aboutUs"][@"content"]];
//        }
//    } withError:nil];
    
   // self.webView.htmlStr =  [NSString stringWithFormat:@"<body style=\"word-wrap:break-word;\"> </body> %@", responseObject[@"data"][@"aboutUs"][@"content"]];
}

#pragma mark - webview delegate
- (void)wzWebViewDidFinishLoad:(UIWebView *)webView
{
    webView.scrollView.scrollEnabled = YES;
    webView.scrollView.contentSize = CGSizeMake(kWindowW, webView.scrollView.contentSize.height);
}

#pragma mark *****************  UI
#pragma mark 导航栏
-(void)setNavView
{
    UILabel *titleLabel = [UILabel labelWithText:@"" font:[UIFont boldSystemFontOfSize:WScale(17)] textColor:BlackColor backGroundColor:ClearColor superView:self.view];
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.view);
        make.top.mas_equalTo(SafeAreaStateHeight+WScale(10));
    }];
    if(self.type == 1){
        titleLabel.text = @"用户协议";
    }
    else{
        titleLabel.text = @"隐私政策";
    }
    
    BigClickBT *backBtn = [[BigClickBT alloc] init];
    [backBtn setImage:[UIImage imageNamed:@"nav_back"] forState:UIControlStateNormal];
    [backBtn addTarget:self action:@selector(backBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:backBtn];
    [backBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(titleLabel);
        make.left.mas_equalTo(WScale(15));
    }];
}

#pragma mark - Get
- (HHWZWebView *)webView{
    if(!_webView){
        _webView = [[HHWZWebView alloc]init];
        [_webView webViewWithHtmlString:@"" superController:self];
        _webView.scrollView.scrollEnabled = YES;
        _webView.wzDelegate = self;
        _webView.backgroundColor = WhiteColor;
        [self.view addSubview:_webView];
        [_webView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.left.mas_equalTo(0);
            make.top.mas_equalTo(0);
            make.width.mas_equalTo(kWindowW);
        }];
    }
    return _webView;
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self.navigationController setNavigationBarHidden:NO];
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
