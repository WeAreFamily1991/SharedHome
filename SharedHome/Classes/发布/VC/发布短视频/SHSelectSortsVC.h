//
//  SHSelectSortsVC.h
//  SharedHome
//
//  Created by 解辉 on 2020/8/4.
//  Copyright © 2020 NaDao. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface SHSelectSortsVC : UIViewController

@property(nonatomic,copy)void(^SelectSort)(NSArray *sortArray);
@property(nonatomic,strong)NSMutableArray *selectArray;
@end

NS_ASSUME_NONNULL_END
