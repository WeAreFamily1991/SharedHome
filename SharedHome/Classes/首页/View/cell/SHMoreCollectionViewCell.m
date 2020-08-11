//
//  SHMoreCollectionViewCell.m
//  SharedHome
//
//  Created by 解辉 on 2020/7/31.
//  Copyright © 2020 NaDao. All rights reserved.
//

#import "SHMoreCollectionViewCell.h"

@implementation SHMoreCollectionViewCell

-(UIImageView *)iconImg
{
    if (!_iconImg) {
        _iconImg = [[UIImageView alloc] init];
        [self addSubview:_iconImg];
        [_iconImg mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(self);
            make.top.mas_equalTo(WScale(15));
            make.width.height.mas_equalTo(WScale(40));
        }];
    }
    return _iconImg;
}

-(UILabel *)titleLabel
{
    if (!_titleLabel) {
        _titleLabel = [UILabel labelWithText:@"" font:kFont(11) textColor:UIColorFromRGB(0x333333) backGroundColor:ClearColor superView:self];
        [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.iconImg.mas_bottom).mas_equalTo(WScale(8));
            make.centerX.mas_equalTo(self);
        }];
    }
    return _titleLabel;
}
@end
