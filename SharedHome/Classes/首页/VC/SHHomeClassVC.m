//
//  SHHomeClassVC.m
//  SharedHome
//
//  Created by 解辉 on 2020/7/31.
//  Copyright © 2020 NaDao. All rights reserved.
//

#import "SHHomeClassVC.h"
#import "FSPageContentView2.h"
#import "FSSegmentTitleView2.h"
#import "SHHomeClassChildVC.h"

@interface SHHomeClassVC ()<FSPageContentViewDelegate,FSSegmentTitleViewDelegate>

@property (nonatomic, strong) FSPageContentView2 *pageContentView;
@property (nonatomic, strong) FSSegmentTitleView2 *titleView;
@property (nonatomic, strong) NSMutableArray *childVCs;
@end

@implementation SHHomeClassVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = WhiteColor;
    self.title = self.titleStr;
    [self setSegmentView];
}

#pragma mark *****************  按钮的点击事件


#pragma mark *****************  UI
///分段选择
-(void)setSegmentView
{
    self.automaticallyAdjustsScrollViewInsets = NO;
    NSArray *titleArray = @[@"全部",@"家具维修安装",@"保洁",@"保姆",@"开锁",@"管道疏通"];
    self.titleView = [[FSSegmentTitleView2 alloc]initWithFrame:CGRectMake(0,SafeAreaTopHeight,kWindowW,WScale(44)) delegate:self indicatorType:0];
    self.titleView.backgroundColor = ClearColor;
    self.titleView.titlesArr = titleArray;
    _titleView.titleNormalColor = UIColorFromRGB(0x333333);
    _titleView.titleSelectColor = ThemeColor;
    self.titleView.titleFont = kFont(13);
    self.titleView.titleSelectFont = kFont(13);
    self.titleView.indicatorView.image = [UIImage imageWithColor:ClearColor];
    [self.view addSubview:_titleView];
    
    self.childVCs = [[NSMutableArray alloc]init];
    
    for (int i = 0; i<titleArray.count; i++)
    {
        SHHomeClassChildVC *VC = [[SHHomeClassChildVC alloc] init];
        VC.status = i;
        [self.childVCs addObject:VC];
    }
    self.pageContentView = [[FSPageContentView2 alloc]initWithFrame:CGRectMake(0,SafeAreaTopHeight+WScale(44), kWindowW,kWindowH-SafeAreaTopHeight-WScale(44)) childVCs:self.childVCs parentVC:self delegate:self];
    self.pageContentView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:_pageContentView];
    
    self.titleView.selectIndex = _num;
    self.pageContentView.contentViewCurrentIndex = _num;
}
//********************************  分段选择  **************************************
- (void)FSSegmentTitleView:(FSSegmentTitleView2 *)titleView startIndex:(NSInteger)startIndex endIndex:(NSInteger)endIndex
{
    self.pageContentView.contentViewCurrentIndex = endIndex;
}
- (void)FSContenViewDidEndDecelerating:(FSPageContentView2 *)contentView startIndex:(NSInteger)startIndex endIndex:(NSInteger)endIndex
{
    self.titleView.selectIndex = endIndex;
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
