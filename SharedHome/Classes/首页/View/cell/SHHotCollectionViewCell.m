//
//  SHHotCollectionViewCell.m
//  SharedHome
//
//  Created by 解辉 on 2020/7/29.
//  Copyright © 2020 NaDao. All rights reserved.
//

#import "SHHotCollectionViewCell.h"
#import "SHNeedHomePageVC.h"

@implementation SHHotCollectionViewCell

-(void)setDict:(NSDictionary *)dict
{
    self.bgImg.image = [UIImage imageNamed:@"image2"];
    [self topImg];
    [self bottomImg];
    [self titleLabel];
    self.shopImg.image = [UIImage imageNamed:@"public_bg"];
    [self shopName];
    [self playImg];
}
-(void)tapClick
{
    SHNeedHomePageVC *homePageVC = [[SHNeedHomePageVC alloc] init];
    [self.rootVC.navigationController pushViewController:homePageVC animated:YES];
}

-(UIImageView *)bgImg
{
    if (!_bgImg) {
        _bgImg = [[UIImageView alloc] init];
        _bgImg.layer.cornerRadius = WScale(6);
        _bgImg.clipsToBounds = YES;
        [self addSubview:_bgImg];
        [_bgImg mas_makeConstraints:^(MASConstraintMaker *make) {
            make.center.mas_equalTo(self);
            make.left.top.mas_equalTo(0);
        }];
    }
    return _bgImg;
}

-(UIImageView *)topImg
{
    if (!_topImg) {
        _topImg = [[UIImageView alloc] init];
        [self.bgImg addSubview:_topImg];
        [_topImg mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(self.bgImg);
            make.left.top.mas_equalTo(0);
            make.height.mas_equalTo(WScale(50));
        }];
        
        CAGradientLayer *gl = [CAGradientLayer layer];
        gl.frame = CGRectMake(0,0,self.size.width,WScale(50));
        gl.startPoint = CGPointMake(0, 0);
        gl.endPoint = CGPointMake(1, 1);
        gl.colors = @[(__bridge id)[UIColor colorWithRed:0/255.0 green:0/255.0 blue:0/255.0 alpha:0.0].CGColor,(__bridge id)[UIColor colorWithRed:0/255.0 green:0/255.0 blue:0/255.0 alpha:0.3].CGColor];
        gl.locations = @[@(0.0),@(1.0f)];
        [_topImg.layer addSublayer:gl];
    }
    return _topImg;
}

-(UIImageView *)bottomImg
{
    if (!_bottomImg) {
        _bottomImg = [[UIImageView alloc] init];
        [self.bgImg addSubview:_bottomImg];
        [_bottomImg mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(self.bgImg);
            make.left.bottom.mas_equalTo(0);
            make.height.mas_equalTo(WScale(50));
        }];
        
        CAGradientLayer *gl = [CAGradientLayer layer];
        gl.frame = CGRectMake(0,0,self.size.width,WScale(50));
        gl.startPoint = CGPointMake(0, 0);
        gl.endPoint = CGPointMake(1, 1);
        gl.colors = @[(__bridge id)[UIColor colorWithRed:0/255.0 green:0/255.0 blue:0/255.0 alpha:0.0].CGColor,(__bridge id)[UIColor colorWithRed:0/255.0 green:0/255.0 blue:0/255.0 alpha:0.3].CGColor];
        gl.locations = @[@(0.0),@(1.0f)];
        [_bottomImg.layer addSublayer:gl];
    }
    return _bottomImg;
}

-(UILabel *)titleLabel
{
    if (!_titleLabel) {
        _titleLabel = [UILabel labelWithText:@"手机维修 旧手机回收" font:[UIFont boldSystemFontOfSize:WScale(14)] textColor:WhiteColor backGroundColor:ClearColor superView:self];
        _titleLabel.numberOfLines = 0;
        [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.top.mas_equalTo(WScale(10));
            make.centerX.mas_equalTo(self);
        }];
    }
    return _titleLabel;
}

-(UIImageView *)shopImg
{
    if (!_shopImg) {
        _shopImg = [[UIImageView alloc] init];
        _shopImg.layer.cornerRadius = WScale(11);
        _shopImg.clipsToBounds = YES;
        [self.bottomImg addSubview:_shopImg];
        [_shopImg mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(WScale(10));
            make.bottom.mas_equalTo(WScale(-10));
            make.width.height.mas_equalTo(WScale(22));
        }];
        
        BigClickBT *clickBtn = [[BigClickBT alloc] init];
        [clickBtn addTarget:self action:@selector(tapClick) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:clickBtn];
        [clickBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.center.mas_equalTo(self.bottomImg);
            make.left.mas_equalTo(self.bottomImg.mas_left);
            make.top.mas_equalTo(self.bottomImg.mas_top);
        }];
    }
    return _shopImg;
}

-(UILabel *)shopName
{
    if (!_shopName) {
        _shopName = [UILabel labelWithText:@"西庄裁缝" font:kFont(11) textColor:WhiteColor backGroundColor:ClearColor superView:self];
        [_shopName mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.shopImg.mas_right).mas_equalTo(WScale(6));
            make.centerY.mas_equalTo(self.shopImg);
        }];
    }
    return _shopName;
}

-(UIImageView *)playImg
{
    if (!_playImg) {
        _playImg = [[UIImageView alloc] init];
        _playImg.image = [UIImage imageNamed:@"home_play"];
        [self.bgImg addSubview:_playImg];
        [_playImg mas_makeConstraints:^(MASConstraintMaker *make) {
            make.center.mas_equalTo(self.bgImg);
        }];
    }
    return _playImg;
}
@end
