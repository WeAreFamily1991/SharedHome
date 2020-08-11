//
//  SHFeePopView.m
//  SharedHome
//
//  Created by 解辉 on 2020/8/4.
//  Copyright © 2020 NaDao. All rights reserved.
//

#import "SHFeePopView.h"

@interface SHFeePopView()<UIGestureRecognizerDelegate>

@property(nonatomic,strong) UIView *popView;
@property(nonatomic,strong) UILabel *titleLabel;
@end

@implementation SHFeePopView

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
           // make.height.mas_equalTo(WScale(170));
        }];
    
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapClick)];
        tap.delegate = self;
        [self addGestureRecognizer:tap];
        
        [self setUI];
    }
    return self;
}
-(void)setContent:(NSString *)content
{
    self.titleLabel.text = self.title;
    self.contentLabel.text = content;
}

-(void)setUI
{
    UILabel *titleLabel = [UILabel labelWithText:@"收费标准" font:[UIFont boldSystemFontOfSize:WScale(14)] textColor:UIColorFromRGB(0x333333) backGroundColor:ClearColor superView:self.popView];
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.popView);
        make.top.mas_equalTo(WScale(20));
    }];
    self.titleLabel = titleLabel;
    
    NSString *content = @"按选择的区域数量*区域单价（每个区 域的单价都一样），区域单位为每个10 元 \n\n 免费视频只可以在资源才可以看到，付费视频直接推荐至首页，增大曝光量哦";
    UILabel *contentLabel = [UILabel labelWithText:content font:kFont(14) textColor:UIColorFromRGB(0x333333) backGroundColor:ClearColor superView:self.popView];
    contentLabel.textAlignment = NSTextAlignmentLeft;
    [contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.popView);
        make.left.mas_equalTo(WScale(16));
        make.top.mas_equalTo(titleLabel.mas_bottom).mas_equalTo(WScale(12));
        make.bottom.mas_equalTo(WScale(-40));
    }];
    self.contentLabel = contentLabel;
    
    BigClickBT *closeBtn = [[BigClickBT alloc] init];
    [closeBtn setImage:[UIImage imageNamed:@"area_close"] forState:UIControlStateNormal];
    [closeBtn addTarget:self action:@selector(closeClick) forControlEvents:UIControlEventTouchUpInside];
    [self.popView addSubview:closeBtn];
    [closeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(WScale(20));
        make.right.mas_equalTo(WScale(-20));
        make.width.height.mas_equalTo(WScale(15));
    }];
}

-(void)tapClick
{
    [self dismiss];
}
-(void)closeClick
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
