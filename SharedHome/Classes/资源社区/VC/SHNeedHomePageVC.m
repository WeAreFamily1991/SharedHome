//
//  SHNeedHomePageVC.m
//  SharedHome
//
//  Created by 解辉 on 2020/7/31.
//  Copyright © 2020 NaDao. All rights reserved.
//

#import "SHNeedHomePageVC.h"
#import "SHHotCollectionViewCell.h"
#import "SHHomePageCell.h"
#import "SHVideoDetailVC.h"

static NSString *const cellID =@"SHHomePageCell";
static NSString *const cellID2 =@"SHHotCollectionViewCell";
static NSString *const headID = @"MyCollectionViewHeadView";
static NSString *const footID = @"MyCollectionViewFooterView";

@interface SHNeedHomePageVC ()<UICollectionViewDelegate,UICollectionViewDataSource>

@property(nonatomic,strong) UICollectionView *collectionView;
@end

@implementation SHNeedHomePageVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = WhiteColor;
    self.title = @"需求方主页";
    [self setCollectionView];
    [self setupRightNavItem];
}
#pragma mark ********** 按钮的点击事件
//拉黑
-(void)onBlackClick:(UIButton *)button
{
     [[YZMBPManager sharedMBPManager] showHUDWithText:@"拉黑成功，以后将不会收到此用户的资源短视频"];
}

#pragma mark ***************  CollectionView
-(void)setCollectionView
{
    ///创建layout
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    ///创建collectionView
    UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
    collectionView.showsVerticalScrollIndicator = NO;
    collectionView.showsHorizontalScrollIndicator = NO;
    collectionView.delegate = self;
    collectionView.dataSource = self;
    collectionView.backgroundColor = [UIColor whiteColor];
    
    ///纯代码
    [collectionView registerClass:[SHHomePageCell class] forCellWithReuseIdentifier:cellID];
    [collectionView registerClass:[SHHotCollectionViewCell class] forCellWithReuseIdentifier:cellID2];
    [collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:headID];
    [collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:footID];
    [self.view addSubview:collectionView];
    [collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.centerX.mas_equalTo(self.view);
        make.top.mas_equalTo(SafeAreaTopHeight);
        make.bottom.mas_equalTo(0);
    }];
    self.collectionView = collectionView;
}
///区数
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 2;
}
///每个Item的个数
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    if (section == 0) {
        return 1;
    }
    return 2;
}
///内容
- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0)
    {
        SHHomePageCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellID forIndexPath:indexPath];
        cell.dict = @{};
        cell.rootVC = self;
        return cell;
    }
    else
    {
        SHHotCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellID2 forIndexPath:indexPath];
        cell.dict = @{};
        cell.rootVC = self;
        return cell;
    }
}
///区头，区尾内容
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    if (kind == UICollectionElementKindSectionHeader)
    {
        UICollectionReusableView *headView = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:headID forIndexPath:indexPath];
        if (headView == nil) {
            
            headView = [[UICollectionReusableView alloc] init];
        }
        [headView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
        
        if (indexPath.section == 1) {
            UILabel *titleLabel = [UILabel labelWithText:@"作品" font:[UIFont boldSystemFontOfSize:WScale(15)] textColor:UIColorFromRGB(0x333333) backGroundColor:ClearColor superView:headView];
            [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.mas_equalTo(WScale(15));
                make.centerY.mas_equalTo(headView);
            }];
        }
       
        return headView;
    }
    else if (kind == UICollectionElementKindSectionFooter)
    {
        UICollectionReusableView *footView = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:footID forIndexPath:indexPath];
        if (footView == nil) {

            footView = [[UICollectionReusableView alloc] init];
        }
        [footView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
        
        UILabel *lineLabel = [[UILabel alloc] initWithFrame:CGRectMake(0,0,kWindowW, WScale(8))];
        lineLabel.backgroundColor = UIColorFromRGB(0xF5F5F5);
        [footView addSubview:lineLabel];
        return footView;
    }
    return nil;
}

///cell的点击事件
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    SHVideoDetailVC *detailVC = [[SHVideoDetailVC alloc] init];
    [self.navigationController pushViewController:detailVC animated:YES];
}

///cell的尺寸大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
       return CGSizeMake(kWindowW, WScale(102));
    }
    else
    {
        return CGSizeMake(kWindowW/2-WScale(10), WScale(240));
    }
    
}
///每个分区的内边距（上左下右)
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    if (section == 0) {
       return UIEdgeInsetsMake(0,0,0,0);
    }
    else
    {
       return UIEdgeInsetsMake(WScale(5),WScale(5),WScale(5),WScale(5));
    }
}
/** 区头大小 */
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
       return CGSizeMake(kWindowW,1);
    }
    return CGSizeMake(kWindowW,WScale(44));
    
}
/** 区尾大小 */
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section
{
    if (section == 0) {
      return CGSizeMake(kWindowW,WScale(8));
    }
    return CGSizeMake(kWindowW,1);
}

- (void)setupRightNavItem
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(0, 0, WScale(80), 44);
    [button setTitle:@" 拉黑    " forState:UIControlStateNormal];
    [button setTitleColor:UIColorFromRGB(0x666666) forState:UIControlStateNormal];
    button.titleLabel.font = kFont(14);
    [button addTarget:self action:@selector(onBlackClick:) forControlEvents:UIControlEventTouchUpInside];
    [button setImage:[UIImage imageNamed:@"home_black"] forState:UIControlStateNormal];
    [button setImage:[UIImage imageNamed:@"home_black"] forState:UIControlStateHighlighted];
    [button sizeToFit];
    UIBarButtonItem *buttonItem = [[UIBarButtonItem alloc] initWithCustomView:button];
    self.navigationItem.rightBarButtonItem = buttonItem;
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
