//
//  SHHomeSearchVC.m
//  SharedHome
//
//  Created by 解辉 on 2020/7/29.
//  Copyright © 2020 NaDao. All rights reserved.
//

#import "SHHomeSearchVC.h"
#import "SHTodayCollectionViewCell.h"
#import "SHHomeDetailVC.h"

static NSString *const cellID = @"SHTodayCollectionViewCell";

@interface SHHomeSearchVC ()<UITextFieldDelegate,UICollectionViewDelegate,UICollectionViewDataSource>

@property(nonatomic,strong) UITextField *searchTF;
@property(nonatomic,strong) UICollectionView *collectionView;
@property(nonatomic,strong)UIView *emptyView;
@end

@implementation SHHomeSearchVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = UIColorFromRGB(0xF5F5F5);
    [self setNavView];
    [self setCollectionView];
    self.collectionView.hidden = YES;
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES];
}

#pragma mark *****************  按钮的点击事件
#pragma mark 返回
-(void)backBtnClick
{
    [self.navigationController popViewControllerAnimated:YES];
}
#pragma mark ************************  代理
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
//    self.page = 1;
    [_searchTF resignFirstResponder];
    if (textField.text.length == 0) {

        [[YZMBPManager sharedMBPManager] showHUDWithText:@"搜索内容不能为空"];
        return NO;
    }
//    [self httpWithSearch];
    
  //  self.emptyView.hidden = NO;
    self.collectionView.hidden = NO;
    return YES;
}
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    return YES;
}
-(void)textFieldChangeAction:(UITextField *)textField
{
    if (textField.text.length == 0) {
       // self.emptyView.hidden = YES;
        self.collectionView.hidden = YES;
    }
}

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
    
    [collectionView registerClass:[SHTodayCollectionViewCell class] forCellWithReuseIdentifier:cellID];
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
    return 2;
}
///内容
- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    SHTodayCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellID forIndexPath:indexPath];
    cell.dict = @{};
    return cell;
}

///cell的点击事件
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    SHHomeDetailVC *detailVC = [[SHHomeDetailVC alloc] init];
    [self.navigationController pushViewController:detailVC animated:YES];
}

///cell的尺寸大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
     return CGSizeMake(kWindowW, WScale(266));
    
}
///每个分区的内边距（上左下右)
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(0,0,0,0);
}

#pragma mark 导航栏
-(void)setNavView
{
    UIView *topView = [[UIView alloc] init];
    topView.backgroundColor = WhiteColor;
    [self.view addSubview:topView];
    [topView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.view);
        make.left.top.mas_equalTo(0);
        make.height.mas_equalTo(WScale(6)+SafeAreaTopHeight);
    }];
    
    UITextField *searchTF = [[UITextField alloc] init];
    [searchTF becomeFirstResponder];
    searchTF.backgroundColor = UIColorFromRGB(0xF5F5F5);
    searchTF.textColor = BlackNameColor;
    searchTF.delegate = self;
    searchTF.font = kFont(14);
    searchTF.layer.cornerRadius = WScale(15);
    searchTF.clipsToBounds = YES;
    searchTF.placeholder = @"输入需求标题或描述关键字搜索";
    if (@available(iOS 13.0, *)) {
        searchTF.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"输入需求标题或描述关键字搜索" attributes:@{NSFontAttributeName:kFont(14),NSForegroundColorAttributeName:UIColorFromRGB(0xB4B4B4)}];
    }
    else
    {
        [searchTF setValue:UIColorFromRGB(0xB4B4B4) forKeyPath:@"_placeholderLabel.textColor"];
        [searchTF setValue:kFont(14) forKeyPath:@"_placeholderLabel.font"];
    }
    searchTF.leftViewMode = UITextFieldViewModeAlways;
    
    UIView *leftView = [[UIView alloc] initWithFrame:CGRectMake(WScale(5), 0, WScale(35), WScale(30))];
    UIImageView *img = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"home_search"]];
    [leftView addSubview:img];
    img.center = leftView.center;
    
    searchTF.leftView = leftView;
    searchTF.returnKeyType = UIReturnKeySearch;
    [searchTF addTarget:self action:@selector(textFieldChangeAction:)   forControlEvents:UIControlEventEditingChanged];
    [topView addSubview:searchTF];
    [searchTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(-WScale(10));
        make.left.mas_equalTo(WScale(15));
        make.right.mas_equalTo(WScale(-60));
        make.height.mas_equalTo(30);
    }];
    _searchTF = searchTF;
    
    BigClickBT *backBtn = [[BigClickBT alloc] init];
    [backBtn setTitle:@"取消" forState:UIControlStateNormal];
    [backBtn setTitleColor:UIColorFromRGB(0x333333) forState:UIControlStateNormal];
    backBtn.titleLabel.font = kFont(15);
    [backBtn addTarget:self action:@selector(backBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [topView addSubview:backBtn];
    [backBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(searchTF);
        make.right.mas_equalTo(WScale(-15));
    }];
}

///空页面
-(UIView *)emptyView
{
    if (!_emptyView) {
        _emptyView = [[UIView alloc] initWithFrame:CGRectMake(0, SafeAreaTopHeight+WScale(6), kWindowW,kWindowH-SafeAreaBottomHeight-SafeAreaTopHeight-WScale(6))];
        [self.view addSubview:_emptyView];
        
        UIImageView *iconImg = [[UIImageView alloc] init];
        iconImg.image = [UIImage imageNamed:@"empty_icon"];
        [_emptyView addSubview:iconImg];
        
        UILabel *tipLabel = [UILabel labelWithText:@"抱歉！暂无相关结果" font:kFont(14) textColor:UIColorFromRGB(0xB4B4B4) backGroundColor:ClearColor superView:_emptyView];
        tipLabel.textAlignment = NSTextAlignmentCenter;
        
        [iconImg mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(self.view);
            make.top.mas_equalTo(HScale(194));
        }];
        [tipLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(self.view);
            make.top.mas_equalTo(iconImg.mas_bottom).mas_equalTo(HScale(20));
        }];
    }
    return _emptyView;
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}
-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self.navigationController setNavigationBarHidden:NO];
    [self.view endEditing:YES];
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
