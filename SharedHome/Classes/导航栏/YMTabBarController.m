//
//  YMTabBarController.m
//  YYMei
//
//  Created by WenhuaLuo on 17/6/19.
//  Copyright © 2017年 Nado. All rights reserved.
//

#import "YMTabBarController.h"

#import "SHHomeViewController.h"
#import "SHCommunityViewController.h"
#import "SHPostViewController.h"
#import "SHServiceViewController.h"
#import "SHMyViewController.h"

#import "YMNavigationController.h"
#import "LBTabBar.h"
#import "SHPostSelectView.h"
#import "SHPostNeedViewController.h"

@interface YMTabBarController ()<LBTabBarDelegate>

@property (nonatomic,assign) NSInteger sessionUnreadCount;
@property (nonatomic,strong) SHPostSelectView *selectView;

@end

@implementation YMTabBarController

#pragma mark - 第一次使用当前类的时候对设置UITabBarItem的主题
+ (void)initialize
{
    UITabBarItem *tabBarItem = [UITabBarItem appearanceWhenContainedInInstancesOfClasses:@[self]];

    NSMutableDictionary *dictNormal = [NSMutableDictionary dictionary];
    dictNormal[NSForegroundColorAttributeName] = UIColorFromRGB(0x999999);
    dictNormal[NSFontAttributeName] = [UIFont systemFontOfSize:11];

    NSMutableDictionary *dictSelected = [NSMutableDictionary dictionary];
    dictSelected[NSForegroundColorAttributeName] = ThemeColor;
    dictSelected[NSFontAttributeName] = [UIFont systemFontOfSize:11];

    [tabBarItem setTitleTextAttributes:dictNormal forState:UIControlStateNormal];
    [tabBarItem setTitleTextAttributes:dictSelected forState:UIControlStateSelected];
    
    

}

- (void)viewDidLoad {
    [super viewDidLoad];

    [self setUpAllChildVc];

    //创建自己的tabbar，然后用kvc将自己的tabbar和系统的tabBar替换下
    LBTabBar *tabbar = [[LBTabBar alloc] init];
    tabbar.myDelegate = self;
    //kvc实质是修改了系统的_tabBar
    [self setValue:tabbar forKeyPath:@"tabBar"];

    [self.tabBar setBackgroundImage:[UIImage imageWithColor:WhiteColor]];
    
    //隐藏Tabbar顶部线
    UIImage *whiteImage = [UIImage imageWithColor:WhiteColor];
    if (@available(iOS 13.0, *))
    {
        // 手动放一张白色底图遮住系统tabbar的顶部线条
        // blankView颜色必须设置
        UIView *blankView = [[UIView alloc] initWithFrame:CGRectMake(0, -0.5, UIScreen.mainScreen.bounds.size.width, 0.5)];
        blankView.backgroundColor = UIColor.whiteColor;
        [self.tabBar addSubview:blankView];
    } else {
        [self.tabBar setBackgroundImage:whiteImage];
        [self.tabBar setShadowImage:whiteImage];
    }
    
    self.tabBar.unselectedItemTintColor = UIColorFromRGB(0x999999);
    self.tabBar.tintColor = ThemeColor;
}


#pragma mark - ------------------------------------------------------------------
#pragma mark - 初始化tabBar上除了中间按钮之外所有的按钮

- (void)setUpAllChildVc
{
    SHHomeViewController *HomeVC = [[SHHomeViewController alloc] init];
    [self setUpOneChildVcWithVc:HomeVC Image:@"home_normal" selectedImage:@"home_select" title:@"首页"];

    SHCommunityViewController *communityVC = [[SHCommunityViewController alloc] init];
    [self setUpOneChildVcWithVc:communityVC Image:@"community_normal" selectedImage:@"community_select" title:@"资源社区"];

    SHServiceViewController *serviceVC = [[SHServiceViewController alloc] init];
    [self setUpOneChildVcWithVc:serviceVC Image:@"service_normal" selectedImage:@"service_select" title:@"服务商"];

    SHMyViewController *myVC = [[SHMyViewController alloc] init];
    [self setUpOneChildVcWithVc:myVC Image:@"my_normal" selectedImage:@"my_select" title:@"我的"];


}

