//
//  SHShopInfoCell.h
//  SharedHome
//
//  Created by 解辉 on 2020/8/7.
//  Copyright © 2020 NaDao. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface SHShopInfoCell : UITableViewCell<UITextFieldDelegate>

@property(nonatomic,strong) UILabel *titleLabel;
@property(nonatomic,strong) UITextField *infoTF;
@property(nonatomic,strong) UIImageView *arrowImg;

@property(nonatomic,strong) NSDictionary *dict;
@end


//营业执照 | logo | 技能证书 | 个人头像
@interface SHShopInfoPhotoCell : UITableViewCell

@property(nonatomic,strong) UILabel *titleLabel;
@property(nonatomic,strong) UIButton *photoBtn;
@property(nonatomic,assign) NSInteger section;
@property(nonatomic,assign) NSInteger selectType;

@property(nonatomic,strong) NSDictionary *dict;
@property(nonatomic,copy) void(^SelectPhotoBlock)(NSInteger selectType,NSInteger section);
@end


//门头照片
@interface SHShopDoorPhotoCell : UITableViewCell

@property(nonatomic,strong) UILabel *titleLabel;
@property(nonatomic,strong) UIView *photoView;

@property(nonatomic,strong) UIButton *photoBtn;
@property(nonatomic,strong) NSMutableArray *photoArray;

@property(nonatomic,strong) UIButton *IDZhengBtn; ///<身份证正面照
@property(nonatomic,strong) UIButton *IDFanBtn;   ///<身份证反面照

@property(nonatomic,assign) NSInteger section;
@property(nonatomic,assign) NSInteger selectType;

@property(nonatomic,strong) NSDictionary *dict;
@property(nonatomic,strong) NSDictionary *dict2;

@property(nonatomic,copy) void(^SelectDoorPhotoBlock)(BOOL isSelect);
@property(nonatomic,copy) void(^DeleteDoorPhotoBlock)(NSInteger Tag);
@property(nonatomic,copy) void(^AddIDPhotoBlock)(NSInteger Tag);
@end


//有提供24小时服务的能力
@interface SHShop24HourCell : UITableViewCell

@property(nonatomic,strong) UIButton *SelectBtn;

@property(nonatomic,strong) NSDictionary *dict;

@property(nonatomic,copy) void(^SelectBlock)(BOOL select);
@end

NS_ASSUME_NONNULL_END
