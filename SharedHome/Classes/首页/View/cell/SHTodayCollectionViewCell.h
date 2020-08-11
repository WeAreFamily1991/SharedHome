//
//  SHTodayCollectionViewCell.h
//  SharedHome
//
//  Created by 解辉 on 2020/7/28.
//  Copyright © 2020 NaDao. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface SHTodayCollectionViewCell : UICollectionViewCell

@property(nonatomic,strong) UIImageView *headImg;
@property(nonatomic,strong) UIImageView *timeImg;
@property(nonatomic,strong) UIImageView *locationImg;

@property(nonatomic,strong) UILabel *titleLabel;
@property(nonatomic,strong) UILabel *timeLabel;
@property(nonatomic,strong) UILabel *addressLabel;
@property(nonatomic,strong) UILabel *distanceLabel;
@property(nonatomic,strong) UILabel *lineLabel;

@property(nonatomic,strong) BigClickBT *touBtn;

@property(nonatomic,strong) NSDictionary *dict;
@end

NS_ASSUME_NONNULL_END
