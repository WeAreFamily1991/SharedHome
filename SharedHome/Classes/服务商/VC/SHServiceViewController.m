//
//  SHServiceViewController.m
//  SharedHome
//
//  Created by 解辉 on 2020/7/27.
//  Copyright © 2020 NaDao. All rights reserved.
//

#import "SHServiceViewController.h"
#import "SHServiceCollectionViewCell.h"
#import "SHServiceHomePageVC.h"

static NSString *const cellID = @"SHServiceCollectionViewCell";


@interface SHServiceViewController ()<UICollectionViewDelegate,UICollectionViewDataSource>

@property(nonatomic,strong) UICollectionView *collectionView;
@end

@implementation SHServiceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setCollectionView];
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
    collectionView.backgroundColor = UIColorFromRGB(0xF5F5F5);
    
    ///纯代码
    [collectionView registerClass:[SHServiceCollectionViewCell class] forCellWithReuseIdentifier:cellID];
    [self.view addSubview:collectionView];
    [collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.centerX.mas_equalTo(self.view);
        make.top.mas_equalTo(SafeAreaTopHeight);
        make.bottom.mas_equalTo(-SafeAreaBottomHeight);
    }];
    self.collectionView = collectionView;
}
///区数
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}
///每个Item的个数
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 6;
}
///内容
- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    SHServiceCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellID forIndexPath:indexPath];
    cell.dict = @{};
    return cell;
}

///cell的点击事件
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    SHServiceHomePageVC *pageVC = [[SHServiceHomePageVC alloc] init];
    [self.navigationController pushViewController:pageVC animated:YES];
}

///cell的尺寸大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
     return CGSizeMake(kWindowW/2-WScale(10), WScale(180));
}
///每个分区的内边距（上左下右)
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(WScale(5),WScale(5),WScale(5),WScale(5));
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
