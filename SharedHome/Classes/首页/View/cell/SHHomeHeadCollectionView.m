//
//  SHHomeHeadCollectionView.m
//  SharedHome
//
//  Created by 解辉 on 2020/7/28.
//  Copyright © 2020 NaDao. All rights reserved.
//

#import "SHHomeHeadCollectionView.h"

@implementation SHHomeHeadCollectionView

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self headView];
    }
    return self;
}

#pragma mark ************** 按钮的点击事件
//分类按钮的点击事件
-(void)classBtnClick:(UIButton *)button
{
    if (self.classBlock) {
        self.classBlock(button.tag);
    }
}

//今日需求|热门资讯
-(void)typeBtnClick:(UIButton *)button
{
    UIButton *btn1 = (UIButton *)[self viewWithTag:100];
    UIButton *btn2 = (UIButton *)[self viewWithTag:101];
    
    if (button.tag == 100) {
        btn2.selected = NO;
        btn2.titleLabel.font = kFont(15);

    }
    else
    {
        btn1.selected = NO;
        btn1.titleLabel.font = kFont(15);
    }
    
    button.selected = YES;
    button.titleLabel.font = [UIFont boldSystemFontOfSize:WScale(15)];
    self.typeLabel.center = CGPointMake(button.centerX, WScale(38.5));
    self.typeTag = button.tag;
    if (self.block) {
        self.block(button.tag);
    }
}

#pragma mark ************** UI
-(UIView *)headView
{
    if (!_headView) {
        _headView = [[UIView alloc] init];
        _headView.frame = CGRectMake(0,0, kWindowW, WScale(290));
        [self addSubview:_headView];
        [self topImg];
        [self classView];
        [self typeView];
    }
    return _headView;
}
//顶部图片
-(UIButton *)topImg
{
    if (!_topImg) {
        _topImg = [[UIButton alloc] init];
        [_topImg setImage:[UIImage imageNamed:@"image1"] forState:UIControlStateNormal];
        [self.headView addSubview:_topImg];
        [_topImg mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(self.headView);
            make.left.mas_equalTo(WScale(15));
            make.top.mas_equalTo(WScale(8));
            make.height.mas_equalTo(WScale(132));
        }];
    }
    return _topImg;
}

//分类
-(UIView *)classView
{
    if (!_classView) {
        _classView = [[UIView alloc] init];
        [self.headView addSubview:_classView];
        [_classView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(self);
            make.left.mas_equalTo(0);
            make.top.mas_equalTo(self.topImg.mas_bottom);
            make.height.mas_equalTo(WScale(100));
        }];
        
        NSArray *titleArray = @[@"生活服务",@"房产服务",@"装修建材",@"促销购",@"更多需求"];
        NSArray *imgArray = @[@"home_type_sheng",@"home_type_fang",@"home_type_zhuang",@"home_type_cu",@"home_type_geng"];
        
        float width = WScale(60);
        float space = (kWindowW - width*titleArray.count - WScale(20)*2)/4;
        for (int i = 0; i<titleArray.count; i++)
        {
            UIButton *classBtn = [UIButton buttonWithTitle:titleArray[i] font:kFont(11) titleColor:UIColorFromRGB(0x333333) backGroundColor:ClearColor buttonTag:i target:self action:@selector(classBtnClick:) showView:_classView];
            
            [classBtn setImage:[UIImage imageNamed:imgArray[i]] forState:UIControlStateNormal];
            [classBtn mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.mas_equalTo(WScale(20));
                make.left.mas_equalTo(WScale(20)+(width+space)*i);
                make.width.mas_equalTo(width);
                make.height.mas_equalTo(WScale(65));
            }];
            [classBtn layoutButtonWithEdgeInsetsStyle:MKButtonEdgeInsetsStyleTop imageTitleSpace:WScale(10)];
        }
        
        UILabel *lineLabel = [[UILabel alloc] init];
        lineLabel.backgroundColor = UIColorFromRGB(0xff5f5f5);
        [self.headView addSubview:lineLabel];
        [lineLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(self);
            make.left.mas_equalTo(0);
            make.top.mas_equalTo(_classView.mas_bottom);
            make.height.mas_equalTo(WScale(8));
        }];
    }
    return _classView;
}

//今日需求|热门资讯
-(UIView *)typeView
{
    if (!_typeView) {
        _typeView = [[UIView alloc] init];
        [self.headView addSubview:_typeView];
        [_typeView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(self);
            make.left.mas_equalTo(0);
            make.top.mas_equalTo(self.classView.mas_bottom).mas_equalTo(WScale(8));
            make.height.mas_equalTo(WScale(40));
        }];
        
        float width = WScale(80);
        
        ///今日需求
        UIButton *todayBtn = [UIButton buttonWithTitle:@"今日需求" font:kFont(15) titleColor:UIColorFromRGB(0xB4B4B4) backGroundColor:ClearColor buttonTag:100 target:self action:@selector(typeBtnClick:) showView:_typeView];
        todayBtn.frame = CGRectMake(kWindowW/2-width-WScale(15), 0, width, WScale(40));
        [todayBtn setTitleColor:UIColorFromRGB(0x333333) forState:UIControlStateSelected];
        todayBtn.selected = YES;
        todayBtn.titleLabel.font = [UIFont boldSystemFontOfSize:WScale(15)];
        
        ///热门资源
        UIButton *hotBtn = [UIButton buttonWithTitle:@"热门资源" font:kFont(15) titleColor:UIColorFromRGB(0xB4B4B4) backGroundColor:ClearColor buttonTag:101 target:self action:@selector(typeBtnClick:) showView:_typeView];
        hotBtn.frame = CGRectMake(kWindowW/2+WScale(15), 0, width, WScale(40));
        [hotBtn setTitleColor:UIColorFromRGB(0x333333) forState:UIControlStateSelected];
        [hotBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(_typeView);
            make.width.mas_equalTo(width);
            make.right.mas_equalTo(WScale(-100));
            make.height.mas_equalTo(WScale(40));
        }];
        
        UILabel *typeLabel = [[UILabel alloc] init];
        typeLabel.backgroundColor = ThemeColor;
        typeLabel.bounds = CGRectMake(0, 0, WScale(30),3);
        typeLabel.center = CGPointMake(todayBtn.centerX, WScale(38.5));
        [self.typeView addSubview:typeLabel];
        self.typeLabel = typeLabel;
        
        ///线
        UILabel *lineLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, WScale(40)-0.5,kWindowW, 0.5)];
        lineLabel.backgroundColor = UIColorFromRGB(0xEBEBEB);
        [_typeView addSubview:lineLabel];
        
    }
    return _typeView;
}


@end
