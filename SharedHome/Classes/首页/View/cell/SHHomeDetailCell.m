//
//  SHHomeDetailCell.m
//  SharedHome
//
//  Created by 解辉 on 2020/7/31.
//  Copyright © 2020 NaDao. All rights reserved.
//

#import "SHHomeDetailCell.h"

#pragma mark ********** 详情
@implementation SHHomeDetailCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
-(void)setDict:(NSDictionary *)dict
{
    self.headImg.image = [UIImage imageNamed:@"image1"];
    [self titleLabel];
    [self timeImg];
    [self timeLabel];
    [self locationImg];
    [self addressLabel];
    [self distanceLabel];
}

-(UIImageView *)headImg
{
    if (!_headImg) {
        _headImg = [[UIImageView alloc] init];
        [self addSubview:_headImg];
        [_headImg mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(self);
            make.left.top.mas_equalTo(WScale(15));
            make.height.mas_equalTo(WScale(225));
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

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end


#pragma mark ********** 文字
@implementation SHHomeDetailTextCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
-(void)setDict:(NSDictionary *)dict
{
    [self contentLabel];
}

-(UILabel *)contentLabel
{
    if (!_contentLabel) {
        _contentLabel = [UILabel labelWithText:@"我家房子租出去了几年，现在收回来我自己住想好 好装修一下。" font:kFont(15) textColor:UIColorFromRGB(0x333333) backGroundColor:ClearColor superView:self];
        _contentLabel.numberOfLines = 0;
        [_contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(WScale(15));
            make.centerX.mas_equalTo(self);
            make.top.mas_equalTo(0);
        }];
    }
    return _contentLabel;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end


#pragma mark ********** 提示
@implementation SHHomeDetailTipCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
-(void)setDict:(NSDictionary *)dict
{
    self.backgroundColor = UIColorFromRGB(0xFBF2F2);
    [self tipImg];
    [self contentLabel];
}

-(UIImageView *)tipImg
{
    if (!_tipImg) {
        _tipImg = [[UIImageView alloc] init];
        _tipImg.image = [UIImage imageNamed:@"home_tip"];
        [self addSubview:_tipImg];
        [_tipImg mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(self);
            make.left.mas_equalTo(WScale(15));
        }];
    }
    return _tipImg;
}

-(UILabel *)contentLabel
{
    if (!_contentLabel) {
        _contentLabel = [UILabel labelWithText:@"您的投单被挑选中后，才能查看雇主详细信息" font:kFont(12) textColor:UIColorFromRGB(0xFF3640) backGroundColor:ClearColor superView:self];
        [_contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
             make.centerY.mas_equalTo(self);
            make.left.mas_equalTo(self.tipImg.mas_right).mas_equalTo(WScale(5));
        }];
    }
    return _contentLabel;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end


#pragma mark ********** 联系人信息
@implementation SHHomeDetailInfoCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
-(void)setDict:(NSDictionary *)dict
{
    [self contentLabel];
}

-(UILabel *)titleLabel
{
    if (!_titleLabel) {
        _titleLabel = [UILabel labelWithText:@"" font:[UIFont boldSystemFontOfSize:WScale(14)] textColor:UIColorFromRGB(0x333333) backGroundColor:ClearColor superView:self];
        [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(self);
            make.left.mas_equalTo(WScale(15));
        }];
    }
    return _titleLabel;
}


-(UILabel *)contentLabel
{
    if (!_contentLabel) {
        _contentLabel = [UILabel labelWithText:@"" font:kFont(14) textColor:UIColorFromRGB(0x333333) backGroundColor:ClearColor superView:self];
        [_contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(self);
            make.left.mas_equalTo(WScale(100));
        }];
    }
    return _contentLabel;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
