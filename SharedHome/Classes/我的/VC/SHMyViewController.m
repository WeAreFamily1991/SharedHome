//
//  SHMyViewController.m
//  SharedHome
//
//  Created by 解辉 on 2020/7/27.
//  Copyright © 2020 NaDao. All rights reserved.
//

#import "SHMyViewController.h"
#import "SHMyInfoTableViewCell.h"
#import "SHShopInfoVC.h"

@interface SHMyViewController ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong)UITableView *tableView;
@property(nonatomic,strong)NSArray *listArray;
@end

@implementation SHMyViewController

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    if (![Save isLogin]) {
        [CommonMethod tipLoginFromController:self finish:nil];
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"个人中心";
    
    self.listArray = @[@[@""],
                       @[@"我发布的短视频",@"我的消息"],
                       @[@"我发布的需求",@"我的地址",@"我的需求订单"],
                       @[@"",@"我的服务订单",@"我投的单",@"我要入驻"],
                       ];
    [self.tableView reloadData];
}

#pragma mark 表的内容
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0)
    {
        SHMyInfoTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SHMyInfoTableViewCell"];
        if (cell == nil)
        {
            cell = [[SHMyInfoTableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"SHMyInfoTableViewCell"];
        }
        cell.dict = @{};
        cell.rootVC = self;
        cell.typeArray = @[@"服务商",@"已认证",@"24小时服务"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
    else if (indexPath.section == 3 && indexPath.row == 0)
    {
        SHMyIfGetDanCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SHMyIfGetDanCell"];
        if (cell == nil)
        {
            cell = [[SHMyIfGetDanCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"SHMyIfGetDanCell"];
        }
        cell.dict = @{};
        cell.rootVC = self;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
    SHMyClassTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SHMyClassTableViewCell"];
    if (cell == nil)
    {
        cell = [[SHMyClassTableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"SHMyClassTableViewCell"];
    }
    cell.dict = @{};
    cell.rootVC = self;
    
    NSArray *array = self.listArray[indexPath.section];
    cell.titleLabel.text = array[indexPath.row];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}
// 表的区数
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 4;
}
// 表的行数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0)
    {
        return 1;
    }
    else
    {
        NSArray *array = self.listArray[section];
        return array.count;
    }
}
// 表的行高
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0)
    {
        return WScale(210);
    }
    else  if (indexPath.section == 3 && indexPath.row == 0)
    {
        return  WScale(65);
    }
    else
    {
        return WScale(44);
    }
}
//区头的高度
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 0 || section == 1) {
        return 0.01;
    }
    else
    {
        return WScale(50);
    }
}
//区尾的高度
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    if (section == 0 || section == 3) {
        return WScale(8);
    }
    return 0.01;
}
///区头的内容
- (nullable UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (section == 0 && section == 1) {
        return nil;
    }
    else
    {
        NSArray *array = @[@"",@"",@"我是需求方",@"我是服务商"];
        UIView *headView = [[UIView alloc] init];
        
        UILabel *titleLabel = [UILabel labelWithText:array[section] font:kFont(15) textColor:ThemeColor backGroundColor:ClearColor superView:headView];
        [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(headView);
            make.left.mas_equalTo(WScale(15));
        }];
        return headView;
    }
}
///区尾的内容
- (nullable UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIView *footView = [[UIView alloc] init];
    footView.backgroundColor = UIColorFromRGB(0xF5F5F5);
    return footView;
}

///cell的点击事件
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 1)
    {
        
    }
    else if (indexPath.section == 2)
    {
        
    }
    else if (indexPath.section == 3)
    {
        if (indexPath.row == 1)
        {
            
        }
        else if (indexPath.row == 2)
        {
            
        }
        ///我要入驻
        else if (indexPath.row == 3)
        {
            SHShopInfoVC *shopInfoVC = [[SHShopInfoVC alloc] init];
            [self.navigationController pushViewController:shopInfoVC animated:YES];
        }
    }
}
///表
-(UITableView *)tableView
{
    if (_tableView == nil)
    {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0,SafeAreaTopHeight, kWindowW, kWindowH-SafeAreaTopHeight-SafeAreaBottomHeight-49) style:UITableViewStyleGrouped];
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
        [_tableView registerClass:[SHMyInfoTableViewCell class] forCellReuseIdentifier:@"SHMyInfoTableViewCell"];
        [_tableView registerClass:[SHMyClassTableViewCell class] forCellReuseIdentifier:@"SHMyClassTableViewCell"];
        [_tableView registerClass:[SHMyIfGetDanCell class] forCellReuseIdentifier:@"SHMyIfGetDanCell"];
        [self.view addSubview:_tableView];
    }
    return _tableView;
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
