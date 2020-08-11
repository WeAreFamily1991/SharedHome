//
//  SHServiceCollectionViewCell.h
//  SharedHome
//
//  Created by 解辉 on 2020/8/3.
//  Copyright © 2020 NaDao. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface SHServiceCollectionViewCell : UICollectionViewCell

@property(nonatomic,strong) UIView *bgView;
@property(nonatomic,strong) UIImageView *headImg;

@property(nonatomic,strong) UILabel *nameLabel;
@property(nonatomic,strong) UILabel *contentLabel;
@property(nonatomic,strong) UILabel *numLabel;

@property(nonatomic,strong) NSDictionary *dict;

@end

NS_ASSUME_NONNULL_END
