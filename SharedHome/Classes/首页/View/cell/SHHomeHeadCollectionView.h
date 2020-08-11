//
//  SHHomeHeadCollectionView.h
//  SharedHome
//
//  Created by 解辉 on 2020/7/28.
//  Copyright © 2020 NaDao. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^TypeBlock)(NSInteger tag);
typedef void(^ClassBlock)(NSInteger tag);

@interface SHHomeHeadCollectionView : UICollectionReusableView

@property(nonatomic,strong) UIView *headView;
@property(nonatomic,strong) UIButton *topImg;
@property(nonatomic,strong) UIView *classView;
@property(nonatomic,strong) UIView *typeView;
@property(nonatomic,strong) UILabel *typeLabel;
@property(nonatomic,strong) UIViewController *rootVC;
@property(nonatomic,assign) NSInteger typeTag;
@property(nonatomic,copy) TypeBlock block;
@property(nonatomic,copy) ClassBlock classBlock;
@end

NS_ASSUME_NONNULL_END
