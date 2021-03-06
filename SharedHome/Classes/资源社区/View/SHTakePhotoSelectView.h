//
//  SHTakePhotoSelectView.h
//  SharedHome
//
//  Created by 解辉 on 2020/8/3.
//  Copyright © 2020 NaDao. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^SelectBlock)(NSInteger Tag);
@interface SHTakePhotoSelectView : UIView

@property(nonatomic,strong)NSArray *selectArray;
@property (nonatomic, copy) SelectBlock  selectBlock;

- (void)show;
@end

NS_ASSUME_NONNULL_END
