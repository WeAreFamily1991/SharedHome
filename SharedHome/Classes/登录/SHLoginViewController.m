//
//  SHLoginViewController.m
//  SharedHome
//
//  Created by 解辉 on 2020/7/27.
//  Copyright © 2020 NaDao. All rights reserved.
//

#import "SHLoginViewController.h"
#import "YMTabBarController.h"
#import "SHBindingViewController.h"
#import "SHAgreementViewController.h"
@interface SHLoginViewController ()<UITextFieldDelegate>
{
    UITextField *_phoneTF;
    UITextField *_codeTF;
}
@property (nonatomic,copy) NSString *phoneStr;
@property (nonatomic,copy) NSString *codeStr;

@end

@implementation SHLoginViewController

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
    [self.navigationController setNavigationBarHidden:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = ThemeColor;
    
    self.codeStr = @"test";
    [self setNavView];
    [self setUI];
}
#pragma mark *****************  网络请求
//登录
-(void)httpWithLogin
{
    NSDictionary *dict = @{@"loginType":@"phone",
                           @"phone":self.phoneStr?:@"",
                           @"code":self.codeStr?:@""
                           };
    [[HTTPRequest sharedManager] httpWithRequestParameters:dict urlString:@"account/thirdLogin" userCanEnable:NO isShowTip:YES isHiddenHUd:YES showTitle:nil isShowErrorTip:nil withSuccess:^(id responseObject)
    {
        NZLog(@"HHHGGG == %@",responseObject);
        [[YZMBPManager sharedMBPManager] showHUDWithText:responseObject[@"msg"]];
        [Save saveUser:[User mj_objectWithKeyValues:responseObject[@"data"]]];
        User *user = [Save user];
        [Save saveUser:user];
        NZLog(@"pppppp == %@",user.token);
        
        [self dismissViewControllerAnimated:YES completion:nil];
        
    } withError:^(NSError *error)
    {
        
    }];

}
#pragma mark *****************  按钮的点击事件
#pragma mark 返回
-(void)backBtnClick
{
   // [self.navigationController popViewControllerAnimated:YES];
    [self dismissViewControllerAnimated:YES completion:nil];
}
#pragma mark - 获取验证码
- (void)clickGetVerify:(UIButton *)sender
{
    NSString *phone = [self.phoneStr stringByReplacingOccurrencesOfString:@" " withString:@""];
    if (phone.length!=11) {
        [[YZMBPManager sharedMBPManager] showHUDWithText:@"请输入正确的手机号"];
        return;
    }
    [_codeTF becomeFirstResponder];
    [CommonMethod getVerificationCode:sender finish:nil];
    /*
    NSDictionary *dict = @{
                           @"phone":phone,
                           @"style":@(self.type+1),//1注册 2忘记密码 3修改密码
                           };
    [[HTTPRequest sharedManager] requestDataWithParameters:dict urlString:@"/social/getVerifyCode.do" userCanEnable:NO isHiddenHUd:YES showTitle:nil withSuccess:^(id responseObject) {
        if ([responseObject[@"code"] integerValue]==0) {
            [[YZMBPManager sharedMBPManager] showHUDWithText:responseObject[@"info"]];
            [self.codeField becomeFirstResponder];
            [CommonMethod GetVerificationCode:sender finish:nil];
        }
    } withError:nil];
     */
}
#pragma mark 登录
-(void)loginBtnClick
{
    NSString *phone = [self.phoneStr stringByReplacingOccurrencesOfString:@" " withString:@""];
    if (phone.length!=11) {
        [[YZMBPManager sharedMBPManager] showHUDWithText:@"请输入正确的手机号"];
        return;
    }
    else if (self.codeStr.length == 0)
    {
        [[YZMBPManager sharedMBPManager] showHUDWithText:@"请输入验证码"];
        return;
    }
    else
    {
        [self httpWithLogin];
    }
}

#pragma mark 用户协议、隐私政策
-(void)LabClick:(UIButton *)button
{
    SHAgreementViewController *agreementVC = [[SHAgreementViewController alloc] init];
    agreementVC.type = button.tag;
    [self.navigationController pushViewController:agreementVC animated:YES];
}

#pragma mark 苹果登录
-(void)appleBtnClick
{
    
}

#pragma mark 微信登录
-(void)wechatBtnClick
{
    SHBindingViewController *bindingVC = [[SHBindingViewController alloc] init];
    [self.navigationController pushViewController:bindingVC animated:YES];
}


-(void)textFieldChangeAction:(UITextField *)textField
{
    if (textField.tag == 0) {
        self.phoneStr = textField.text;
    }
    else if (textField.tag == 1)
    {
        self.codeStr = textField.text;
    }
}

#pragma mark *****************  UI
#pragma mark 导航栏
-(void)setNavView
{
    BigClickBT *backBtn = [[BigClickBT alloc] init];
    [backBtn setImage:[UIImage imageNamed:@"nav_close"] forState:UIControlStateNormal];
    [backBtn addTarget:self action:@selector(backBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:backBtn];
    [backBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(SafeAreaStateHeight+WScale(15));
        make.right.mas_equalTo(WScale(-20));
    }];
}

