//
//  SHShopInfoCell.m
//  SharedHome
//
//  Created by 解辉 on 2020/8/7.
//  Copyright © 2020 NaDao. All rights reserved.
//

#import "SHShopInfoCell.h"

@implementation SHShopInfoCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
-(void)setDict:(NSDictionary *)dict
{
    [self titleLabel];
    [self infoTF];
}

-(UILabel *)titleLabel
{
    if (!_titleLabel) {
        _titleLabel = [UILabel labelWithText:@"" font:kFont(14) textColor:UIColorFromRGB(0x333333) backGroundColor:ClearColor superView:self];
        [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(WScale(20));
            make.centerY.mas_equalTo(self);
        }];
    }
    return _titleLabel;
}

-(UITextField *)infoTF
{
    if (!_infoTF) {
        _infoTF = [[UITextField alloc] initWithPlaceholder:@"" showView:self delegate:self showFont:kFont(14) showColor:UIColorFromRGB(0x666666) placeholderColor:UIColorFromRGB(0xB4B4B4)];
        _infoTF.textAlignment = NSTextAlignmentRight;
        _infoTF.clearButtonMode = UITextFieldViewModeNever;
        [_infoTF mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(WScale(-20));
            make.centerY.mas_equalTo(self);
        }];
        
        _arrowImg = [[UIImageView alloc] init];
        _arrowImg.image = [UIImage imageNamed:@"public_arrow_right"];
        [self addSubview:_arrowImg];
        [_arrowImg mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(WScale(-5));
            make.centerY.mas_equalTo(self);
        }];
    }
    return _infoTF;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end


#pragma mark 营业执照
@implementation SHShopInfoPhotoCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
-(void)setDict:(NSDictionary *)dict
{
    [self titleLabel];
    [self photoBtn];
}

///从相册中选择照片
-(void)photoBtnClick
{
    if (self.SelectPhotoBlock) {
        self.SelectPhotoBlock(self.selectType, self.section);
    }
}

-(UILabel *)titleLabel
{
    if (!_titleLabel) {
        _titleLabel = [UILabel labelWithText:@"营业执照" font:kFont(14) textColor:UIColorFromRGB(0x333333) backGroundColor:ClearColor superView:self];
        [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(WScale(20));
            make.top.mas_equalTo(WScale(15));
        }];
    }
    return _titleLabel;
}

-(UIButton *)photoBtn
{
    if (!_photoBtn) {
        _photoBtn = [UIButton buttonWithImage:@"addpic" target:self action:@selector(photoBtnClick) showView:self];
        [_photoBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(WScale(20));
            make.top.mas_equalTo(self.titleLabel.mas_bottom).mas_equalTo(WScale(15));
            make.width.height.mas_equalTo(107);
        }];
    }
    return _photoBtn;;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end


#pragma mark 门头照片
@implementation SHShopDoorPhotoCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
///门头照片
-(void)setDict:(NSDictionary *)dict
{
    self.clipsToBounds = YES;
    [self titleLabel];
    [self photoView];
    [self photoBtn];
}

///身份证照片
-(void)setDict2:(NSDictionary *)dict2
{
    self.clipsToBounds = YES;
    [self titleLabel];
    [self photoView];
    [self IDZhengBtn];
    [self IDFanBtn];
}

///点击添加身份证照片
-(void)IDBtnClick:(UIButton *)button
{
    if (self.AddIDPhotoBlock) {
        self.AddIDPhotoBlock(button.tag);
    }
}

///点击删除门头照片
-(void)closeBtnClick:(UIButton *)button
{
    if (self.DeleteDoorPhotoBlock) {
        self.DeleteDoorPhotoBlock(button.tag);
    }
}

///点击添加门头照片
-(void)photoBtnClick
{
    if (self.SelectDoorPhotoBlock) {
        self.SelectDoorPhotoBlock(YES);
    }
}

-(void)setPhotoArray:(NSMutableArray *)photoArray
{
    _photoArray = photoArray;
    [self setPhotoWithArray:photoArray];
}

