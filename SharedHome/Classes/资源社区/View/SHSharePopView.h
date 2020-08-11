//
//  SHSharePopView.h
//  SharedHome
//
//  Created by 解辉 on 2020/8/3.
//  Copyright © 2020 NaDao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SHShareTipView.h"

NS_ASSUME_NONNULL_BEGIN
typedef void(^TapBlock)(NSInteger Tag);

@interface SHSharePopView : UIView

@property (nonatomic,strong)UIView *shareView;
@property (nonatomic,strong)UIView *popView;
@property (nonatomic,copy) TapBlock block;
@property (nonatomic,copy) NSString *shareUrl;          ///链接
@property (nonatomic,copy) NSString *shareTitle;        ///标题
@property (nonatomic,copy) NSString *shareImg;          ///图片
@property (nonatomic,copy) NSString *shareDescription;  ///<描述
@property (nonatomic,assign) BOOL onlyImg;  ///<YES：只是分享图片
@property (nonatomic,strong) UIImage *screenImg;  ///<截屏
@property(nonatomic,strong)UIImageView *screenImgView;
@property(nonatomic,strong)UIImage *screenImg2;


@property(nonatomic,strong) UIImageView *shareIcon;
@property(nonatomic,strong) UILabel *shareName;
@property(nonatomic,strong) UILabel *sharedTitle;

@property(nonatomic,strong) UIImageView *erIcon;
@property(nonatomic,strong) UILabel *erTitle;

@property(nonatomic,strong) UIImageView *shopImg;
@property(nonatomic,strong) UILabel *shopName;
@property(nonatomic,strong) UILabel *shopTitle;

@property(nonatomic,strong) SHShareTipView *tipView;

-(void)show;

-(void)close;
@end

NS_ASSUME_NONNULL_END
