//
//  SHMyInfoTableViewCell.m
//  SharedHome
//
//  Created by 解辉 on 2020/8/6.
//  Copyright © 2020 NaDao. All rights reserved.
//

#import "SHMyInfoTableViewCell.h"


#pragma mark ****************** 头部个人信息
@implementation SHMyInfoTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
-(void)setDict:(NSDictionary *)dict
{
    [self shopImg];
    [self titleLabel];
    [self classBtn];
    [self moneyView];
    [self moneyLabel];
    [self cashBtn];
    [self phoneTipLabel];
    [self phoneBtn];
}

///分类
-(void)classBtnClick
{
    
}

//提现
-(void)cashBtnClick
{
    
}

//客服电话
-(void)phoneBtnClick
{
    
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

-(UIImageView *)shopImg
{
    if (!_shopImg) {
        _shopImg = [[UIImageView alloc] init];
        _shopImg.layer.cornerRadius = WScale(28);
        _shopImg.image = [UIImage imageNamed:@"public_bg"];
        _shopImg.clipsToBounds = YES;
        [self addSubview:_shopImg];
        [_shopImg mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.top.mas_equalTo(WScale(15));
            make.width.height.mas_equalTo(WScale(56));
        }];
    }
    return _shopImg;
}

-(UILabel *)titleLabel
{
    if (!_titleLabel) {
        _titleLabel = [UILabel labelWithText:@"剪刀沙龙" font:[UIFont boldSystemFontOfSize:WScale(18)] textColor:UIColorFromRGB(0x333333) backGroundColor:ClearColor superView:self];
        [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.shopImg.mas_right).mas_equalTo(WScale(15));
            make.top.mas_equalTo(WScale(20));
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

-(BigClickBT *)classBtn
{
    if (!_classBtn) {
        _classBtn = [[BigClickBT alloc] init];
        [_classBtn setTitle:@"家具安装丨门窗定制" forState:UIControlStateNormal];
        [_classBtn setTitleColor:UIColorFromRGB(0x999999) forState:UIControlStateNormal];
        _classBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
        [_classBtn setImage:[UIImage imageNamed:@"public_arrow_right"] forState:UIControlStateNormal];
        _classBtn.titleLabel.font = kFont(11);
        [_classBtn addTarget:self action:@selector(classBtnClick) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_classBtn];
        [_classBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(WScale(-15));
            make.centerY.mas_equalTo(self.titleLabel);
            make.width.mas_equalTo(WScale(150));
        }];
        [_classBtn layoutButtonWithEdgeInsetsStyle:MKButtonEdgeInsetsStyleRight imageTitleSpace:WScale(3)];
    }
    return _classBtn;
}


-(UIView *)moneyView
{
    if (!_moneyView) {
        _moneyView = [[UIView alloc] init];
        _moneyView.backgroundColor = UIColorFromRGB(0xF8F8F8);
        _moneyView.layer.cornerRadius = WScale(8);
        _moneyView.clipsToBounds = YES;
        [self addSubview:_moneyView];
        [_moneyView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(self);
            make.left.mas_equalTo(WScale(15));
            make.top.mas_equalTo(self.shopImg.mas_bottom).mas_equalTo(WScale(15));
            make.height.mas_equalTo(WScale(75));
        }];
        
        UILabel *moneyTipLabel = [UILabel labelWithText:@"账户余额" font:kFont(11) textColor:UIColorFromRGB(0x666666) backGroundColor:ClearColor superView:_moneyView];
        [moneyTipLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(WScale(15));
            make.top.mas_equalTo(WScale(14));
        }];
        
        UILabel *moneyTipLabel2 = [UILabel labelWithText:@"每月9号可提现上个月收益" font:kFont(10) textColor:UIColorFromRGB(0x999999) backGroundColor:ClearColor superView:_moneyView];
        [moneyTipLabel2 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(moneyTipLabel.mas_right).mas_equalTo(WScale(10));
            make.centerY.mas_equalTo(moneyTipLabel);
        }];
    }
    return _moneyView;
}

-(UILabel *)moneyLabel
{
    if (!_moneyLabel) {
        _moneyLabel = [UILabel labelWithText:@"¥99.00" font:[UIFont boldSystemFontOfSize:WScale(14)] textColor:UIColorFromRGB(0x333333) backGroundColor:ClearColor superView:self.moneyView];
        [_moneyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(WScale(15));
            make.bottom.mas_equalTo(WScale(-20));
        }];
        
        _arrowImg = [[UIImageView alloc] init];
        _arrowImg.image = [UIImage imageNamed:@"public_arrow_right2"];
        [self.moneyView addSubview:_arrowImg];
        [_arrowImg mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(_moneyLabel.mas_right).mas_equalTo(WScale(8));
            make.centerY.mas_equalTo(_moneyLabel);
        }];
    }
    return _moneyLabel;
}

