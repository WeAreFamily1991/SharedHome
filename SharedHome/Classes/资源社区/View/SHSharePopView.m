//
//  SHSharePopView.m
//  SharedHome
//
//  Created by 解辉 on 2020/8/3.
//  Copyright © 2020 NaDao. All rights reserved.
//

#import "SHSharePopView.h"


@implementation SHSharePopView

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.backgroundColor = [UIColor colorWithWhite:0 alpha:0.3];
        
        ///分享按钮
        _shareView = [[UIView alloc] initWithFrame:CGRectMake(0, kWindowH, kWindowW, 0)];
        _shareView.backgroundColor = WhiteColor;
        _shareView.clipsToBounds = YES;
        [self addSubview:_shareView];
        
        UILabel *tipLabel = [UILabel labelWithText:@"分享至" font:kFont(14) textColor:UIColorFromRGB(0x333333) backGroundColor:ClearColor superView:_shareView];
        [tipLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(self);
            make.top.mas_equalTo(WScale(15));
        }];
        
        NSArray *imgArray = @[@"share_wechat",@"share_quan"];
        NSArray *array = @[@"微信好友",@"朋友圈"];

        float width = kWindowW/imgArray.count;
        float height = WScale(100);
        
        for (int i = 0; i<imgArray.count; i++) {
            float x = i %imgArray.count;
            float y = i /imgArray.count;
            
            UIButton *shareBtn = [UIButton buttonWithImage:imgArray[i] target:self action:@selector(shareClick:) showView:_shareView];
            [shareBtn setTitle:array[i] forState:UIControlStateNormal];
            [shareBtn setTitleColor:UIColorFromRGB(0x666666) forState:UIControlStateNormal];
            shareBtn.titleLabel.font = kFont(12);
            shareBtn.frame = CGRectMake(width*x,height*y+WScale(40), width, height);
            shareBtn.tag = i;
            [_shareView addSubview:shareBtn];
            [shareBtn layoutButtonWithEdgeInsetsStyle:MKButtonEdgeInsetsStyleTop imageTitleSpace:WScale(10)];
        }
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapClick)];
        [self addGestureRecognizer:tap];
        
        
        
        //分享内容
        _popView = [[UIView alloc] init];
        _popView.backgroundColor = WhiteColor;
        _popView.clipsToBounds = YES;
        _popView.layer.cornerRadius = WScale(10);
        [self addSubview:_popView];
        [_popView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(self);
            make.top.mas_equalTo(WScale(19));
            make.width.mas_equalTo(WScale(270));
            make.height.mas_equalTo(WScale(480));
        }];
        
        //分享信息
        _shareIcon = [[UIImageView alloc] init];
        _shareIcon.layer.cornerRadius = WScale(17);
        _shareIcon.clipsToBounds = YES;
        _shareIcon.image = [UIImage imageNamed:@"share_icon"];
        [self.popView addSubview:_shareIcon];
        [_shareIcon mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(WScale(15));
            make.top.mas_equalTo(WScale(18));
            make.width.height.mas_equalTo(WScale(34));
        }];
        
        _sharedTitle = [UILabel labelWithText:@"来吧，展示！同城网红商家/达人争选" font:[UIFont boldSystemFontOfSize:WScale(11)] textColor:UIColorFromRGB(0x333333) backGroundColor:ClearColor superView:self.popView];
        [_sharedTitle mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.shareIcon.mas_right).mas_equalTo(WScale(5));
            make.top.mas_equalTo(self.shareIcon.mas_top).mas_equalTo(WScale(5));
        }];
        
        _shareName = [UILabel labelWithText:@"点滴生活，尽在找找" font:kFont(9) textColor:UIColorFromRGB(0x999999) backGroundColor:ClearColor superView:self.popView];
        [_shareName mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(_sharedTitle.mas_left);
            make.bottom.mas_equalTo(self.shareIcon.mas_bottom);
        }];
        
        self.screenImgView = [[UIImageView alloc] init];
        self.screenImgView.backgroundColor = [UIColor yellowColor];
        [_popView addSubview:self.screenImgView];
        [self.screenImgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(self.popView);
            make.top.mas_equalTo(WScale(88));
            make.height.mas_equalTo(WScale(266));
            make.width.mas_equalTo(WScale(177));
        }];
        
        UIImageView *playImg = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"play_icon"]];
        [self.screenImgView addSubview:playImg];
        [playImg mas_makeConstraints:^(MASConstraintMaker *make) {
            make.center.mas_equalTo(self.screenImgView);
        }];
        
        //店铺信息
        _shopImg = [[UIImageView alloc] init];
        _shopImg.layer.cornerRadius = WScale(12);
        _shopImg.clipsToBounds = YES;
        _shopImg.image = [UIImage imageNamed:@"public_bg"];
        [self.popView addSubview:_shopImg];
        [_shopImg mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(WScale(15));
            make.top.mas_equalTo(self.screenImgView.mas_bottom).mas_equalTo(WScale(40));
            make.width.height.mas_equalTo(WScale(24));
        }];
        
        _shopName = [UILabel labelWithText:@"西庄裁缝" font:[UIFont boldSystemFontOfSize:WScale(10)] textColor:UIColorFromRGB(0x333333) backGroundColor:ClearColor superView:self.popView];
        [_shopName mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.shopImg.mas_right).mas_equalTo(WScale(7));
            make.centerY.mas_equalTo(self.shopImg);
        }];
        
        _shopTitle = [UILabel labelWithText:@"裁衣改衣,提供上门取衣服务" font:[UIFont boldSystemFontOfSize:WScale(10)] textColor:UIColorFromRGB(0x666666) backGroundColor:ClearColor superView:self.popView];
        [_shopTitle mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(WScale(15));
            make.top.mas_equalTo(self.shopImg.mas_bottom).mas_equalTo(WScale(10));
        }];
        
        ///二维码
        _erIcon = [[UIImageView alloc] init];
        _erIcon.image = [UIImage imageNamed:@"public_bg"];
        [self.popView addSubview:_erIcon];
        [_erIcon mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(WScale(-15));
            make.bottom.mas_equalTo(WScale(-35));
            make.width.height.mas_equalTo(WScale(65));
        }];
        _erTitle = [UILabel labelWithText:@"APP下载二维码" font:kFont(8) textColor:UIColorFromRGB(0x333333) backGroundColor:ClearColor superView:self.popView];
        [_erTitle mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(self.erIcon);
            make.top.mas_equalTo(self.erIcon.mas_bottom).mas_equalTo(WScale(6));
        }];

        
    }
    return self;
}
-(void)setScreenImg:(UIImage *)screenImg
{
    self.screenImgView.image = screenImg;
}
#pragma mark 分享按钮的点击事件
-(void)shareClick:(UIButton *)button
{
    UIImage *image = [self captureImageFromView:self.popView];
    UIImageWriteToSavedPhotosAlbum(image, self, @selector(image:didFinishSavingWithError:contextInfo:), (__bridge void *)self);
    [self close];
}
- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo
{
    if (error == nil) {
        //[[YZMBPManager sharedMBPManager] showHUDWithText:@"保存相册成功"];
        [self.tipView show];
    }
}