#pragma mark - 初始化设置tabBar上面单个按钮的方法

/**
 *  @author li bo, 16/05/10
 *
 *  设置单个tabBarButton
 *
 *  @param Vc            每一个按钮对应的控制器
 *  @param image         每一个按钮对应的普通状态下图片
 *  @param selectedImage 每一个按钮对应的选中状态下的图片
 *  @param title         每一个按钮对应的标题
 */
- (void)setUpOneChildVcWithVc:(UIViewController *)Vc Image:(NSString *)image selectedImage:(NSString *)selectedImage title:(NSString *)title
{
    YMNavigationController *nav = [[YMNavigationController alloc] initWithRootViewController:Vc];


    Vc.view.backgroundColor = WhiteColor;

    UIImage *myImage = [UIImage imageNamed:image];
    myImage = [myImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];

    //tabBarItem，是系统提供模型，专门负责tabbar上按钮的文字以及图片展示
    Vc.tabBarItem.image = myImage;

    UIImage *mySelectedImage = [UIImage imageNamed:selectedImage];
    mySelectedImage = [mySelectedImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];

    Vc.tabBarItem.selectedImage = mySelectedImage;

    Vc.tabBarItem.title = title;

    Vc.navigationItem.title = title;
    
    // 设置文字的样式
    NSMutableDictionary *textAttrs = [NSMutableDictionary dictionary];

    textAttrs[NSForegroundColorAttributeName] = UIColorFromRGB(0x999999);

    NSMutableDictionary *selectTextAttrs = [NSMutableDictionary dictionary];

    selectTextAttrs[NSForegroundColorAttributeName] = ThemeColor;
    [Vc.tabBarItem setTitleTextAttributes:textAttrs forState:UIControlStateNormal];
    [Vc.tabBarItem setTitleTextAttributes:selectTextAttrs forState:UIControlStateSelected];
    
    [self addChildViewController:nav];
    
}


#pragma mark - ------------------------------------------------------------------
#pragma mark - LBTabBarDelegate
//点击中间按钮的代理方法
- (void)tabBarPlusBtnClick:(LBTabBar *)tabBar
{
//    SHPostViewController *postVC = [[SHPostViewController alloc] init];
//    postVC.view.backgroundColor = WhiteColor;
//
//    YMNavigationController *navVc = [[YMNavigationController alloc] initWithRootViewController:postVC];
//    navVc.modalPresentationStyle = UIModalPresentationFullScreen;
//    [self presentViewController:navVc animated:YES completion:nil];
    
    [self.selectView show];
}

///发布选择
-(SHPostSelectView *)selectView
{
    YBWeakSelf;
    if (!_selectView) {
        _selectView = [[SHPostSelectView alloc] init];
        [_selectView setBlock:^(NSInteger Tag) {
            if (Tag == 0)
            {
                SHPostNeedViewController *postVC = [[SHPostNeedViewController alloc] init];
                postVC.view.backgroundColor = WhiteColor;
                
                YMNavigationController *navVc = [[YMNavigationController alloc] initWithRootViewController:postVC];
                navVc.modalPresentationStyle = UIModalPresentationFullScreen;
                [weakSelf presentViewController:navVc animated:YES completion:nil];
            }
            else
            {
                SHPostViewController *postVC = [[SHPostViewController alloc] init];
                postVC.view.backgroundColor = WhiteColor;
                
                YMNavigationController *navVc = [[YMNavigationController alloc] initWithRootViewController:postVC];
                navVc.modalPresentationStyle = UIModalPresentationFullScreen;
                [weakSelf presentViewController:navVc animated:YES completion:nil];
            }
        }];
    }
    return _selectView;;
}
@end
