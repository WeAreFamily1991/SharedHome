//
//  SHHomeViewController.m
//  SharedHome
//
//  Created by 解辉 on 2020/7/27.
//  Copyright © 2020 NaDao. All rights reserved.
//

#import "SHHomeViewController.h"
#import "SHHomeHeadCollectionView.h"
#import "SHTodayCollectionViewCell.h"
#import "SHHotCollectionViewCell.h"
#import "SHChangeCityTipView.h"
#import "SHSelectCityVC.h"
#import "SHHomeSearchVC.h"
#import "SHMoreNeedViewController.h"
#import "SHHomeClassVC.h"
#import "SHHomeDetailVC.h"
#import "SHVideoDetailVC.h"

static NSString *const cellID = @"SHTodayCollectionViewCell";
static NSString *const cellID2 =@"SHHotCollectionViewCell";
static NSString *const headID = @"HomeHeadCollectionView";
static NSString *const footID = @"MyCollectionViewFooterView";

@interface SHHomeViewController ()<UICollectionViewDelegate,UICollectionViewDataSource>

@property(nonatomic,strong) BigClickBT *locationBtn;
@property(nonatomic,strong) UIView *searchView;
@property(nonatomic,strong) UICollectionView *collectionView;
@property(nonatomic,strong) UILabel *locationLabel;
@property(nonatomic,assign) NSInteger typeTag; ///<100:今日需求  101:热门资源
@property(nonatomic,strong) SHChangeCityTipView *tipView;
@end

@implementation SHHomeViewController

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self.navigationController setNavigationBarHidden:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.typeTag = 100;
    [self locationBtn];
    [self searchView];
    [self setCollectionView];
}

#pragma mark *****************  按钮的点击事件
//定位
-(void)locationBtnClick:(UIButton *)button
{
//    self.tipView.changeCity = @"苏州市 姑苏区";
//    [self.tipView show];
    
    SHSelectCityVC *cityVC = [[SHSelectCityVC alloc] init];
    [self.navigationController pushViewController:cityVC animated:YES];
}

//服务电话
-(void)phoneBtnClick
{
    
}

//搜索
-(void)searchBtn
{
    SHHomeSearchVC *searchVC = [[SHHomeSearchVC alloc] init];
    [self.navigationController pushViewController:searchVC animated:YES];
}

//查看更多需求
-(void)moreBtnClick
{
    if (self.typeTag == 100) {
        SHMoreNeedViewController *needVC = [[SHMoreNeedViewController alloc] init];
        [self.navigationController pushViewController:needVC animated:YES];
    }
    
}