-(void)setUI
{
    UILabel *titleLabel = [UILabel labelWithText:@"欢迎登录找找" font:[UIFont boldSystemFontOfSize:WScale(22)] textColor:WhiteColor backGroundColor:ClearColor superView:self.view];
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.view);
        make.top.mas_equalTo(WScale(25)+SafeAreaTopHeight);
    }];
    
    UILabel *titleLabel2 = [UILabel labelWithText:@"资源全民共享服务急速到家" font:kFont(11) textColor:WhiteColor backGroundColor:ClearColor superView:self.view];
    [titleLabel2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.view);
        make.top.mas_equalTo(titleLabel.mas_bottom).mas_equalTo(WScale(11));
    }];
    
    ///手机号
    UIView *phoneView = [[UIView alloc] init];
    [self.view addSubview:phoneView];
    [phoneView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.view);
        make.top.mas_equalTo(titleLabel2.mas_bottom).mas_equalTo(WScale(50));
        make.height.mas_equalTo(WScale(55));
        make.width.mas_equalTo(kWindowW);
    }];
    
    UIImageView *phoneImg = [[UIImageView alloc] init];
    phoneImg.image = [UIImage imageNamed:@"login_phone"];
    [phoneView addSubview:phoneImg];
    [phoneImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(phoneView);
        make.left.mas_equalTo(WScale(40));
    }];
    
    UITextField *phoneTF = [[UITextField alloc] initWithPlaceholder:@"请输入手机号" showView:phoneView delegate:self showFont:kFont(15) showColor:WhiteColor placeholderColor:UIColorFromRGB(0xFFFFFF)];
    phoneTF.keyboardType = UIKeyboardTypeNumberPad;
    phoneTF.tag = 0;
    phoneTF.textAlignment = NSTextAlignmentLeft;
    phoneTF.clearButtonMode = UITextFieldViewModeNever;
    [phoneTF addTarget:self action:@selector(textFieldChangeAction:)   forControlEvents:UIControlEventEditingChanged];
    [phoneTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(phoneView);
        make.height.mas_equalTo(WScale(44));
        make.width.mas_equalTo(kWindowW/2);
        make.left.mas_equalTo(phoneImg.mas_right).mas_equalTo(WScale(12));
    }];
    _phoneTF = phoneTF;
    
    UILabel *lineLabel = [[UILabel alloc] init];
    lineLabel.backgroundColor = UIColorFromRGB(0xF5F5F5);
    [phoneView addSubview:lineLabel];
    [lineLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(phoneView);
        make.left.mas_equalTo(WScale(36));
        make.bottom.mas_equalTo(0);
        make.height.mas_equalTo(0.5);
    }];
    
    ///验证码
    UIView *codeView = [[UIView alloc] init];
    [self.view addSubview:codeView];
    [codeView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.view);
        make.top.mas_equalTo(phoneView.mas_bottom).mas_equalTo(WScale(10));
        make.height.mas_equalTo(WScale(55));
        make.width.mas_equalTo(kWindowW);
    }];
    
    UIImageView *codeImg = [[UIImageView alloc] init];
    codeImg.image = [UIImage imageNamed:@"login_code"];
    [codeView addSubview:codeImg];
    [codeImg mas_makeConstraints:^(MASConstraintMaker *make) {
         make.centerY.mas_equalTo(codeView);
         make.left.mas_equalTo(WScale(40));
    }];
    
    UITextField *codeTF = [[UITextField alloc] initWithPlaceholder:@"请输入验证码" showView:codeView delegate:self showFont:kFont(18) showColor:WhiteColor placeholderColor:WhiteColor];
    codeTF.keyboardType = UIKeyboardTypeNumberPad;
    codeTF.tag = 1;
    codeTF.clearButtonMode = UITextFieldViewModeNever;
    codeTF.textAlignment = NSTextAlignmentLeft;
    [codeTF addTarget:self action:@selector(textFieldChangeAction:)   forControlEvents:UIControlEventEditingChanged];
    [codeTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(codeView);
        make.left.mas_equalTo(phoneImg.mas_right).mas_equalTo(WScale(12));
        make.height.mas_equalTo(WScale(44));
        make.width.mas_equalTo(WScale(150));
    }];
    _codeTF = codeTF;
    
    UILabel *lineLabel2 = [[UILabel alloc] init];
    lineLabel2.backgroundColor = UIColorFromRGB(0xF5F5F5);
    [codeView addSubview:lineLabel2];
    [lineLabel2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(codeView);
        make.left.mas_equalTo(WScale(36));
        make.bottom.mas_equalTo(0);
        make.height.mas_equalTo(0.5);
    }];
    
    UIButton *codeBtn = [UIButton buttonWithTitle:@"获取验证码" font:kFont(12) titleColor:WhiteColor backGroundColor:ClearColor buttonTag:0 target:self action:@selector(clickGetVerify:) showView:codeView];
    codeBtn.layer.cornerRadius = WScale(15);
    codeBtn.clipsToBounds = YES;
    codeBtn.layer.borderColor = WhiteColor.CGColor;
    codeBtn.layer.borderWidth = 0.8;
    [codeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(codeView);
        make.width.mas_equalTo(WScale(80));
        make.height.mas_equalTo(WScale(30));
        make.right.mas_equalTo(-WScale(36));
    }];
    
    
    ///登录
    BigClickBT *loginBtn = [[BigClickBT alloc] init];
    [loginBtn setTitle:@"登录" forState:UIControlStateNormal];
    [loginBtn setTitleColor:ThemeColor forState:UIControlStateNormal];
    loginBtn.titleLabel.font = [UIFont boldSystemFontOfSize:WScale(15)];
    loginBtn.backgroundColor = WhiteColor;
    loginBtn.layer.cornerRadius = WScale(20);
    loginBtn.clipsToBounds = YES;
    [loginBtn addTarget:self action:@selector(loginBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:loginBtn];
    [loginBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.view);
        make.top.mas_equalTo(codeView.mas_bottom).mas_equalTo(WScale(50));
        make.width.mas_equalTo(WScale(303));
        make.height.mas_equalTo(WScale(40));
    }];
    
    ///用户协议和隐私政策
    UIView *labelView = [[UIView alloc] init];
    labelView.userInteractionEnabled = YES;
    [self.view addSubview:labelView];
    [labelView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.view);
        make.bottom.mas_equalTo(WScale(-18)-SafeAreaBottomHeight);
        make.height.mas_equalTo(WScale(25));
    }];
    
    UILabel *leftLabel = [UILabel labelWithText:@"登录即代表同意" font:kFont(11) textColor:UIColorFromRGB(0xffffff) backGroundColor:ClearColor superView:labelView];
    [leftLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(labelView);
        make.left.mas_equalTo(0);
    }];
    
    ///用户协议
    BigClickBT *agrBtn = [[BigClickBT alloc] init];
    [agrBtn setTitle:@"《用户协议》" forState:UIControlStateNormal];
    [agrBtn setTitleColor:WhiteColor forState:UIControlStateNormal];
    agrBtn.titleLabel.font = kFont(11);
    agrBtn.tag = 1;
    [agrBtn addTarget:self action:@selector(LabClick:) forControlEvents:UIControlEventTouchUpInside];
    [labelView addSubview:agrBtn];
    [agrBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(leftLabel.mas_right);
        make.centerY.mas_equalTo(labelView.mas_centerY);
    }];
    
    UILabel *lab = [UILabel labelWithText:@"和" font:kFont(11) textColor:UIColorFromRGB(0xffffff) backGroundColor:ClearColor superView:self.view];
    [lab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(agrBtn.mas_right);
        make.centerY.mas_equalTo(labelView.mas_centerY);
    }];
    
    ///隐私政策
    BigClickBT *priBtn = [[BigClickBT alloc] init];
    [priBtn setTitle:@"《隐私政策》" forState:UIControlStateNormal];
    [priBtn setTitleColor:WhiteColor forState:UIControlStateNormal];
    priBtn.titleLabel.font = kFont(11);
    priBtn.tag = 2;
    [priBtn addTarget:self action:@selector(LabClick:) forControlEvents:UIControlEventTouchUpInside];
    [labelView addSubview:priBtn];
    [priBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(lab.mas_right);
        make.centerY.mas_equalTo(labelView.mas_centerY);
        make.right.mas_equalTo(0);
    }];
    
    ///其他登录方式
    UILabel *otherLabel = [UILabel labelWithText:@"第三方账号登录" font:kFont(12) textColor:WhiteColor backGroundColor:ClearColor superView:self.view];
    [otherLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(labelView);
        make.bottom.mas_equalTo(WScale(-135)-SafeAreaBottomHeight);
    }];
    
    BigClickBT *appleBtn = [[BigClickBT alloc] init];
    [appleBtn setImage:[UIImage imageNamed:@"login_apple"] forState:UIControlStateNormal];
    [appleBtn addTarget:self action:@selector(appleBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:appleBtn];
    [appleBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(WScale(114));
        make.bottom.mas_equalTo(WScale(-78)-SafeAreaBottomHeight);
    }];
    
    BigClickBT *wechatBtn = [[BigClickBT alloc] init];
    [wechatBtn setImage:[UIImage imageNamed:@"login_wx"] forState:UIControlStateNormal];
    [wechatBtn addTarget:self action:@selector(wechatBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:wechatBtn];
    [wechatBtn mas_makeConstraints:^(MASConstraintMaker *make) {
         make.right.mas_equalTo(WScale(-114));
         make.centerY.mas_equalTo(appleBtn);
    }];
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;
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
