//
//  SHHomePageCell.m
//  SharedHome
//
//  Created by 解辉 on 2020/7/31.
//  Copyright © 2020 NaDao. All rights reserved.
//

#import "SHHomePageCell.h"
#import "SHChatViewController.h"

@implementation SHHomePageCell

-(void)setDict:(NSDictionary *)dict
{
    [self shopImg];
    [self titleLabel];
    [self renLabel];
    [self chatBtn];
}

///私信
-(void)chatBtnClick
{
    SHChatViewController *chatVC = [[SHChatViewController alloc] init];
    [self.rootVC.navigationController pushViewController:chatVC animated:YES];
}

-(UIImageView *)shopImg
{
    if (!_shopImg) {
        _shopImg = [[UIImageView alloc] init];
        _shopImg.layer.cornerRadius = WScale(36);
        _shopImg.image = [UIImage imageNamed:@"public_bg"];
        _shopImg.clipsToBounds = YES;
        [self addSubview:_shopImg];
        [_shopImg mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(WScale(15));
            make.centerY.mas_equalTo(self);
            make.width.height.mas_equalTo(WScale(72));
        }];
    }
    return _shopImg;
}

-(UILabel *)titleLabel
{
    if (!_titleLabel) {
        _titleLabel = [UILabel labelWithText:@"剪刀沙龙" font:[UIFont boldSystemFontOfSize:WScale(18)] textColor:UIColorFromRGB(0x333333) backGroundColor:ClearColor superView:self];
        [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.shopImg.mas_right).mas_equalTo(WScale(10));
            make.top.mas_equalTo(self.shopImg.mas_top).mas_equalTo(WScale(10));
        }];
    }
    return _titleLabel;
}

-(UILabel *)renLabel
{
    if (!_renLabel) {
        _renLabel = [UILabel labelWithText:@"已认证" font:kFont(10) textColor:ThemeColor backGroundColor:UIColorFromRGB(0xECF7F9) superView:self];
        _renLabel.layer.cornerRadius = 2;
        _renLabel.textAlignment = NSTextAlignmentCenter;
        _renLabel.clipsToBounds = YES;
        [_renLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.shopImg.mas_right).mas_equalTo(WScale(10));
            make.bottom.mas_equalTo(self.shopImg.mas_bottom).mas_equalTo(WScale(-10));
            make.width.mas_equalTo(WScale(44));
            make.height.mas_equalTo(WScale(19));
        }];
    }
    return _renLabel;
}

-(UIButton *)chatBtn
{
    if (!_chatBtn) {
        _chatBtn = [UIButton buttonWithTitle:@"发私信" font:kFont(13) titleColor:UIColorFromRGB(0x333333) backGroundColor:ClearColor buttonTag:0 target:self action:@selector(chatBtnClick) showView:self];
        _chatBtn.layer.borderColor = UIColorFromRGB(0xCCCCCC).CGColor;
        _chatBtn.layer.borderWidth = 0.5;
        _chatBtn.layer.cornerRadius = 4;
        _chatBtn.clipsToBounds = YES;
        [_chatBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(WScale(-15));
            make.centerY.mas_equalTo(self);
            make.width.mas_equalTo(WScale(72));
            make.height.mas_equalTo(WScale(30));
        }];
    }
    return _chatBtn;
}
@end
