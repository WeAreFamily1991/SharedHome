//
//  SHShareTipView.m
//  SharedHome
//
//  Created by 解辉 on 2020/8/3.
//  Copyright © 2020 NaDao. All rights reserved.
//

#import "SHShareTipView.h"

@interface SHShareTipView()<UIGestureRecognizerDelegate>

@property(nonatomic,strong) UIView *popView;
@property(nonatomic,strong) UILabel *contentLabel;

@end

@implementation SHShareTipView

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
            make.width.mas_equalTo(WScale(290));
            make.height.mas_equalTo(WScale(147));
        }];
    
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapClick)];
        tap.delegate = self;
        [self addGestureRecognizer:tap];
        
        [self setUI];
    }
    return self;
}

///分享给微信好友
-(void)shareBtnClick
{
    [self dismiss];
}

-(void)setUI
{
    UILabel *titleLabel = [UILabel labelWithText:@"已保存到相册" font:[UIFont boldSystemFontOfSize:WScale(14)] textColor:UIColorFromRGB(0x333333) backGroundColor:ClearColor superView:self.popView];
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.popView);
        make.top.mas_equalTo(WScale(20));
    }];
    
    UILabel *contentLabel = [UILabel labelWithText:@"由于朋友圈限制，需手动发送至朋友圈" font:kFont(14) textColor:UIColorFromRGB(0x333333) backGroundColor:ClearColor superView:self.popView];
    contentLabel.textAlignment = NSTextAlignmentCenter;
    [contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.popView);
        make.top.mas_equalTo(titleLabel.mas_bottom).mas_equalTo(WScale(10));
    }];
    self.contentLabel = contentLabel;
    
    UIButton *shareBtn = [UIButton buttonWithTitle:@"分享给微信好友" font:kFont(14) titleColor:WhiteColor backGroundColor:ThemeColor buttonTag:1 target:self action:@selector(shareBtnClick) showView:self.popView];
    shareBtn.layer.cornerRadius = WScale(4);
    shareBtn.clipsToBounds = YES;
    [shareBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.popView);
        make.bottom.mas_equalTo(-WScale(20));
        make.width.mas_equalTo(WScale(250));
        make.height.mas_equalTo(WScale(36));
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
