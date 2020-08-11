//
//  SHPostSelectView.h
//  SharedHome
//
//  Created by 解辉 on 2020/8/4.
//  Copyright © 2020 NaDao. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^TapBlock)(NSInteger Tag);

@interface SHPostSelectView : UIView

@property (nonatomic,strong)UIView *shareView;
@property (nonatomic,copy) TapBlock block;


-(void)show;

-(void)close;

@end

NS_ASSUME_NONNULL_END
