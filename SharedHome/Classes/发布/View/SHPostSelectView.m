//
//  SHPostSelectView.m
//  SharedHome
//
//  Created by 解辉 on 2020/8/4.
//  Copyright © 2020 NaDao. All rights reserved.
//

#import "SHPostSelectView.h"

@implementation SHPostSelectView

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.frame = CGRectMake(0, 0, kWindowW, kWindowH);
        self.backgroundColor = [UIColor colorWithWhite:0 alpha:0.5];
        
        ///分享按钮
        _shareView = [[UIView alloc] initWithFrame:CGRectMake(0, kWindowH, kWindowW, 0)];
        _shareView.backgroundColor = WhiteColor;
        _shareView.clipsToBounds = YES;
        [self addSubview:_shareView];
        
        NSArray *imgArray = @[@"post_need",@"post_video"];
        NSArray *array = @[@"发布需求",@"发布短视频"];
        NSArray *array2 = @[@"精准 及时 被服务",@"资源全民共享"];

        float width = kWindowW/imgArray.count;
        float height = WScale(100);
        
        for (int i = 0; i<imgArray.count; i++) {
            float x = i %imgArray.count;
            
            UIButton *shareBtn = [UIButton buttonWithImage:imgArray[i] target:self action:@selector(shareClick:) showView:_shareView];
            [shareBtn setTitle:array[i] forState:UIControlStateNormal];
            [shareBtn setTitleColor:UIColorFromRGB(0x333333) forState:UIControlStateNormal];
            shareBtn.titleLabel.font = kFont(14);
            shareBtn.frame = CGRectMake(width*x,WScale(30), width, height);
            shareBtn.tag = i;
            [_shareView addSubview:shareBtn];
            [shareBtn layoutButtonWithEdgeInsetsStyle:MKButtonEdgeInsetsStyleTop imageTitleSpace:WScale(10)];
            
            UILabel *tipLabel = [UILabel labelWithText:array2[i] font:kFont(11) textColor:ThemeColor backGroundColor:ClearColor superView:_shareView];
            [tipLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                make.centerX.mas_equalTo(shareBtn);
                make.top.mas_equalTo(shareBtn.mas_bottom);
            }];
        }
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapClick)];
        [self addGestureRecognizer:tap];
        
        BigClickBT *cancelBtn = [[BigClickBT alloc] init];
        [cancelBtn setImage:[UIImage imageNamed:@"post_close"] forState:UIControlStateNormal];
        [cancelBtn addTarget:self action:@selector(cancelBtnClick) forControlEvents:UIControlEventTouchUpInside];
        [_shareView addSubview:cancelBtn];
        [cancelBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(self.shareView);
            make.bottom.mas_equalTo(-SafeAreaBottomHeight-WScale(20));
        }];
    }
    return self;
}

#pragma mark 发布按钮的点击事件
-(void)shareClick:(UIButton *)button
{
    if (self.block) {
        self.block(button.tag);
    }
    [self close];
}

-(void)tapClick
{
    [self close];
}
-(void)cancelBtnClick
{
    [self close];
}
#pragma mark *******************  show
-(void)show
{
    [[UIApplication sharedApplication].keyWindow.rootViewController.view addSubview:self];
    [UIView animateWithDuration:0.3f animations:^{
        
        self.shareView.frame = CGRectMake(0,kWindowH-WScale(200)-SafeAreaBottomHeight,kWindowW,WScale(200)+SafeAreaBottomHeight);
        
    } completion:^(BOOL finished)
     {
         
     }];
}
#pragma mark *******************  close
-(void)close
{
    [UIView animateWithDuration:0.3f animations:^{
        
        self.shareView.frame = CGRectMake(0,kWindowH,kWindowW,0);
        
    } completion:^(BOOL finished)
     {
         [self removeFromSuperview];
     }];
}
@end