-(void)setPhotoWithArray:(NSArray *)photoArray
{
    [self.photoView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    
    float space = (kWindowW-WScale(40)-WScale(107)*3)/2;
    for (int i = 0; i<photoArray.count; i++)
    {
        NSInteger x = i%3;
        NSInteger y = i/3;
        
        UIButton *button = [UIButton buttonWithImage:@"" target:self action:nil showView:self.photoView];
        [button setImage:photoArray[i] forState:UIControlStateNormal];
        [button mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(WScale(20)+(WScale(107)+space)*x);
            make.top.mas_equalTo((WScale(107)+space)*y);
            make.width.height.mas_equalTo(WScale(107));
        }];
        
        BigClickBT *closeBtn = [[BigClickBT alloc] init];
        closeBtn.tag = i;
        [closeBtn setImage:[UIImage imageNamed:@"post_close"] forState:UIControlStateNormal];
        [closeBtn addTarget:self action:@selector(closeBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [button addSubview:closeBtn];
        [closeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(5);
            make.right.mas_equalTo(WScale(-5));
            make.width.height.mas_equalTo(WScale(20));
        }];
    }
    
    float height = photoArray.count >=3?(WScale(230)):(WScale(120));
    [self.photoView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(height);
    }];
    
    self.photoBtn.hidden = photoArray.count == 6?(YES):(NO);
    
    NSInteger x2 = photoArray.count%3;
    NSInteger y2 = photoArray.count/3;
    [self.photoBtn mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(WScale(20)+(WScale(107)+space)*x2);
        make.top.mas_equalTo(self.photoView.mas_top).mas_equalTo((WScale(107)+space)*y2);
        make.width.height.mas_equalTo(WScale(107));
    }];
}

-(UILabel *)titleLabel
{
    if (!_titleLabel) {
        _titleLabel = [UILabel labelWithText:@"门头照片" font:kFont(14) textColor:UIColorFromRGB(0x333333) backGroundColor:ClearColor superView:self];
        [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(WScale(20));
            make.top.mas_equalTo(WScale(25));
            make.height.mas_equalTo(WScale(20));
        }];
    }
    return _titleLabel;
}

-(UIView *)photoView
{
    if (!_photoView) {
        _photoView = [[UIView alloc] init];
        [self addSubview:_photoView];
        [_photoView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(self);
            make.top.mas_equalTo(self.titleLabel.mas_bottom).mas_equalTo(WScale(15));
            make.left.mas_equalTo(0);
            make.height.mas_equalTo(WScale(120));
            make.bottom.mas_equalTo(-5);
        }];
    }
    return _photoView;;
}

-(UIButton *)photoBtn
{
    if (!_photoBtn) {
        _photoBtn = [UIButton buttonWithImage:@"addpic" target:self action:@selector(photoBtnClick) showView:self];
        [_photoBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(WScale(20));
            make.top.mas_equalTo(self.photoView.mas_top);
            make.width.height.mas_equalTo(107);
        }];
    }
    return _photoBtn;;
}

-(UIButton *)IDZhengBtn
{
    if (!_IDZhengBtn) {
        _IDZhengBtn = [UIButton buttonWithImage:@"id_zheng" target:self action:@selector(IDBtnClick:) showView:self];
        _IDZhengBtn.tag = 0;
        [_IDZhengBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(WScale(20));
            make.top.mas_equalTo(self.photoView);
            make.width.mas_equalTo(WScale(165));
            make.height.mas_equalTo(107);
        }];
    }
    return _IDZhengBtn;
}

-(UIButton *)IDFanBtn
{
    if (!_IDFanBtn) {
        _IDFanBtn = [UIButton buttonWithImage:@"id_fan" target:self action:@selector(IDBtnClick:) showView:self];
        _IDFanBtn.tag = 1;
        [_IDFanBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(WScale(-20));
            make.top.mas_equalTo(self.photoView);
            make.width.mas_equalTo(WScale(165));
            make.height.mas_equalTo(107);
        }];
    }
    return _IDFanBtn;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end


#pragma mark 有提供24小时服务的能力
@implementation SHShop24HourCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
-(void)setDict:(NSDictionary *)dict
{
    [self SelectBtn];
}

-(void)selectBtnClick:(UIButton *)button
{
    button.selected = !button.selected;
    if (self.SelectBlock) {
        self.SelectBlock(button.selected);
    }
}

-(UIButton *)SelectBtn
{
    if (!_SelectBtn) {
        _SelectBtn = [UIButton buttonWithTitle:@"  有提供24小时服务的能力" font:kFont(14) titleColor:UIColorFromRGB(0x333333) backGroundColor:ClearColor buttonTag:0 target:self action:@selector(selectBtnClick:) showView:self];
        [_SelectBtn setImage:[UIImage imageNamed:@"pay_quan_normal"] forState:UIControlStateNormal];
        [_SelectBtn setImage:[UIImage imageNamed:@"pay_quan_select"] forState:UIControlStateSelected];
        [_SelectBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(WScale(20));
            make.centerY.mas_equalTo(self);
        }];
    }
    return _SelectBtn;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
