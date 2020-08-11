//
//  SHServiceHomePageCell.h
//  SharedHome
//
//  Created by 解辉 on 2020/8/3.
//  Copyright © 2020 NaDao. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface SHServiceHomePageCell : UICollectionViewCell

@property(nonatomic,strong) UIView *labelView;
@property(nonatomic,strong) UIImageView *shopImg;

@property(nonatomic,strong) UILabel *titleLabel;
@property(nonatomic,strong) UILabel *classLabel;
@property(nonatomic,strong) UILabel *numLabel;
@property(nonatomic,strong) UIButton *chatBtn;

@property(nonatomic,strong) UIButton *locationBtn;
@property(nonatomic,strong) UIImageView *locationImg;
@property(nonatomic,strong) UILabel *locationLabel;
@property(nonatomic,strong) UIImageView *arrowImg;
@property(nonatomic,strong) UIScrollView *locationImgView;

@property(nonatomic,strong) NSArray *typeArray;
@property(nonatomic,strong) NSArray *imgArray;
@property(nonatomic,strong) NSDictionary *dict;
@property(nonatomic,strong) UIViewController *rootVC;
@property(nonatomic,copy) void(^LocationBlock)(BOOL isOpen);
@end

NS_ASSUME_NONNULL_END
