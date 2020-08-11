//
//  SHShopTypeSelectView.m
//  SharedHome
//
//  Created by 解辉 on 2020/8/7.
//  Copyright © 2020 NaDao. All rights reserved.
//

#import "SHShopTypeSelectView.h"

@interface SHShopTypeSelectView ()<UIGestureRecognizerDelegate>

@property(nonatomic,strong)UIView *popView;
@property(nonatomic,assign) float popViewHeight;

@property(nonatomic,strong)BigClickBT *sureBtn;
@property(nonatomic,strong)BigClickBT *cancelBtn;
@property(nonatomic,strong)UILabel *titleLabel;
@end

@implementation SHShopTypeSelectView

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.frame = CGRectMake(0,0, kWindowW, kWindowH);
        self.backgroundColor = [UIColor colorWithWhite:0 alpha:0.3];
        self.clipsToBounds = YES;
        self.tag = 100;
        
        self.popViewHeight = WScale(55)*2+SafeAreaBottomHeight;
        
        self.popView = [[UIView alloc] initWithFrame:CGRectMake(0, kWindowH, kWindowW,self.popViewHeight)];
        self.popView.backgroundColor = WhiteColor;
        [self addSubview:self.popView];
    
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapClick)];
        tap.delegate = self;
        [self addGestureRecognizer:tap];
    }
    return self;
}

-(void)setSelectArray:(NSArray *)selectArray
{
    _selectArray = selectArray;
    
    self.popViewHeight = WScale(55)*selectArray.count+SafeAreaBottomHeight;
    
    [self show];
    
    [self.popView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];

    for (int i = 0; i<selectArray.count; i++)
    {
        UIButton *selectBtn = [UIButton buttonWithTitle:selectArray[i] font:kFont(17) titleColor:UIColorFromRGB(0x333333) backGroundColor:ClearColor buttonTag:i target:self action:@selector(selectBtnClick:) showView:self.popView];
        float height = WScale(55)*i;
        [selectBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(0);
            make.centerX.mas_equalTo(self.popView);
            make.top.mas_equalTo(height);
            make.height.mas_equalTo(WScale(55));
        }];
        
        ///划线
        if (i>0) {
            UILabel *lineLabel = [[UILabel alloc] initWithFrame:CGRectMake(0,0, kWindowW, 1)];
            lineLabel.backgroundColor = UIColorFromRGB(0xeeeeee);
            [selectBtn addSubview:lineLabel];
        }
    }
}
#pragma mark 选择按钮的点击事件
-(void)selectBtnClick:(UIButton *)button
{
    if (_selectBlock) {
        _selectBlock(button.tag);
    }
    [self dismiss];
}
#pragma mark 取消按钮的点击事件
-(void)cancelBtnClick
{
    [self dismiss];
}
-(void)tapClick
{
    [self dismiss];
}
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch {
    if (touch.view.tag == 100) {
        return YES;
    }
    else
    {
        return NO;
    }
}

- (void)show {
    UIWindow *window = [[[UIApplication sharedApplication] delegate] window];
    [window addSubview:self];
    
    YBWeakSelf;
    [UIView animateWithDuration:0.2 animations:^{
        self.popView.frame = CGRectMake(0, kWindowH-weakSelf.popViewHeight, kWindowW, weakSelf.popViewHeight);
    }];
    
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:self.popView.bounds byRoundingCorners:UIRectCornerTopLeft | UIRectCornerTopRight cornerRadii:CGSizeMake(10, 10)];
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
    maskLayer.frame = self.popView.bounds;
    maskLayer.path = maskPath.CGPath;
    self.popView.layer.mask = maskLayer;
}

- (void)dismiss
{
    [UIView animateWithDuration:0.2 animations:^{
        self.popView.frame = CGRectMake(0, kWindowH, kWindowW,0);
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
    [self endEditing:YES];
}


@end
