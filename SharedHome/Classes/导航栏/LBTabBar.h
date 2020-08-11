//
//  LBTabBar.h
//  SharedHome
//
//  Created by 解辉 on 2020/7/27.
//  Copyright © 2020 NaDao. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class LBTabBar;

@protocol LBTabBarDelegate <NSObject>
@optional
- (void)tabBarPlusBtnClick:(LBTabBar *)tabBar;
@end

@interface LBTabBar : UITabBar

/** tabbar的代理 */
@property (nonatomic, weak) id<LBTabBarDelegate> myDelegate ;

@end

NS_ASSUME_NONNULL_END
