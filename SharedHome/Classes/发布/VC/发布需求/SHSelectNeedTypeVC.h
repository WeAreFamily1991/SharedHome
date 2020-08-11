//
//  SHSelectNeedTypeVC.h
//  SharedHome
//
//  Created by 解辉 on 2020/8/5.
//  Copyright © 2020 NaDao. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface SHSelectNeedTypeVC : UIViewController

@property(nonatomic,copy)void(^SelectType)(NSString *selectType);

@property (nonatomic,copy) NSString *currentType2;

@end

NS_ASSUME_NONNULL_END
