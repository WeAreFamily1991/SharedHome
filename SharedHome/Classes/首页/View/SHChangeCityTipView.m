//
//  SHChangeCityTipView.m
//  SharedHome
//
//  Created by 解辉 on 2020/7/29.
//  Copyright © 2020 NaDao. All rights reserved.
//

#import "SHChangeCityTipView.h"

@interface SHChangeCityTipView()<UIGestureRecognizerDelegate>

@property(nonatomic,strong) UIView *popView;
@property(nonatomic,strong) UILabel *contentLabel;

@end

@implementation SHChangeCityTipView

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        self.frame = CGRectMake(0,0, kWindowW, kWindowH);
        self.backgroundColor = [UIColor colorWithWhite:0 alpha:0.3];
        self.clipsToBounds = YES;
        self.tag = 100;
        
        self.popView = [[UIView alloc] init];
        self.popView.userInteractionEnabled = YES;
        self.popView.backgroundColor = WhiteColor;
        self.popView.layer.cornerRadius = WScale(5);
        self.popView.clipsToBounds = YES;
        [self addSubview:self.popView];
        [self.popView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.center.mas_equalTo(self);
            make.width.mas_equalTo(WScale(255));
            make.height.mas_equalTo(WScale(133));
        }];
    
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapClick)];
        tap.delegate = self;
        [self addGestureRecognizer:tap];
        
        [self setUI];
    }
    return self;
}
-(void)setChangeCity:(NSString *)changeCity
{
    self.contentLabel.attributedText = [NSString attributedStringWithColorTitle:changeCity normalTitle:@"吗" frontTitle:@"您当前城市在苏州，需要切换为" diffentColor:ThemeColor];
}

-(void)changeBtnClick:(UIButton *)button
{
    [self dismiss];
}

-(void)setUI
{
    UILabel *titleLabel = [UILabel labelWithText:@"切换城市" font:[UIFont boldSystemFontOfSize:WScale(14)] textColor:UIColorFromRGB(0x333333) backGroundColor:ClearColor superView:self.popView];
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.popView);
        make.top.mas_equalTo(WScale(15));
    }];
    
    UILabel *contentLabel = [UILabel labelWithText:@"您当前城市在苏州，需要切换为苏州市 姑苏区吗" font:kFont(14) textColor:UIColorFromRGB(0x333333) backGroundColor:ClearColor superView:self.popView];
    contentLabel.textAlignment = NSTextAlignmentCenter;
    contentLabel.numberOfLines = 2;
    [contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.popView);
        make.left.mas_equalTo(WScale(20));
        make.top.mas_equalTo(titleLabel.mas_bottom).mas_equalTo(WScale(10));
    }];
    self.contentLabel = contentLabel;
    
    UILabel *lineLabel = [[UILabel alloc] init];
    lineLabel.backgroundColor = UIColorFromRGB(0xEBEBEB);
    [self.popView addSubview:lineLabel];
    [lineLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.popView);
        make.left.mas_equalTo(0);
        make.bottom.mas_equalTo(-WScale(40));
        make.height.mas_equalTo(1);
    }];
    
    UILabel *lineLabel2 = [[UILabel alloc] init];
    lineLabel2.backgroundColor = UIColorFromRGB(0xEBEBEB);
    [self.popView addSubview:lineLabel2];
    [lineLabel2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.popView);
        make.height.mas_equalTo(WScale(40));
        make.bottom.mas_equalTo(0);
        make.width.mas_equalTo(1);
    }];
    
    UIButton *unChangeBtn = [UIButton buttonWithTitle:@"不切换" font:kFont(15) titleColor:UIColorFromRGB(0x333333) backGroundColor:ClearColor buttonTag:0 target:self action:@selector(changeBtnClick:) showView:self.popView];
    [unChangeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.mas_equalTo(0);
        make.top.mas_equalTo(lineLabel.mas_bottom);
        make.right.mas_equalTo(lineLabel2.mas_left);
    }];
    
    UIButton *ChangeBtn = [UIButton buttonWithTitle:@"切换" font:kFont(15) titleColor:ThemeColor backGroundColor:ClearColor buttonTag:1 target:self action:@selector(changeBtnClick:) showView:self.popView];
    [ChangeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.bottom.mas_equalTo(0);
        make.top.mas_equalTo(lineLabel.mas_bottom);
        make.left.mas_equalTo(lineLabel2.mas_right);
    }];
}

-(void)tapClick
{
    [self dismiss];
}
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch {
    if (touch.view.tag == 100) {
        return YES;
    }
    else
    {
        return NO;
    }
}

- (void)show {
    UIWindow *window = [[[UIApplication sharedApplication] delegate] window];
    [window addSubview:self];
}

- (void)dismiss {
    
     [self removeFromSuperview];
}


@end
