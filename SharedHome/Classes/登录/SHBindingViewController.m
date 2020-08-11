//
//  SHBindingViewController.m
//  SharedHome
//
//  Created by 解辉 on 2020/7/28.
//  Copyright © 2020 NaDao. All rights reserved.
//

#import "SHBindingViewController.h"
#import "YMTabBarController.h"

@interface SHBindingViewController ()<UITextFieldDelegate>
{
    UITextField *_phoneTF;
    UITextField *_codeTF;
}
@property (nonatomic,copy) NSString *phoneStr;
@property (nonatomic,copy) NSString *codeStr;
@end

@implementation SHBindingViewController

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
    [self.navigationController setNavigationBarHidden:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = ThemeColor;
    [self setNavView];
    [self setUI];
}
#pragma mark *****************  按钮的点击事件
#pragma mark 返回
-(void)backBtnClick
{
    [self.navigationController popViewControllerAnimated:YES];
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
#pragma mark 绑定手机号
-(void)bindingBtnClick
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
        APPDELEGATE.window.rootViewController = [[YMTabBarController alloc] init];
    }
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
    ///手机号
    UIView *phoneView = [[UIView alloc] init];
    phoneView.backgroundColor = [UIColor colorWithWhite:1 alpha:0.2];
    phoneView.layer.cornerRadius = WScale(20);
    phoneView.clipsToBounds = YES;
    [self.view addSubview:phoneView];
    [phoneView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.view);
        make.top.mas_equalTo(SafeAreaTopHeight+WScale(40));
        make.height.mas_equalTo(WScale(40));
        make.width.mas_equalTo(WScale(303));
    }];
    
    UITextField *phoneTF = [[UITextField alloc] initWithPlaceholder:@"手机号" showView:phoneView delegate:self showFont:kFont(15) showColor:WhiteColor placeholderColor:UIColorFromRGB(0xFFFFFF)];
    phoneTF.keyboardType = UIKeyboardTypeNumberPad;
    phoneTF.tag = 0;
    phoneTF.textAlignment = NSTextAlignmentLeft;
    phoneTF.clearButtonMode = UITextFieldViewModeNever;
    [phoneTF addTarget:self action:@selector(textFieldChangeAction:)   forControlEvents:UIControlEventEditingChanged];
    [phoneTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.mas_equalTo(phoneView);
        make.left.mas_equalTo(WScale(20));
    }];
    _phoneTF = phoneTF;

    
    ///验证码
    UIView *codeView = [[UIView alloc] init];
    codeView.backgroundColor = [UIColor colorWithWhite:1 alpha:0.2];
    codeView.layer.cornerRadius = WScale(20);
    codeView.clipsToBounds = YES;
    [self.view addSubview:codeView];
    [codeView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.view);
        make.top.mas_equalTo(phoneView.mas_bottom).mas_equalTo(WScale(12));
        make.height.mas_equalTo(WScale(40));
        make.width.mas_equalTo(WScale(303));
    }];
    
    UITextField *codeTF = [[UITextField alloc] initWithPlaceholder:@"验证码" showView:codeView delegate:self showFont:kFont(18) showColor:WhiteColor placeholderColor:WhiteColor];
    codeTF.keyboardType = UIKeyboardTypeNumberPad;
    codeTF.tag = 1;
    codeTF.clearButtonMode = UITextFieldViewModeNever;
    codeTF.textAlignment = NSTextAlignmentLeft;
    [codeTF addTarget:self action:@selector(textFieldChangeAction:)   forControlEvents:UIControlEventEditingChanged];
    [codeTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.mas_equalTo(codeView);
        make.left.mas_equalTo(WScale(20));
        make.width.mas_equalTo(WScale(150));
    }];
    _codeTF = codeTF;
    
    UIButton *codeBtn = [UIButton buttonWithTitle:@"获取验证码" font:kFont(12) titleColor:WhiteColor backGroundColor:ClearColor buttonTag:0 target:self action:@selector(clickGetVerify:) showView:codeView];
    [codeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(codeView);
        make.width.mas_equalTo(WScale(80));
        make.height.mas_equalTo(WScale(30));
        make.right.mas_equalTo(-WScale(15));
    }];
    
    
    ///确认绑定
    BigClickBT *bindingBtn = [[BigClickBT alloc] init];
    [bindingBtn setTitle:@"确认绑定" forState:UIControlStateNormal];
    [bindingBtn setTitleColor:ThemeColor forState:UIControlStateNormal];
    bindingBtn.titleLabel.font = [UIFont boldSystemFontOfSize:WScale(15)];
    bindingBtn.backgroundColor = WhiteColor;
    bindingBtn.layer.cornerRadius = WScale(20);
    [bindingBtn addTarget:self action:@selector(bindingBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:bindingBtn];
    [bindingBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.view);
        make.top.mas_equalTo(codeView.mas_bottom).mas_equalTo(WScale(40));
        make.width.mas_equalTo(WScale(303));
        make.height.mas_equalTo(WScale(40));
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
