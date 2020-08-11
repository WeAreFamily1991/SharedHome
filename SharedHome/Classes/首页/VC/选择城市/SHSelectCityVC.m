//
//  SHSelectCityVC.m
//  SharedHome
//
//  Created by 解辉 on 2020/7/29.
//  Copyright © 2020 NaDao. All rights reserved.
//

#import "SHSelectCityVC.h"

@interface SHSelectCityVC ()

@property(nonatomic,strong) UILabel *locationLabel;
@end

@implementation SHSelectCityVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"选择城市";
    self.view.backgroundColor = WhiteColor;
    [self setCurrentView];
}

#pragma mark *****************  按钮的点击事件
#pragma mark 刷新
-(void)refreshBtnClick
{
    
}

#pragma mark *****************  UI


#pragma mark 当前定位城市
-(void)setCurrentView
{
    UIImageView *locationImg = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"home_location_green"]];
    [self.view addSubview:locationImg];
    [locationImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(WScale(15));
        make.top.mas_equalTo(SafeAreaTopHeight+WScale(15));
    }];
    
    UILabel *locationLabel = [UILabel labelWithText:@"苏州市 姑苏区" font:kFont(15) textColor:UIColorFromRGB(0x333333) backGroundColor:ClearColor superView:self.view];
    [locationLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(locationImg.mas_right).mas_equalTo(WScale(10));
        make.centerY.mas_equalTo(locationImg);
    }];
    self.locationLabel = locationLabel;
    
    BigClickBT *refreshBtn = [[BigClickBT alloc] init];
    [refreshBtn setImage:[UIImage imageNamed:@"home_refresh"] forState:UIControlStateNormal];
    [refreshBtn  addTarget:self action:@selector(refreshBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:refreshBtn];
    [refreshBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(WScale(-15));
        make.centerY.mas_equalTo(locationImg);
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
