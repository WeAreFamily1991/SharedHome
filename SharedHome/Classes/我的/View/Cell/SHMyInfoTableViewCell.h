//
//  SHMyInfoTableViewCell.h
//  SharedHome
//
//  Created by 解辉 on 2020/8/6.
//  Copyright © 2020 NaDao. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

//头部个人信息
@interface SHMyInfoTableViewCell : UITableViewCell

@property(nonatomic,strong) UIView *labelView;
@property(nonatomic,strong) UIView *moneyView;
@property(nonatomic,strong) UIImageView *shopImg;
@property(nonatomic,strong) UIImageView *arrowImg;

@property(nonatomic,strong) UILabel *titleLabel;
@property(nonatomic,strong) UILabel *moneyLabel;
@property(nonatomic,strong) UIButton *cashBtn;
@property(nonatomic,strong) UILabel *phoneTipLabel;
@property(nonatomic,strong) UIButton *phoneBtn;
@property(nonatomic,strong) BigClickBT *classBtn;
@property(nonatomic,strong) NSArray *typeArray;

@property(nonatomic,strong) NSDictionary *dict;
@property(nonatomic,strong) UIViewController *rootVC;

@end


//各个分类
@interface SHMyClassTableViewCell : UITableViewCell

@property(nonatomic,strong) UIImageView *arrowImg;
@property(nonatomic,strong) UILabel *titleLabel;

@property(nonatomic,strong) NSDictionary *dict;
@property(nonatomic,strong) UIViewController *rootVC;

@end


//是否接受平台自动匹配接单
@interface SHMyIfGetDanCell : UITableViewCell

@property(nonatomic,strong) UILabel *titleLabel;
@property(nonatomic,strong) UILabel *tipLabel;
@property(nonatomic,strong) UISwitch *switchBtn;

@property(nonatomic,strong) NSDictionary *dict;
@property(nonatomic,strong) UIViewController *rootVC;

@end

NS_ASSUME_NONNULL_END
