//
//  SHIdentificationVC.m
//  SharedHome
//
//  Created by 解辉 on 2020/8/5.
//  Copyright © 2020 NaDao. All rights reserved.
//

#import "SHIdentificationVC.h"

@interface SHIdentificationVC ()<UITextFieldDelegate>

@end

@implementation SHIdentificationVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = WhiteColor;
    self.title = @"个人认证";
    [self setUI];
}

#pragma mark ******** 提交认证
-(void)submitBtnClick
{
    
}

-(void)textFieldChangeAction:(UITextField *)textField
{
    if (textField.tag == 0) {
        
    }
    else if (textField.tag == 1)
    {
        
    }
}

#pragma mark *****************  UI
-(void)setUI
{
    //提示语
    UIButton *tipBtn = [UIButton buttonWithTitle:@"" font:kFont(12) titleColor:UIColorFromRGB(0xFF3640) backGroundColor:UIColorFromRGB(0xFBF2F2) buttonTag:0 target:self action:nil showView:self.view];
    [tipBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.view);
        make.left.mas_equalTo(0);
        make.top.mas_equalTo(SafeAreaTopHeight);
        make.height.mas_equalTo(WScale(50));
    }];
    
    UILabel *tipLabel = [UILabel labelWithText:@"为保障服务质量和服务真实合法性，发布请耐心填写认证信息， 平台将保障用户个人信息不外泄。谢谢配合" font:kFont(12) textColor:UIColorFromRGB(0xFF3640) backGroundColor:ClearColor superView:tipBtn];
    [tipLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.mas_equalTo(tipBtn);
        make.left.mas_equalTo(WScale(15));
    }];
    
    //姓名
    UILabel *nameTitle = [UILabel labelWithText:@"姓名" font:kFont(15) textColor:UIColorFromRGB(0x333333) backGroundColor:ClearColor superView:self.view];
    [nameTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(WScale(15));
        make.top.mas_equalTo(tipBtn.mas_bottom).mas_equalTo(WScale(25));
    }];
    
    UITextField *nameTF = [[UITextField alloc] initWithPlaceholder:@"请填写身份证上姓名" showView:self.view delegate:self showFont:kFont(15) showColor:UIColorFromRGB(0x333333) placeholderColor:UIColorFromRGB(0xB4B4B4)];
    nameTF.tag = 1;
    nameTF.textAlignment = NSTextAlignmentLeft;
    [nameTF addTarget:self action:@selector(textFieldChangeAction:)   forControlEvents:UIControlEventEditingChanged];
    [nameTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(WScale(44));
        make.centerY.mas_equalTo(nameTitle);
        make.left.mas_equalTo(WScale(120));
        make.right.mas_equalTo(WScale(-20));
    }];
    
    
    //身份证号
    UILabel *IDNum = [UILabel labelWithText:@"身份证号" font:kFont(15) textColor:UIColorFromRGB(0x333333) backGroundColor:ClearColor superView:self.view];
    [IDNum mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(WScale(15));
        make.top.mas_equalTo(nameTitle.mas_bottom).mas_equalTo(WScale(25));
    }];
    
    UITextField *IDNumTF = [[UITextField alloc] initWithPlaceholder:@"请填写身份证号码" showView:self.view delegate:self showFont:kFont(15) showColor:UIColorFromRGB(0x333333) placeholderColor:UIColorFromRGB(0xB4B4B4)];
    IDNumTF.tag = 2;
    IDNumTF.textAlignment = NSTextAlignmentLeft;
    [IDNumTF addTarget:self action:@selector(textFieldChangeAction:)   forControlEvents:UIControlEventEditingChanged];
    [IDNumTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(WScale(44));
        make.centerY.mas_equalTo(IDNum);
        make.left.mas_equalTo(WScale(120));
        make.right.mas_equalTo(WScale(-20));
    }];
    
    //提交认证
    UIButton *submitBtn = [UIButton buttonWithTitle:@"提交认证" font:kFont(15) titleColor:WhiteColor backGroundColor:ThemeColor buttonTag:0 target:self action:@selector(submitBtnClick) showView:self.view];
    submitBtn.layer.cornerRadius = 4;
    submitBtn.clipsToBounds = YES;
    [submitBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.view);
        make.left.mas_equalTo(WScale(15));
        make.height.mas_equalTo(WScale(40));
        make.top.mas_equalTo(IDNum.mas_bottom).mas_equalTo(WScale(40));

    }];
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
