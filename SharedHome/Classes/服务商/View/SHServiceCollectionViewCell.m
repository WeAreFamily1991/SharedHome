//
//  SHServiceCollectionViewCell.m
//  SharedHome
//
//  Created by 解辉 on 2020/8/3.
//  Copyright © 2020 NaDao. All rights reserved.
//

#import "SHServiceCollectionViewCell.h"

@implementation SHServiceCollectionViewCell

-(void)setDict:(NSDictionary *)dict
{
    [self bgView];
    [self headImg];
    [self nameLabel];
    [self contentLabel];
    [self numLabel];
}

-(UIView *)bgView
{
    if (!_bgView) {
        _bgView = [[UIView alloc] init];
        _bgView.backgroundColor = [UIColor whiteColor];
        _bgView.layer.cornerRadius = WScale(8);
        _bgView.clipsToBounds = YES;
        [self addSubview:_bgView];
        [_bgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.center.mas_equalTo(self);
            make.left.top.mas_equalTo(0);
        }];
    }
    return _bgView;
}

-(UIImageView *)headImg
{
    if (!_headImg) {
        _headImg = [[UIImageView alloc] init];
        _headImg.layer.cornerRadius = WScale(27);
        _headImg.clipsToBounds = YES;
        _headImg.image = [UIImage imageNamed:@"public_bg"];
        [self.bgView addSubview:_headImg];
        [_headImg mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(self.bgView);
            make.top.mas_equalTo(WScale(22));
            make.width.height.mas_equalTo(WScale(54));
        }];
    }
    return _headImg;
}

-(UILabel *)nameLabel
{
    if (!_nameLabel) {
        _nameLabel = [UILabel labelWithText:@"剪刀沙龙" font:[UIFont boldSystemFontOfSize:WScale(15)] textColor:UIColorFromRGB(0x333333) backGroundColor:ClearColor superView:self.bgView];
        [_nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(self.bgView);
            make.top.mas_equalTo(self.headImg.mas_bottom).mas_equalTo(WScale(10));
        }];
    }
    return _nameLabel;
}

-(UILabel *)contentLabel
{
    if (!_contentLabel) {
        _contentLabel = [UILabel labelWithText:@"裁衣改衣丨熨烫丨修补..." font:kFont(12) textColor:UIColorFromRGB(0x666666) backGroundColor:ClearColor superView:self.bgView];
        _contentLabel.textAlignment = NSTextAlignmentCenter;
        [_contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(self.bgView);
            make.top.mas_equalTo(self.nameLabel.mas_bottom).mas_equalTo(WScale(10));
            make.left.mas_equalTo(WScale(20));
        }];
    }
    return _contentLabel;
}

-(UILabel *)numLabel
{
    if (!_numLabel) {
        _numLabel = [UILabel labelWithText:@"月接单564" font:kFont(10) textColor:UIColorFromRGB(0x999999) backGroundColor:ClearColor superView:self.bgView];
        [_numLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(self.bgView);
            make.top.mas_equalTo(self.contentLabel.mas_bottom).mas_equalTo(WScale(14));
        }];
    }
    return _numLabel;
}

@end
