//
//  SHMoreNeedViewController.m
//  SharedHome
//
//  Created by 解辉 on 2020/7/31.
//  Copyright © 2020 NaDao. All rights reserved.
//

#import "SHMoreNeedViewController.h"
#import "SHMoreCollectionViewCell.h"
#import "SHHomeClassVC.h"
static NSString *const cellID = @"SHMoreCollectionViewCell";

@interface SHMoreNeedViewController ()<UICollectionViewDelegate,UICollectionViewDataSource>

@property(nonatomic,strong) NSArray *imgArray;
@property(nonatomic,strong) NSArray *titleArray;
@property(nonatomic,strong) UICollectionView *collectionView;

@end

@implementation SHMoreNeedViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"更多需求";
    self.view.backgroundColor = WhiteColor;
    
    self.imgArray = @[@"home_type_sheng",@"home_type_fang",@"home_type_zhuang",@"home_type_cu",@"home_type_hui",@"home_type_yi",@"home_type_shang",@"home_type_wen",@"home_type_qi",@"home_type_hun",@"home_type_party",@"home_type_jiao",@"home_type_tu",@"home_type_fa",@"home_type_jin",@"home_type_xue",@"home_type_shen",@"home_type_zhao",@"home_type_hua",@"home_type_guo",@"home_type_yang",@"home_type_gong",@"home_type_hu",@"home_type_yiYao",@"home_type_ju",@"home_type_chang",@"home_type_other"];
    self.titleArray = @[@"生活服务",@"房产服务",@"装修建材",@"促销购",@"惠预定",@"异/同城互助",@"商务服务",@"文书服务",@"汽车服务",@"婚纱摄影",@"party必备",@"教育培训",@"图文广告",@"法律服务",@"金融保险",@"学手艺",@"深度旅游",@"招商投资",@"花草宠物",@"过户公证服务",@"养生保健",@"工装服务",@"互联网服务",@"医药服务",@"俱乐部",@"厂家货源",@"其他"];
    [self setCollectionView];
}

#pragma mark *****************  按钮的点击事件


#pragma mark *****************  UI

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
    
    [collectionView registerClass:[SHMoreCollectionViewCell class] forCellWithReuseIdentifier:cellID];
    [self.view addSubview:collectionView];
    [collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.centerX.mas_equalTo(self.view);
        make.top.mas_equalTo(WScale(14)+SafeAreaTopHeight);
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
    return self.titleArray.count;
}
///内容
- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    SHMoreCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellID forIndexPath:indexPath];
    cell.iconImg.image = [UIImage imageNamed:self.imgArray[indexPath.item]];
    cell.titleLabel.text = self.titleArray[indexPath.item];
    return cell;
}

///cell的点击事件
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    SHHomeClassVC *classVC = [[SHHomeClassVC alloc] init];
    classVC.titleStr = self.titleArray[indexPath.item];
    [self.navigationController pushViewController:classVC animated:YES];
}

///cell的尺寸大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
     return CGSizeMake(kWindowW/4-WScale(20), WScale(90));
    
}
///每个分区的内边距（上左下右)
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(0,WScale(10),0,WScale(10));
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
