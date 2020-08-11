//
//  SHVideoDetailVC.m
//  SharedHome
//
//  Created by 解辉 on 2020/8/1.
//  Copyright © 2020 NaDao. All rights reserved.
//

#import "SHVideoDetailVC.h"
#import "SHChatViewController.h"
#import "SHSharePopView.h"

@interface SHVideoDetailVC ()<AVAudioPlayerDelegate>
{
    UIImageView *_playImg;
    NSString *videoUrl;
}
@property(nonatomic,strong)AVPlayer *player;
@property(nonatomic,strong)AVAudioPlayer *player2;
@property(nonatomic,assign)BOOL isPlay;
@property(nonatomic,strong) UIImageView *topImg;
@property(nonatomic,strong) UIImageView *bottomImg;

@property(nonatomic,strong) UIImageView *shopImg;
@property(nonatomic,strong) UILabel *shopName;
@property(nonatomic,strong) UILabel *shopTitle;
@property(nonatomic,strong) SHSharePopView *shareView;
@end

@implementation SHVideoDetailVC

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = WhiteColor;
    
    videoUrl = @"https://xy2.v.netease.com/r/video/20190814/7db8102c-1b18-4a59-ac70-ec03137f1c2e.mp4";
    [self setAVPlayer];
    [self topImg];
    [self bottomImg];
    [self setNavView];
    [self setShopInfoView];
}

#pragma mark *****************  按钮的点击事件
#pragma mark 返回
-(void)backBtnClick
{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark 分享
-(void)shareBtnClick
{
//    self.shareView.shareUrl = urlStr;
//    self.shareView.shareTitle = self.adaptionModel.title;
//    self.shareView.shareDescription = @"智能练习";
    [self.shareView show];
    self.shareView.screenImg = [self getVideoPreViewImage:[NSURL URLWithString:videoUrl]];
}

// 获取视频第一帧
- (UIImage*)getVideoPreViewImage:(NSURL *)path
{
    AVURLAsset *asset = [[AVURLAsset alloc] initWithURL:path options:nil];
    AVAssetImageGenerator *assetGen = [[AVAssetImageGenerator alloc] initWithAsset:asset];
    
    assetGen.appliesPreferredTrackTransform = YES;
    CMTime time = CMTimeMakeWithSeconds(0.0, 600);
    NSError *error = nil;
    CMTime actualTime;
    CGImageRef image = [assetGen copyCGImageAtTime:time actualTime:&actualTime error:&error];
    UIImage *videoImage = [[UIImage alloc] initWithCGImage:image];
    CGImageRelease(image);
    return videoImage;
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

#pragma mark 发私信
-(void)chatClick
{
    SHChatViewController *chatVC = [[SHChatViewController alloc] init];
    [self.navigationController pushViewController:chatVC animated:YES];
}

-(void)tapClick
{
    if (self.isPlay) {
        [self.player pause];
    }
    else
    {
        [self.player play];
    }
    self.isPlay = !self.isPlay;
    _playImg.hidden = self.isPlay;
}

#pragma mark *****************  UI
#pragma mark 导航栏
-(void)setNavView
{
    BigClickBT *backBtn = [[BigClickBT alloc] init];
    [backBtn setImage:[UIImage imageNamed:@"nav_back"] forState:UIControlStateNormal];
    [backBtn addTarget:self action:@selector(backBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:backBtn];
    [backBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(SafeAreaStateHeight+WScale(10));
        make.left.mas_equalTo(WScale(15));
    }];
    
    BigClickBT *shareBtn = [[BigClickBT alloc] init];
    [shareBtn setImage:[UIImage imageNamed:@"nav_share"] forState:UIControlStateNormal];
    [shareBtn addTarget:self action:@selector(shareBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:shareBtn];
    [shareBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(backBtn);
        make.right.mas_equalTo(WScale(-15));
    }];
}

-(void)setAVPlayer
{
    self.isPlay = YES;
    AVPlayerItem *item = [[AVPlayerItem alloc] initWithURL:[NSURL URLWithString:videoUrl]];
    self.player = [[AVPlayer alloc] initWithPlayerItem:item];
    
    AVPlayerLayer *playerLayer = [AVPlayerLayer playerLayerWithPlayer:self.player];
    playerLayer.frame = CGRectMake(0,0, kWindowW, kWindowH);
    playerLayer.videoGravity=AVLayerVideoGravityResizeAspect;//视频填充模式
    [self.view.layer addSublayer:playerLayer];
    [self.player play];
     
     UIView *coverView = [[UIView alloc] initWithFrame:CGRectMake(WScale(15), SafeAreaTopHeight+WScale(50), kWindowW-WScale(30), kWindowH-SafeAreaTopHeight-WScale(200))];
     [self.view addSubview:coverView];
     
     _playImg = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"play_icon"]];
     _playImg.hidden = YES;
     [coverView addSubview:_playImg];
     [_playImg mas_makeConstraints:^(MASConstraintMaker *make) {
         make.center.mas_equalTo(coverView);
     }];
     
     UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapClick)];
     [coverView addGestureRecognizer:tap];
}

