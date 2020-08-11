//
//  SHShowAreaViewController.h
//  SharedHome
//
//  Created by 解辉 on 2020/8/5.
//  Copyright © 2020 NaDao. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface SHShowAreaViewController : UIViewController

@property(nonatomic,copy)void(^SelectArea)(NSMutableDictionary *dict);

@property(nonatomic,strong)NSMutableDictionary *selectDict;
@property(nonatomic,strong)NSMutableArray *leftSelectArray;
@property(nonatomic,strong)NSMutableArray *rightSelectArray;
@end

NS_ASSUME_NONNULL_END
