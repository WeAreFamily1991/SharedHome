//
//  SHHomePageCell.h
//  SharedHome
//
//  Created by 解辉 on 2020/7/31.
//  Copyright © 2020 NaDao. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface SHHomePageCell : UICollectionViewCell

@property(nonatomic,strong) UIImageView *shopImg;

@property(nonatomic,strong) UILabel *titleLabel;
@property(nonatomic,strong) UILabel *renLabel;

@property(nonatomic,strong) UIButton *chatBtn;

@property(nonatomic,strong) NSDictionary *dict;
@property(nonatomic,strong) UIViewController *rootVC;

@end

NS_ASSUME_NONNULL_END
