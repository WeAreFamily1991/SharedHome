//
//  CustomCollectionViewFlowLayout.h
//  TianHeProject
//
//  Created by 那道 on 2020/1/13.
//  Copyright © 2020 LWH. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
typedef NS_ENUM(NSInteger,AlignType){
    AlignWithLeft,
    AlignWithCenter,
    AlignWithRight
};
@interface CustomCollectionViewFlowLayout : UICollectionViewFlowLayout
//两个Cell之间的距离
@property (nonatomic,assign)CGFloat betweenOfCell;
//cell对齐方式
@property (nonatomic,assign)AlignType cellType;

-(instancetype)initWthType : (AlignType)cellType;

//全能初始化方法 其他方式初始化最终都会�走到这里
-(instancetype)initWithType:(AlignType) cellType betweenOfCell:(CGFloat)betweenOfCell;
@end

NS_ASSUME_NONNULL_END
