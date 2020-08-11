//
//  UITextField+SPExtension.h
//  CircleOfTrade
//
//  Created by 解辉 on 2019/7/25.
//  Copyright © 2019 LWH. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol SPTextFieldDelegate <UITextFieldDelegate>

@optional
- (void)textFieldDidDeleteBackward:(UITextField *)textField;
@end


@interface UITextField (SPExtension)

@property (weak, nonatomic) id<SPTextFieldDelegate> delegate;

- (instancetype)initWithPlaceholder:(NSString *)placeHolder showView:(UIView *)showView delegate:(id<UITextFieldDelegate>)delegate showFont:(UIFont *)font showColor:(UIColor *)color placeholderColor:(UIColor *)placeholderColor;

@end

/**
 *  监听删除按钮
 *  object:UITextField
 */
extern NSString * const SPTextFieldDidDeleteBackwardNotification;



NS_ASSUME_NONNULL_END
