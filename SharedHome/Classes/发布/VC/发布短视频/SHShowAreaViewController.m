//
//  SHShowAreaViewController.m
//  SharedHome
//
//  Created by 解辉 on 2020/8/5.
//  Copyright © 2020 NaDao. All rights reserved.
//

#import "SHShowAreaViewController.h"
#import "SHSortsTableViewCell.h"

@interface SHShowAreaViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) UITableView *leftTableView;
@property (nonatomic,strong) UITableView *rightTableView;
@property (nonatomic,strong) UIView *bottomView;
@property (nonatomic,strong) NSArray *leftArray;
@property (nonatomic,strong) NSArray *rightArray;
@property (nonatomic,copy) NSString *currentCity;
@end

@implementation SHShowAreaViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = WhiteColor;
    self.title = @"选择视频展示区";
    [self bottomView];
    
    self.leftArray = @[@"上海市",@"苏州市"];
    self.rightArray = @[@"姑苏区",@"虎丘区",@"吴中区",@"相城区",@"吴江区",@"常熟市"];
    
    self.currentCity = self.leftArray[0];
    
    if (self.selectDict.allKeys.count == 0) {
        self.selectDict = [[NSMutableDictionary alloc] init];
        
        for (NSString *city in self.leftArray)
        {
            NSMutableArray *array = [[NSMutableArray alloc] init];
            [self.selectDict setValue:array forKey:city];
        }
    }
    
    [self.leftTableView reloadData];
    [self.rightTableView reloadData];
}

#pragma mark ************* 按钮的点击事件
//重置
-(void)resetBtnClick
{
   // self.currentCity = self.leftArray[0];
    self.selectDict = [[NSMutableDictionary alloc] init];
    
    for (NSString *city in self.leftArray)
    {
        NSMutableArray *array = [[NSMutableArray alloc] init];
        [self.selectDict setValue:array forKey:city];
    }
    [self.leftTableView reloadData];
    [self.rightTableView reloadData];
}

//确定
-(void)sureBtnClick
{
    if (self.SelectArea) {
        self.SelectArea(self.selectDict);
    }
    [self.navigationController popViewControllerAnimated:YES];
}


#pragma mark ************* UI

#pragma mark 表的内容
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    SHSortsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SHSortsTableViewCell"];
    if (cell == nil)
    {
        cell = [[SHSortsTableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"SHSortsTableViewCell"];
    }
    [cell.titleLabel mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(WScale(25));
    }];
    if (tableView.tag == 0)
    {
        cell.titleLabel.text = self.leftArray[indexPath.row];
        if ([cell.titleLabel.text isEqualToString:self.currentCity]) {
            cell.titleLabel.textColor = ThemeColor;
        }
        else
        {
            cell.titleLabel.textColor = UIColorFromRGB(0x333333);
        }
    }
    else
    {
        cell.titleLabel.text = self.rightArray[indexPath.row];
        NSString *title = self.rightArray[indexPath.row];
        NSMutableArray *selectArray = self.selectDict[self.currentCity];
        if ([selectArray containsObject:title])
        {
            cell.titleLabel.textColor = ThemeColor;
            cell.selectImgView.hidden = NO;
        }
        else
        {
            cell.titleLabel.textColor = UIColorFromRGB(0x333333);
            cell.selectImgView.hidden = YES;
        }
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}
// 表的区数
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
// 表的行数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView.tag == 0)
    {
        return self.leftArray.count;
    }
    else
    {
        return self.rightArray.count;
    }
}
// 表的行高
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return WScale(45);
}
//区头的高度
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0.01;
}
//区尾的高度
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.01;
}
///区头的内容
- (nullable UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    return nil;
}
///区尾的内容
- (nullable UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    return nil;
}

