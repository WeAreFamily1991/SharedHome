//
//  UITextField+SPExtension.m
//  CircleOfTrade
//
//  Created by 解辉 on 2019/7/25.
//  Copyright © 2019 LWH. All rights reserved.
//

#import "UITextField+SPExtension.h"
#import <objc/runtime.h>

NSString * const SPTextFieldDidDeleteBackwardNotification = @"textfield_did_notification";


@implementation UITextField (SPExtension)
+ (void)load {
    Method method1 = class_getInstanceMethod([self class], NSSelectorFromString(@"deleteBackward"));
    Method method2 = class_getInstanceMethod([self class], @selector(sp_deleteBackward));
    method_exchangeImplementations(method1, method2);
}
- (void)sp_deleteBackward {
    [self sp_deleteBackward];
    
    if ([self.delegate respondsToSelector:@selector(textFieldDidDeleteBackward:)])
    {
        id <SPTextFieldDelegate> delegate  = (id<SPTextFieldDelegate>)self.delegate;
        [delegate textFieldDidDeleteBackward:self];
    }
    
    [[NSNotificationCenter defaultCenter] postNotificationName:SPTextFieldDidDeleteBackwardNotification object:self];
}


- (instancetype)initWithPlaceholder:(NSString *)placeHolder showView:(UIView *)showView delegate:(id<UITextFieldDelegate>)delegate showFont:(UIFont *)font showColor:(UIColor *)color placeholderColor:(UIColor *)placeholderColor
{
    UITextField *field = [[UITextField alloc] init];
    field.clipsToBounds = YES;
    field.delegate = delegate;
    field.textColor = color;
    field.font = font;
    field.placeholder = placeHolder;
    field.tintColor = color;
    UIFont *tempFont = kFont(15);
    if (@available(iOS 13.0, *)) {
        field.attributedPlaceholder = [[NSAttributedString alloc] initWithString:placeHolder attributes:@{NSFontAttributeName:tempFont,NSForegroundColorAttributeName:placeholderColor}];
    }
    else
    {
        [field setValue:placeholderColor forKeyPath:@"_placeholderLabel.textColor"];
        [field setValue:tempFont forKeyPath:@"_placeholderLabel.font"];
    }
    field.returnKeyType = UIReturnKeyDone;
    field.clearButtonMode = UITextFieldViewModeWhileEditing;
    [showView addSubview:field];
    return field;
}

@end
