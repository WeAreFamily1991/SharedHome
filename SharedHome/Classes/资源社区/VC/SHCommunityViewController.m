//
//  SHCommunityViewController.m
//  SharedHome
//
//  Created by 解辉 on 2020/7/27.
//  Copyright © 2020 NaDao. All rights reserved.
//

#import "SHCommunityViewController.h"
#import "SHHotCollectionViewCell.h"
#import "SHVideoDetailVC.h"

static NSString *const cellID2 =@"SHHotCollectionViewCell";

@interface SHCommunityViewController ()<UICollectionViewDelegate,UICollectionViewDataSource>

@property(nonatomic,strong) UIScrollView *typeScrollView;
@property(nonatomic,strong) NSArray *titleArray;
@property(nonatomic,assign) NSInteger typeTag;
@property(nonatomic,strong) UICollectionView *collectionView;

@end

@implementation SHCommunityViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.typeTag = 100;
    [self typeScrollView];
    [self setCollectionView];
}

#pragma mark ************* 按钮的点击事件
#pragma mark 类型
-(void)typeBtnClick:(UIButton *)button
{
    for (int i = 0; i<self.titleArray.count; i++) {
        if (button.tag == 100+i) {
            button.selected = YES;
            button.layer.borderColor = ClearColor.CGColor;
            continue;
        }
        UIButton *btn = (UIButton *)[self.view viewWithTag:100+i];
        btn.selected = NO;
        btn.layer.borderColor = UIColorFromRGB(0xC8C8C8).CGColor;
    }
    
    self.typeTag = button.tag;
}

#pragma mark ************* UI
-(UIScrollView *)typeScrollView
{
    if (!_typeScrollView) {
        _typeScrollView = [[UIScrollView alloc] init];
        _typeScrollView.frame = CGRectMake(0, SafeAreaTopHeight, kWindowW, WScale(44));
        _typeScrollView.showsVerticalScrollIndicator = NO;
        _typeScrollView.showsHorizontalScrollIndicator = NO;
        [self.view addSubview:_typeScrollView];
        
        self.titleArray = @[@"生活服务",@"装修建材",@"房产服务",@"商务服务",@"教育培训"];
        float x = WScale(15);
        for (int i = 0; i<self.titleArray.count; i++) {
            
            CGSize size = [NSString sizeWithText:self.titleArray[i] font:kFont(13) maxSize:CGSizeMake(WScale(100), WScale(30))];
            float width = size.width+WScale(20);
            
            UIButton *typeBtn = [UIButton buttonWithTitle:self.titleArray[i] font:kFont(13) titleColor:UIColorFromRGB(0x333333) backGroundColor:ClearColor buttonTag:i+100 target:self action:@selector(typeBtnClick:) showView:_typeScrollView];
            typeBtn.layer.cornerRadius = WScale(4);
            typeBtn.clipsToBounds = YES;
            typeBtn.layer.borderWidth = 1;
            typeBtn.layer.borderColor = UIColorFromRGB(0xC8C8C8).CGColor;
            [typeBtn setTitleColor:WhiteColor forState:UIControlStateSelected];
            [typeBtn setBackgroundImage:[UIImage imageWithColor:ClearColor] forState:UIControlStateNormal];
            [typeBtn setBackgroundImage:[UIImage imageWithColor:ThemeColor] forState:UIControlStateSelected];
            [typeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
                make.centerY.mas_equalTo(_typeScrollView);
                make.left.mas_equalTo(x);
                make.width.mas_equalTo(width);
                make.height.mas_equalTo(WScale(30));
            }];
            x = x+width+WScale(10);
            
            if (i == 0) {
                typeBtn.selected = YES;
                typeBtn.layer.borderColor = ClearColor.CGColor;
            }
        }
        
        _typeScrollView.contentSize = CGSizeMake(x+WScale(15), WScale(30));
    }
    return _typeScrollView;
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
    
    [collectionView registerClass:[SHHotCollectionViewCell class] forCellWithReuseIdentifier:cellID2];
    [self.view addSubview:collectionView];
    [collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.centerX.mas_equalTo(self.view);
        make.top.mas_equalTo(WScale(44)+SafeAreaTopHeight);
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
    return 6;
}
///内容
- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    SHHotCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellID2 forIndexPath:indexPath];
    cell.dict = @{};
    cell.rootVC = self;
    return cell;
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
     return CGSizeMake(kWindowW/2-WScale(10), WScale(240));
    
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
