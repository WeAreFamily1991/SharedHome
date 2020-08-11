//
//  SHHotCollectionViewCell.h
//  SharedHome
//
//  Created by 解辉 on 2020/7/29.
//  Copyright © 2020 NaDao. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface SHHotCollectionViewCell : UICollectionViewCell

@property(nonatomic,strong) UIImageView *bgImg;
@property(nonatomic,strong) UIImageView *shopImg;
@property(nonatomic,strong) UIImageView *playImg;
@property(nonatomic,strong) UIImageView *topImg;
@property(nonatomic,strong) UIImageView *bottomImg;

@property(nonatomic,strong) UILabel *titleLabel;
@property(nonatomic,strong) UILabel *shopName;

@property(nonatomic,strong) NSDictionary *dict;
@property(nonatomic,strong) UIViewController *rootVC;
@end

NS_ASSUME_NONNULL_END