#pragma mark *****************  UI
//定位
-(BigClickBT *)locationBtn
{
    if (!_locationBtn) {
        _locationBtn = [[BigClickBT alloc] init];
        [_locationBtn addTarget:self action:@selector(locationBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:_locationBtn];
        [_locationBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(WScale(15));
            make.top.mas_equalTo(SafeAreaStateHeight+WScale(15));
        }];
        
        UIImageView *locationImg = [[UIImageView alloc] init];
        locationImg.image = [UIImage imageNamed:@"home_location"];
        [_locationBtn addSubview:locationImg];
        [locationImg mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(0);
            make.centerY.mas_equalTo(_locationBtn);
            make.width.height.mas_equalTo(WScale(14));
        }];
        
        UILabel *locationLabel = [UILabel labelWithText:@"姑苏区" font:kFont(13) textColor:UIColorFromRGB(0x333333) backGroundColor:ClearColor superView:_locationBtn];
        [locationLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(locationImg.mas_right).mas_equalTo(WScale(6));
            make.centerY.mas_equalTo(_locationBtn);
        }];
        self.locationLabel = locationLabel;
        
        UIImageView *arrowImg = [[UIImageView alloc] init];
        arrowImg.image = [UIImage imageNamed:@"home_arrow"];
        [_locationBtn addSubview:arrowImg];
        [arrowImg mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(locationLabel.mas_right).mas_equalTo(WScale(6));
            make.centerY.mas_equalTo(_locationBtn);
            make.width.height.mas_equalTo(WScale(10));
            make.right.mas_equalTo(0);
        }];
        
        BigClickBT *phoneBtn = [[BigClickBT alloc] init];
        [phoneBtn setTitle:@"紧急服务：400-400-9999" forState:UIControlStateNormal];
        [phoneBtn setTitleColor:ThemeColor forState:UIControlStateNormal];
        phoneBtn.titleLabel.font = kFont(13);
        [phoneBtn addTarget:self action:@selector(phoneBtnClick) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:phoneBtn];
        [phoneBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(_locationBtn);
            make.right.mas_equalTo(-WScale(15));
        }];
        
    }
    return _locationBtn;
}
//搜索
-(UIView *)searchView
{
    if (!_searchView) {
        _searchView = [[UIView alloc] init];
        [self.view addSubview:_searchView];
        [_searchView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(self.view);
            make.top.mas_equalTo(self.locationBtn.mas_bottom).mas_equalTo(WScale(5));
            make.left.mas_equalTo(0);
            make.height.mas_equalTo(WScale(44));
        }];
        
        UIButton *searchBtn = [UIButton buttonWithTitle:@" 搜索需求" font:kFont(14) titleColor:UIColorFromRGB(0xB4B4B4) backGroundColor:UIColorFromRGB(0xF5F5F5) buttonTag:0 target:self action:@selector(searchBtn) showView:_searchView];
        searchBtn.layer.cornerRadius = WScale(15);
        searchBtn.clipsToBounds = YES;
        [searchBtn setImage:[UIImage imageNamed:@"home_search"] forState:UIControlStateNormal];
        [searchBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.center.mas_equalTo(self.searchView);
            make.left.mas_equalTo(15);
            make.height.mas_equalTo(WScale(30));
        }];
    }
    return _searchView;
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
    [collectionView registerClass:[SHTodayCollectionViewCell class] forCellWithReuseIdentifier:cellID];
    [collectionView registerClass:[SHHotCollectionViewCell class] forCellWithReuseIdentifier:cellID2];
    [collectionView registerClass:[SHHomeHeadCollectionView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:headID];
    [collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:footID];
    [self.view addSubview:collectionView];
    [collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.centerX.mas_equalTo(self.view);
        make.top.mas_equalTo(self.searchView.mas_bottom).mas_equalTo(WScale(7));
        make.bottom.mas_equalTo(0);
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
    if (self.typeTag == 100) {
        return 5;
    }
    return 6;
}
///内容
- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.typeTag == 100)
    {
        SHTodayCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellID forIndexPath:indexPath];
        cell.dict = @{};
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
        SHHomeHeadCollectionView *headView = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:headID forIndexPath:indexPath];
        if (headView == nil) {
            
            headView = [[SHHomeHeadCollectionView alloc] init];
        }
        YBWeakSelf;
        ///今日需求|热门资讯
        [headView setBlock:^(NSInteger tag) {
            weakSelf.typeTag = tag;
            [weakSelf.collectionView reloadData];
        }];
        
        ///生活服务|房产服务|装修建材|促销购|更多需求
        NSArray *titleArray = @[@"生活服务",@"房产服务",@"装修建材",@"促销购"];
        [headView setClassBlock:^(NSInteger tag)
        {
            if (tag == 4) {
                SHMoreNeedViewController *needVC = [[SHMoreNeedViewController alloc] init];
                [weakSelf.navigationController pushViewController:needVC animated:YES];
            }
            else
            {
                SHHomeClassVC *classVC = [[SHHomeClassVC alloc] init];
                classVC.titleStr = titleArray[tag];
                [weakSelf.navigationController pushViewController:classVC animated:YES];
            }
        }];
        
        return headView;
    }
    else if (kind == UICollectionElementKindSectionFooter)
    {
        UICollectionReusableView *footView = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:footID forIndexPath:indexPath];
        footView.backgroundColor = [UIColor whiteColor];
        if (footView == nil) {

            footView = [[UICollectionReusableView alloc] init];
        }
        [footView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
        
        BigClickBT *moreBtn = [[BigClickBT alloc] init];
        [moreBtn setTitle:@"查看更多需求" forState:UIControlStateNormal];
        [moreBtn setTitleColor:ThemeColor forState:UIControlStateNormal];
        moreBtn.titleLabel.font = kFont(13);
        moreBtn.tag = self.typeTag;
        [moreBtn addTarget:self action:@selector(moreBtnClick) forControlEvents:UIControlEventTouchUpInside];
        [footView addSubview:moreBtn];
        [moreBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(footView);
            make.top.mas_equalTo(WScale(10));
        }];
        if (self.typeTag == 100) {
            [moreBtn setTitle:@"查看更多需求" forState:UIControlStateNormal];
        }
        else
        {
            [moreBtn setTitle:@"查看更多资源" forState:UIControlStateNormal];
        }
        
        UILabel *lineLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, WScale(44),kWindowW, WScale(10))];
        lineLabel.backgroundColor = UIColorFromRGB(0xF5F5F5);
        [footView addSubview:lineLabel];
        return footView;
    }
    return nil;
}
///cell的点击事件
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.typeTag == 100) {
        SHHomeDetailVC *detailVC = [[SHHomeDetailVC alloc] init];
        [self.navigationController pushViewController:detailVC animated:YES];
    }
    else
    {
        SHVideoDetailVC *detailVC = [[SHVideoDetailVC alloc] init];
        [self.navigationController pushViewController:detailVC animated:YES];
    }
}

///cell的尺寸大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.typeTag == 100) {
       return CGSizeMake(kWindowW, WScale(266));
    }
    else
    {
        return CGSizeMake(kWindowW/2-WScale(10), WScale(240));
    }
    
}
///每个分区的内边距（上左下右)
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    if (self.typeTag == 100) {
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
    return CGSizeMake(kWindowW,WScale(290));
    
}
/** 区尾大小 */
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section
{
    return CGSizeMake(kWindowW,WScale(54));
    
}

-(SHChangeCityTipView *)tipView
{
    if (!_tipView) {
        _tipView = [[SHChangeCityTipView alloc] init];
    }
    return _tipView;;
}
-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self.navigationController setNavigationBarHidden:NO];
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
