//
//  SHServiceHomePageCell.m
//  SharedHome
//
//  Created by 解辉 on 2020/8/3.
//  Copyright © 2020 NaDao. All rights reserved.
//

#import "SHServiceHomePageCell.h"
#import "SHChatViewController.h"

@implementation SHServiceHomePageCell

-(void)setDict:(NSDictionary *)dict
{
    [self shopImg];
    [self titleLabel];
    [self labelView];
    [self chatBtn];
    [self classLabel];
    [self numLabel];
    [self locationImg];
    [self arrowImg];
    [self locationLabel];
}
-(void)locationClick:(UIButton *)button
{
    button.selected = !button.selected;
    if (self.LocationBlock) {
        self.LocationBlock(button.selected);
    }
    self.locationImgView.hidden = !button.selected;
    if (button.selected) {
        self.arrowImg.image = [UIImage imageNamed:@"home_arrow2"];
    }
    else
    {
         self.arrowImg.image = [UIImage imageNamed:@"home_arrow"];
    }
}

///标签
-(void)setTypeArray:(NSArray *)typeArray
{
    [self.labelView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    float leftSpace = WScale(10);
    for (int i = 0; i<typeArray.count; i++)
    {
        CGSize size = [NSString sizeWithText:typeArray[i] font:kFont(10) maxSize:CGSizeMake(WScale(100), WScale(19))];
       UILabel *typeLabel = [UILabel labelWithText:typeArray[i] font:kFont(10) textColor:ThemeColor backGroundColor:UIColorFromRGB(0xECF7F9) superView:self];
       typeLabel.layer.cornerRadius = 2;
       typeLabel.textAlignment = NSTextAlignmentCenter;
       typeLabel.clipsToBounds = YES;
       [typeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
           make.left.mas_equalTo(self.shopImg.mas_right).mas_equalTo(leftSpace);
           make.top.mas_equalTo(WScale(50));
           make.width.mas_equalTo(size.width+WScale(15));
           make.height.mas_equalTo(WScale(19));
       }];
        
        leftSpace = leftSpace+size.width+WScale(15)+WScale(6);
    }
}
///定位图片
-(void)setImgArray:(NSArray *)imgArray
{
    [self.locationImgView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    float leftSpace = WScale(10);
    for (int i = 0; i<imgArray.count; i++)
    {
        UIImageView *locationImg = [[UIImageView alloc] initWithFrame:CGRectMake(leftSpace, 0, WScale(135), WScale(90))];
        [locationImg sd_setImageWithURL:[NSURL URLWithString:imgArray[i]] placeholderImage:[UIImage imageNamed:@"public_bg"]];
        [self.locationImgView addSubview:locationImg];
        leftSpace = leftSpace+WScale(135)+WScale(6);
    }
    self.locationImgView.contentSize = CGSizeMake(leftSpace+WScale(15), WScale(90));
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
            make.top.mas_equalTo(WScale(15));
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
            make.top.mas_equalTo(self.shopImg.mas_top).mas_equalTo(WScale(2));
        }];
    }
    return _titleLabel;
}
-(UIView *)labelView
{
    if (!_labelView) {
        _labelView = [[UIView alloc] init];
        [self addSubview:_labelView];
        [_labelView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.shopImg.mas_right).mas_equalTo(WScale(10));
            make.top.mas_equalTo(self.titleLabel.mas_bottom).mas_equalTo(WScale(10));
            make.width.mas_equalTo(kWindowW/2);
            make.height.mas_equalTo(WScale(20));
        }];
    }
    return _labelView;
}

-(UILabel *)classLabel
{
    if (!_classLabel) {
        _classLabel = [UILabel labelWithText:@"家具安装丨门窗定制" font:kFont(11) textColor:UIColorFromRGB(0x999999) backGroundColor:ClearColor superView:self];
        [_classLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.shopImg.mas_right).mas_equalTo(WScale(10));
            make.top.mas_equalTo(self.labelView.mas_bottom).mas_equalTo(WScale(8));
        }];
    }
    return _classLabel;
}

-(UILabel *)numLabel
{
    if (!_numLabel) {
        _numLabel = [UILabel labelWithText:@"月接单 156" font:kFont(11) textColor:UIColorFromRGB(0x999999) backGroundColor:ClearColor superView:self];
        [_numLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.shopImg.mas_right).mas_equalTo(WScale(10));
            make.top.mas_equalTo(self.classLabel.mas_bottom).mas_equalTo(WScale(6));
        }];
    }
    return _numLabel;
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
            make.top.mas_equalTo(self.shopImg.mas_top);
            make.width.mas_equalTo(WScale(72));
            make.height.mas_equalTo(WScale(30));
        }];
    }
    return _chatBtn;
}

-(UIButton *)locationBtn
{
    if (!_locationBtn) {
        _locationBtn = [[UIButton alloc] init];
        [_locationBtn addTarget:self action:@selector(locationClick:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_locationBtn];
        [_locationBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.mas_equalTo(0);
            make.top.mas_equalTo(self.numLabel.mas_bottom);
            make.height.mas_equalTo(WScale(35));
        }];
    }
    return _locationBtn;
}

-(UIImageView *)locationImg
{
    if (!_locationImg) {
        _locationImg = [[UIImageView alloc] init];
        _locationImg.image = [UIImage imageNamed:@"home_location_green"];
        [self.locationBtn addSubview:_locationImg];
        [_locationImg mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(WScale(15));
            make.centerY.mas_equalTo(self.locationBtn);
        }];
    }
    return _locationImg;
}

-(UIImageView *)arrowImg
{
    if (!_arrowImg) {
        _arrowImg = [[UIImageView alloc] init];
        _arrowImg.image = [UIImage imageNamed:@"home_arrow"];
        [self.locationBtn addSubview:_arrowImg];
        [_arrowImg mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(WScale(-15));
            make.centerY.mas_equalTo(self.locationImg);
        }];
    }
    return _arrowImg;
}

-(UILabel *)locationLabel
{
    if (!_locationLabel) {
        _locationLabel = [UILabel labelWithText:@"江苏省苏州市姑苏区娄江新村1-604" font:kFont(14) textColor:UIColorFromRGB(0x333333) backGroundColor:ClearColor superView:self.locationBtn];
        [_locationLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.locationImg.mas_right).mas_equalTo(WScale(5));
            make.centerY.mas_equalTo(self.locationImg);
            make.right.mas_equalTo(self.arrowImg.mas_left).mas_equalTo(WScale(-5));
        }];
    }
    return _locationLabel;
}

-(UIScrollView *)locationImgView
{
    if (!_locationImgView) {
        _locationImgView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, WScale(258)-WScale(90)-WScale(15), kWindowW, WScale(90))];
        _locationImgView.showsVerticalScrollIndicator = NO;
        _locationImgView.showsHorizontalScrollIndicator = NO;
        _locationImgView.hidden = YES;
        [self addSubview:_locationImgView];
    }
    return _locationImgView;
}
@end
