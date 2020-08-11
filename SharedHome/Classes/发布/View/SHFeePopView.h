//
//  SHFeePopView.h
//  SharedHome
//
//  Created by 解辉 on 2020/8/4.
//  Copyright © 2020 NaDao. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface SHFeePopView : UIView

@property(nonatomic,strong) UILabel *contentLabel;

@property(nonatomic,copy)NSString *title;
@property(nonatomic,copy)NSString *content;
- (void)show;
@end

NS_ASSUME_NONNULL_END
