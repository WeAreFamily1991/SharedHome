//
//  SHSelectSortsVC.m
//  SharedHome
//
//  Created by 解辉 on 2020/8/4.
//  Copyright © 2020 NaDao. All rights reserved.
//

#import "SHSelectSortsVC.h"
#import "SHSortsTableViewCell.h"

@interface SHSelectSortsVC ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong)UITableView *tableView;
@property(nonatomic,strong)NSArray *listArray;

@end

@implementation SHSelectSortsVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = WhiteColor;
    self.title = @"选择类别";
    self.listArray = @[@"生活服务",@"房产服务",@"装修建材"];
    
    if (self.selectArray.count ==0) {
        self.selectArray = [[NSMutableArray alloc] init];
    }
    
    [self setupRightNavItem];
    [self.tableView reloadData];
}

#pragma mark **************** 按钮的点击事件
//确定
-(void)SureClick
{
    if (self.SelectSort) {
        self.SelectSort(self.selectArray);
    }
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark **************** UI
#pragma mark 表的内容
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    SHSortsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SHSortsTableViewCell"];
    if (cell == nil)
    {
        cell = [[SHSortsTableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"SHSortsTableViewCell"];
    }
    
    NSString *title = self.listArray[indexPath.row];
    cell.titleLabel.text = title;
    
    if ([self.selectArray containsObject:title]) {
        cell.titleLabel.textColor = ThemeColor;
        cell.selectImgView.hidden = NO;
    }
    else
    {
        cell.titleLabel.textColor = UIColorFromRGB(0x333333);
        cell.selectImgView.hidden = YES;
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
    return self.listArray.count;
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
    NSString *title = self.listArray[indexPath.row];
    if ([self.selectArray containsObject:title]) {
        [self.selectArray removeObject:title];
    }
    else
    {
        [self.selectArray addObject:title];
    }
    [self.tableView reloadData];
}
///表
-(UITableView *)tableView
{
    if (_tableView == nil)
    {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0,SafeAreaTopHeight, kWindowW, kWindowH-SafeAreaTopHeight-SafeAreaBottomHeight) style:UITableViewStyleGrouped];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.backgroundColor = WhiteColor;
        _tableView.separatorColor = ClearColor;
        _tableView.showsVerticalScrollIndicator = NO;
        if (@available(iOS 11.0, *)) {
            
            _tableView.estimatedRowHeight = 0;
            
            _tableView.estimatedSectionHeaderHeight = 0;
            
            _tableView.estimatedSectionFooterHeight = 0;
            self.tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        }
        else
        {
            self.automaticallyAdjustsScrollViewInsets = NO;
        }
        [_tableView registerClass:[SHSortsTableViewCell class] forCellReuseIdentifier:@"SHSortsTableViewCell"];
        [self.view addSubview:_tableView];
    }
    return _tableView;
}
- (void)setupRightNavItem
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(0, 0, WScale(80), 44);
    [button setTitle:@"确定" forState:UIControlStateNormal];
    [button setTitleColor:ThemeColor forState:UIControlStateNormal];
    button.titleLabel.font = kFont(15);
    [button addTarget:self action:@selector(SureClick) forControlEvents:UIControlEventTouchUpInside];
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
