//
//  SHHomeDetailCell.h
//  SharedHome
//
//  Created by 解辉 on 2020/7/31.
//  Copyright © 2020 NaDao. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

//详情
@interface SHHomeDetailCell : UITableViewCell

@property(nonatomic,strong) UIImageView *headImg;
@property(nonatomic,strong) UIImageView *timeImg;
@property(nonatomic,strong) UIImageView *locationImg;

@property(nonatomic,strong) UILabel *titleLabel;
@property(nonatomic,strong) UILabel *timeLabel;
@property(nonatomic,strong) UILabel *addressLabel;
@property(nonatomic,strong) UILabel *distanceLabel;
@property(nonatomic,strong) UILabel *lineLabel;

@property(nonatomic,strong) NSDictionary *dict;

@end

//文字
@interface SHHomeDetailTextCell : UITableViewCell

@property(nonatomic,strong) UILabel *contentLabel;

@property(nonatomic,strong) NSDictionary *dict;

@end


//提示
@interface SHHomeDetailTipCell : UITableViewCell

@property(nonatomic,strong) UIImageView *tipImg;
@property(nonatomic,strong) UILabel *contentLabel;

@property(nonatomic,strong) NSDictionary *dict;
@end


//联系人信息
@interface SHHomeDetailInfoCell : UITableViewCell

@property(nonatomic,strong) UILabel *titleLabel;
@property(nonatomic,strong) UILabel *contentLabel;

@property(nonatomic,strong) NSDictionary *dict;
@end

NS_ASSUME_NONNULL_END