-(UIButton *)cashBtn
{
    if (!_cashBtn) {
        _cashBtn = [UIButton buttonWithImage:@"my_cash" target:self action:@selector(cashBtnClick) showView:self.moneyView];
        [_cashBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(-WScale(15));
            make.centerY.mas_equalTo(self.moneyView);
        }];
    }
    return _cashBtn;
}

-(UILabel *)phoneTipLabel
{
    if (!_phoneTipLabel) {
        _phoneTipLabel = [UILabel labelWithText:@"全国客服电话：" font:kFont(13) textColor:UIColorFromRGB(0x333333) backGroundColor:ClearColor superView:self];
        [_phoneTipLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(WScale(15));
            make.bottom.mas_equalTo(WScale(-15));
        }];
    }
    return _phoneTipLabel;
}

-(UIButton *)phoneBtn
{
    if (!_phoneBtn) {
        _phoneBtn = [UIButton buttonWithTitle:@" 4990-900-9000" font:kFont(13) normalColor:ThemeColor selectedColor:ThemeColor buttonTag:0 backGroundColor:ClearColor target:self action:@selector(phoneBtnClick) showView:self];
        [_phoneBtn setImage:[UIImage imageNamed:@"my_phone"] forState:UIControlStateNormal];
        [_phoneBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(-WScale(15));
            make.centerY.mas_equalTo(self.phoneTipLabel);
        }];
    }
    return _phoneBtn;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end


#pragma mark ****************** 各个分类
@implementation SHMyClassTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
-(void)setDict:(NSDictionary *)dict
{
    [self titleLabel];
    [self arrowImg];
}

-(UILabel *)titleLabel
{
    if (!_titleLabel) {
        _titleLabel = [UILabel labelWithText:@"" font:kFont(15) textColor:UIColorFromRGB(0x333333) backGroundColor:ClearColor superView:self];
        [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(WScale(15));
            make.centerY.mas_equalTo(self);
        }];
    }
    return _titleLabel;
}


-(UIImageView *)arrowImg
{
    if (!_arrowImg) {
        _arrowImg = [[UIImageView alloc] init];
        _arrowImg.image = [UIImage imageNamed:@"public_arrow_right"];
        [self addSubview:_arrowImg];
        [_arrowImg mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(WScale(-15));
            make.centerY.mas_equalTo(self);
        }];
    }
    return _arrowImg;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end



#pragma mark ****************** 是否接受平台自动匹配接单
@implementation SHMyIfGetDanCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
-(void)setDict:(NSDictionary *)dict
{
    [self titleLabel];
    [self tipLabel];
    [self switchBtn];
}

-(void)onClickSwitch:(UISwitch *)switchBtn
{
    
}

-(UILabel *)titleLabel
{
    if (!_titleLabel) {
        _titleLabel = [UILabel labelWithText:@"是否接受平台自动匹配接单" font:kFont(15) textColor:UIColorFromRGB(0x333333) backGroundColor:ClearColor superView:self];
        [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(WScale(15));
            make.top.mas_equalTo(WScale(12));
        }];
    }
    return _titleLabel;
}

-(UILabel *)tipLabel
{
    if (!_tipLabel) {
        _tipLabel = [UILabel labelWithText:@"系统匹配后，要5分钟内投单，不然会失之交臂哦" font:kFont(11) textColor:UIColorFromRGB(0x999999) backGroundColor:ClearColor superView:self];
        [_tipLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(WScale(15));
            make.bottom.mas_equalTo(WScale(-12));
        }];
    }
    return _tipLabel;
}

-(UISwitch *)switchBtn
{
    if (!_switchBtn) {
        _switchBtn = [[UISwitch alloc] init];
        [_switchBtn addTarget:self action:@selector(onClickSwitch:) forControlEvents:UIControlEventValueChanged];
        _switchBtn.onTintColor = ThemeColor;
        _switchBtn.translatesAutoresizingMaskIntoConstraints = NO;
        [self addSubview:_switchBtn];
        [_switchBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(self);
            make.right.mas_equalTo(WScale(-15));
        }];
    }
    return _switchBtn;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