///cell的点击事件
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView.tag == 0)
    {
        self.currentCity = self.leftArray[indexPath.row];
    }
    else
    {
        NSString *title = self.rightArray[indexPath.row];
        NSMutableArray *selectArray = self.selectDict[self.currentCity];
        if ([selectArray containsObject:title])
        {
            [selectArray removeObject:title];
        }
        else
        {
            [selectArray addObject:title];
        }
    }
    [self.leftTableView reloadData];
    [self.rightTableView reloadData];
}
///表
-(UITableView *)leftTableView
{
    if (_leftTableView == nil)
    {
        _leftTableView = [[UITableView alloc] initWithFrame:CGRectMake(0,SafeAreaTopHeight,WScale(130), kWindowH-SafeAreaTopHeight-SafeAreaBottomHeight-WScale(50)) style:UITableViewStyleGrouped];
        _leftTableView.delegate = self;
        _leftTableView.dataSource = self;
        _leftTableView.tag = 0;
        _leftTableView.separatorColor = ClearColor;
        _leftTableView.backgroundColor = WhiteColor;
        _leftTableView.showsVerticalScrollIndicator = NO;
        if (@available(iOS 11.0, *)) {
            
            _leftTableView.estimatedRowHeight = 0;
            
            _leftTableView.estimatedSectionHeaderHeight = 0;
            
            _leftTableView.estimatedSectionFooterHeight = 0;
            self.leftTableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        }
        else
        {
            self.automaticallyAdjustsScrollViewInsets = NO;
        }
        [_leftTableView registerClass:[SHSortsTableViewCell class] forCellReuseIdentifier:@"SHSortsTableViewCell"];
        [self.view addSubview:_leftTableView];
    }
    return _leftTableView;
}

-(UITableView *)rightTableView
{
    if (_rightTableView == nil)
    {
        _rightTableView = [[UITableView alloc] initWithFrame:CGRectMake(WScale(130),SafeAreaTopHeight,kWindowW-WScale(130), kWindowH-SafeAreaTopHeight-SafeAreaBottomHeight-WScale(50)) style:UITableViewStyleGrouped];
        _rightTableView.delegate = self;
        _rightTableView.dataSource = self;
        _rightTableView.tag = 1;
        _rightTableView.separatorColor = ClearColor;
        _rightTableView.backgroundColor = WhiteColor;
        _rightTableView.showsVerticalScrollIndicator = NO;
        if (@available(iOS 11.0, *)) {
            
            _rightTableView.estimatedRowHeight = 0;
            
            _rightTableView.estimatedSectionHeaderHeight = 0;
            
            _rightTableView.estimatedSectionFooterHeight = 0;
            self.rightTableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        }
        else
        {
            self.automaticallyAdjustsScrollViewInsets = NO;
        }
         [_rightTableView registerClass:[SHSortsTableViewCell class] forCellReuseIdentifier:@"SHSortsTableViewCell"];
        [self.view addSubview:_rightTableView];
        
        UILabel *lineLabel = [[UILabel alloc] initWithFrame:CGRectMake(0,0,1,kWindowH-SafeAreaTopHeight-SafeAreaBottomHeight-WScale(50))];
        lineLabel.backgroundColor = UIColorFromRGB(0xEBEBEB);
        [_rightTableView addSubview:lineLabel];
    }
    return _rightTableView;
}
#pragma mark 底部视图
-(UIView *)bottomView
{
    if (!_bottomView) {
        _bottomView = [[UIView alloc] init];
        [self.view addSubview:_bottomView];
        [_bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.mas_equalTo(0);
            make.bottom.mas_equalTo(-SafeAreaBottomHeight);
            make.height.mas_equalTo(WScale(50));
        }];
        
        ///重置
        UIButton *resetBtn = [UIButton buttonWithTitle:@"重置" font:kFont(15) titleColor:UIColorFromRGB(0x333333) backGroundColor:WhiteColor buttonTag:0 target:self action:@selector(resetBtnClick) showView:self.bottomView];
        [resetBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.bottom.left.mas_equalTo(0);
            make.width.mas_equalTo(kWindowW/2);
        }];
        
        ///确定
        UIButton *sureBtn = [UIButton buttonWithTitle:@"确定" font:kFont(15) titleColor:WhiteColor backGroundColor:ThemeColor buttonTag:0 target:self action:@selector(sureBtnClick) showView:self.bottomView];
        [sureBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.bottom.right.mas_equalTo(0);
            make.width.mas_equalTo(kWindowW/2);
        }];
    }
    return _bottomView;
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