-(void)tapClick
{
    [self close];
}
-(void)cancelClick
{
    [self close];
}
#pragma mark *******************  show
-(void)show
{
    [[UIApplication sharedApplication].keyWindow.rootViewController.view addSubview:self];
    [UIView animateWithDuration:0.3f animations:^{
        
        self.shareView.frame = CGRectMake(0,kWindowH-WScale(150)-SafeAreaBottomHeight,kWindowW,WScale(150)+SafeAreaBottomHeight);
        
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

-(SHShareTipView *)tipView
{
    if (!_tipView) {
        _tipView = [[SHShareTipView alloc] init];
    }
    return _tipView;
}
#pragma mark  截图功能
-(UIImage *)captureImageFromView:(UIView *)view
{
    CGRect rect = view.bounds;
    UIGraphicsBeginImageContextWithOptions(rect.size,YES, 0.0);
    [view.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *snapshotImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return snapshotImage;
}

- (UIImage *)compressImageSize:(UIImage *)image toByte:(NSUInteger)maxLength {
    
    UIImage *resultImage = image;
    NSData *data = UIImageJPEGRepresentation(resultImage, 1);
    NSUInteger lastDataLength = 0;
    while (data.length > maxLength && data.length != lastDataLength) {
        lastDataLength = data.length;
        CGFloat ratio = (CGFloat)maxLength / data.length;
        CGSize size = CGSizeMake((NSUInteger)(resultImage.size.width * sqrtf(ratio)),
                                 (NSUInteger)(resultImage.size.height * sqrtf(ratio))); // Use NSUInteger to prevent white blank
        UIGraphicsBeginImageContext(size);
        // Use image to draw (drawInRect:), image is larger but more compression time
        // Use result image to draw, image is smaller but less compression time
        [resultImage drawInRect:CGRectMake(0, 0, size.width, size.height)];
        resultImage = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        data = UIImageJPEGRepresentation(resultImage, 1);
    }
    return resultImage;
}

@end
