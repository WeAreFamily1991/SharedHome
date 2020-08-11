//
//  SHGoPayViewController.m
//  SharedHome
//
//  Created by 解辉 on 2020/8/5.
//  Copyright © 2020 NaDao. All rights reserved.
//

#import "SHGoPayViewController.h"

@interface SHGoPayViewController ()

@property (nonatomic,assign) NSInteger payTag;
@property (nonatomic,strong) UIButton *payBtn;
@end

@implementation SHGoPayViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = WhiteColor;
    self.title = @"去支付";
    
    self.payTag = 100;
    [self setUI];
}
#pragma mark ***************** 按钮的点击事件
//选择支付方式
-(void)selectBtnClick:(UIButton *)button
{
    for (int i = 0; i<2; i++) {
        if (button.tag == 100+i) {
            button.selected = YES;
            continue;
        }
        UIButton *btn = (UIButton *)[self.view viewWithTag:100+i];
        btn.selected = NO;
    }
    self.payTag = button.tag;
}

//去支付
-(void)payBtnClick
{
    
}

#pragma mark ***************** UI
-(void)setUI
{
    ///支付金额
    UILabel *moneyLabel = [UILabel labelWithText:@"¥199.50" font:[UIFont boldSystemFontOfSize:WScale(24)] textColor:UIColorFromRGB(0x333333) backGroundColor:ClearColor superView:self.view];
    [moneyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(SafeAreaTopHeight+WScale(30));
        make.centerX.mas_equalTo(self.view);
    }];
    
    UILabel *moneyTipLabel = [UILabel labelWithText:@"发布短视频费用" font:kFont(14) textColor:UIColorFromRGB(0x999999) backGroundColor:ClearColor superView:self.view];
    [moneyTipLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(moneyLabel.mas_bottom).mas_equalTo(WScale(13));
        make.centerX.mas_equalTo(self.view);
    }];
    
    
    ///支付方式
    UILabel *payTipLabel = [UILabel labelWithText:@"支付方式" font:kFont(15) textColor:UIColorFromRGB(0x323038) backGroundColor:ClearColor superView:self.view];
    [payTipLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(moneyTipLabel.mas_bottom).mas_equalTo(WScale(40));
        make.left.mas_equalTo(WScale(20));
    }];
    
    NSArray *imgArray = @[@"pay_wx",@"pay_zhi"];
    NSArray *titleArray = @[@"微信支付",@"支付宝"];
    for (int i = 0; i<2; i++) {
        
        UIImageView *payImg = [[UIImageView alloc] initWithImage:[UIImage imageNamed:imgArray[i]]];
        [self.view addSubview:payImg];
        [payImg mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(WScale(20));
            make.top.mas_equalTo(payTipLabel.mas_bottom).mas_equalTo(WScale(30)+WScale(45)*i);
        }];
        
        UILabel *payLabel = [UILabel labelWithText:titleArray[i] font:kFont(15) textColor:UIColorFromRGB(0x323038) backGroundColor:ClearColor superView:self.view];
        [payLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(payImg.mas_right).mas_equalTo(WScale(10));
            make.centerY.mas_equalTo(payImg);
        }];
        
        BigClickBT *selectBtn = [[BigClickBT alloc] init];
        selectBtn.tag = 100+i;
        [selectBtn setImage:[UIImage imageNamed:@"pay_quan_normal"] forState:UIControlStateNormal];
        [selectBtn setImage:[UIImage imageNamed:@"pay_quan_select"] forState:UIControlStateSelected];
        [selectBtn addTarget:self action:@selector(selectBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:selectBtn];
        [selectBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(WScale(-20));
            make.centerY.mas_equalTo(payImg);
        }];
        if (i == 0) {
            selectBtn.selected = YES;
        }
    }
    
    //去支付
    self.payBtn = [UIButton buttonWithTitle:@"去支付" font:kFont(15) titleColor:WhiteColor backGroundColor:ThemeColor buttonTag:0 target:self action:@selector(payBtnClick) showView:self.view];
    self.payBtn.layer.cornerRadius = 4;
    self.payBtn.clipsToBounds = YES;
    [self.payBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.view);
        make.left.mas_equalTo(WScale(15));
        make.height.mas_equalTo(WScale(40));
        make.bottom.mas_equalTo(-SafeAreaBottomHeight-WScale(15));
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