-(UIImageView *)topImg
{
    if (!_topImg) {
        _topImg = [[UIImageView alloc] init];
        [self.view addSubview:_topImg];
        [_topImg mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(self.view);
            make.left.top.mas_equalTo(0);
            make.height.mas_equalTo(SafeAreaTopHeight+WScale(10));
        }];
        
        CAGradientLayer *gl = [CAGradientLayer layer];
        gl.frame = CGRectMake(0,0,self.view.size.width,SafeAreaTopHeight+WScale(10));
        gl.startPoint = CGPointMake(0, 0);
        gl.endPoint = CGPointMake(1, 1);
        gl.colors = @[(__bridge id)[UIColor colorWithRed:0/255.0 green:0/255.0 blue:0/255.0 alpha:0.0].CGColor,(__bridge id)[UIColor colorWithRed:0/255.0 green:0/255.0 blue:0/255.0 alpha:0.3].CGColor];
        gl.locations = @[@(0.0),@(1.0f)];
        [_topImg.layer addSublayer:gl];
    }
    return _topImg;
}

-(UIImageView *)bottomImg
{
    if (!_bottomImg) {
        _bottomImg = [[UIImageView alloc] init];
        [self.view addSubview:_bottomImg];
        [_bottomImg mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(self.view);
            make.left.bottom.mas_equalTo(0);
            make.height.mas_equalTo(WScale(90)+SafeAreaBottomHeight);
        }];
        
        CAGradientLayer *gl = [CAGradientLayer layer];
        gl.frame = CGRectMake(0,0,self.view.size.width,WScale(90)+SafeAreaBottomHeight);
        gl.startPoint = CGPointMake(0, 0);
        gl.endPoint = CGPointMake(1, 1);
        gl.colors = @[(__bridge id)[UIColor colorWithRed:0/255.0 green:0/255.0 blue:0/255.0 alpha:0.0].CGColor,(__bridge id)[UIColor colorWithRed:0/255.0 green:0/255.0 blue:0/255.0 alpha:0.3].CGColor];
        gl.locations = @[@(0.0),@(1.0f)];
        [_bottomImg.layer addSublayer:gl];
    }
    return _bottomImg;
}

-(void)setShopInfoView
{
    _shopImg = [[UIImageView alloc] init];
    _shopImg.layer.cornerRadius = WScale(17);
    _shopImg.clipsToBounds = YES;
    _shopImg.image = [UIImage imageNamed:@"public_bg"];
    [self.bottomImg addSubview:_shopImg];
    [_shopImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(WScale(15));
        make.top.mas_equalTo(WScale(6));
        make.width.height.mas_equalTo(WScale(34));
    }];
    
    _shopName = [UILabel labelWithText:@"西庄裁缝" font:[UIFont boldSystemFontOfSize:WScale(13)] textColor:WhiteColor backGroundColor:ClearColor superView:self.view];
    [_shopName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.shopImg.mas_right).mas_equalTo(WScale(10));
        make.centerY.mas_equalTo(self.shopImg);
    }];
    
    _shopTitle = [UILabel labelWithText:@"裁衣改衣,提供上门取衣服务" font:[UIFont boldSystemFontOfSize:WScale(13)] textColor:WhiteColor backGroundColor:ClearColor superView:self.view];
    [_shopTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(WScale(15));
        make.top.mas_equalTo(self.shopImg.mas_bottom).mas_equalTo(WScale(15));
    }];
    
    BigClickBT *chatBtn = [[BigClickBT alloc] init];
    [chatBtn setImage:[UIImage imageNamed:@"home_chat2"] forState:UIControlStateNormal];
    [chatBtn addTarget:self action:@selector(chatClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:chatBtn];
    [chatBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.shopImg);
        make.right.mas_equalTo(WScale(-15));
    }];
}

///分享弹出框
-(SHSharePopView *)shareView
{
    if (!_shareView) {
        
        _shareView = [[SHSharePopView alloc] initWithFrame:CGRectMake(0, 0, kWindowW, kWindowH)];
    }
    return _shareView;
}
-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self.navigationController setNavigationBarHidden:NO];
    [self.player pause];
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
