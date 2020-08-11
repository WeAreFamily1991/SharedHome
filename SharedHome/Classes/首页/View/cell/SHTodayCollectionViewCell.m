//
//  SHTodayCollectionViewCell.m
//  SharedHome
//
//  Created by 解辉 on 2020/7/28.
//  Copyright © 2020 NaDao. All rights reserved.
//

#import "SHTodayCollectionViewCell.h"

@implementation SHTodayCollectionViewCell

-(void)setDict:(NSDictionary *)dict
{
    self.headImg.image = [UIImage imageNamed:@"image1"];
    [self titleLabel];
    [self timeImg];
    [self timeLabel];
    [self locationImg];
    [self addressLabel];
    [self distanceLabel];
    [self touBtn];
}

///我要投单
-(void)touBtnClick
{
    
}


-(UIImageView *)headImg
{
    if (!_headImg) {
        _headImg = [[UIImageView alloc] init];
        [self addSubview:_headImg];
        [_headImg mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(self);
            make.left.top.mas_equalTo(WScale(15));
            make.height.mas_equalTo(WScale(150));
        }];
    }
    return _headImg;
}

-(UILabel *)titleLabel
{
    if (!_titleLabel) {
        _titleLabel = [UILabel labelWithText:@"新房装修，需要进行大面积的墙面彩绘" font:[UIFont boldSystemFontOfSize:WScale(14)] textColor:UIColorFromRGB(0x333333) backGroundColor:ClearColor superView:self];
        [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(WScale(15));
            make.top.mas_equalTo(self.headImg.mas_bottom).mas_equalTo(WScale(10));
        }];
    }
    return _titleLabel;
}

-(UIImageView *)timeImg
{
    if (!_timeImg) {
        _timeImg = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"home_time"]];
        [self  addSubview:_timeImg];
        [_timeImg mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(WScale(15));
            make.top.mas_equalTo(self.titleLabel.mas_bottom).mas_equalTo(WScale(15));
        }];
    }
    return _timeImg;;
}

-(UILabel *)timeLabel
{
    if (!_timeLabel) {
        _timeLabel = [UILabel labelWithText:@"期望服务时间：02-02 16:00" font:kFont(12) textColor:UIColorFromRGB(0x999999) backGroundColor:ClearColor superView:self];
        [_timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.timeImg.mas_right).mas_equalTo(WScale(4));
            make.centerY.mas_equalTo(self.timeImg);
        }];
    }
    return _timeLabel;
}

-(UIImageView *)locationImg
{
    if (!_locationImg) {
        _locationImg = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"home_location2"]];
        [self addSubview:_locationImg];
        [_locationImg mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(WScale(15));
            make.bottom.mas_equalTo(WScale(-20));
        }];
    }
    return _locationImg;
}

-(UILabel *)addressLabel
{
    if (!_addressLabel) {
        _addressLabel = [UILabel labelWithText:@"沧浪区" font:kFont(11) textColor:UIColorFromRGB(0x999999) backGroundColor:ClearColor superView:self];
        [_addressLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.locationImg.mas_right).mas_equalTo(WScale(4));
            make.centerY.mas_equalTo(self.locationImg);
        }];
    }
    return _addressLabel;
}

-(UILabel *)distanceLabel
{
    if (!_distanceLabel) {
        _distanceLabel = [UILabel labelWithText:@"1.1km" font:kFont(11) textColor:ThemeColor backGroundColor:ClearColor superView:self];
        [_distanceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.addressLabel.mas_right).mas_equalTo(WScale(12));
            make.centerY.mas_equalTo(self.locationImg);
        }];
    }
    return _distanceLabel;
}

-(BigClickBT *)touBtn
{
    if (!_touBtn) {
        _touBtn = [[BigClickBT alloc] init];
        [_touBtn setTitle:@"我要投单" forState:UIControlStateNormal];
        [_touBtn setTitleColor:WhiteColor forState:UIControlStateNormal];
        _touBtn.titleLabel.font = kFont(12);
        _touBtn.backgroundColor = ThemeColor;
        _touBtn.layer.cornerRadius = WScale(4);
        _touBtn.clipsToBounds = YES;
        [_touBtn addTarget:self action:@selector(touBtnClick) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_touBtn];
        [_touBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.bottom.mas_equalTo(WScale(-15));
            make.width.mas_equalTo(WScale(64));
            make.height.mas_equalTo(WScale(24));
        }];
        
        UILabel *lineLabel = [[UILabel alloc] init];
        lineLabel.backgroundColor = UIColorFromRGB(0xEBEBEB);
        [self addSubview:lineLabel];
        [lineLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(self);
            make.left.mas_equalTo(WScale(15));
            make.bottom.mas_equalTo(0);
            make.height.mas_equalTo(1);
        }];
        self.lineLabel = lineLabel;
    }
    return _touBtn;
}
@end
