//
//  SHHomeDetailVC.m
//  SharedHome
//
//  Created by 解辉 on 2020/7/31.
//  Copyright © 2020 NaDao. All rights reserved.
//

#import "SHHomeDetailVC.h"
#import "SHHomeDetailCell.h"
#import "SHChatViewController.h"

@interface SHHomeDetailVC ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong)UITableView *tableView;
@property(nonatomic,strong)UIView *bottomView;
@end

@implementation SHHomeDetailVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"需求详情";
    self.view.backgroundColor = WhiteColor;
    [self tableView];
    [self bottomView];
}

#pragma mark *****************  按钮的点击事件
#pragma mark 私信
-(void)chatBtnClick
{
    SHChatViewController *chatVC = [[SHChatViewController alloc] init];
    [self.navigationController pushViewController:chatVC animated:YES];
}

#pragma mark 我要投单
-(void)touBtnClick
{
    
}
#pragma mark *****************  UI

#pragma mark 表的内容
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ///详情
    if (indexPath.section == 0) {
        SHHomeDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SHHomeDetailCell"];
        if (cell == nil)
        {
            cell = [[SHHomeDetailCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"SHHomeDetailCell"];
        }
        cell.dict = @{};
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
    
    //内容
    else if (indexPath.section == 1)
    {
        SHHomeDetailTextCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SHHomeDetailTextCell"];
        if (cell == nil)
        {
            cell = [[SHHomeDetailTextCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"SHHomeDetailTextCell"];
        }
        cell.dict = @{};
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
    
    //提示
    else if (indexPath.section == 2)
    {
        SHHomeDetailTipCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SHHomeDetailTipCell"];
        if (cell == nil)
        {
            cell = [[SHHomeDetailTipCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"SHHomeDetailTipCell"];
        }
        cell.dict = @{};
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
    
    //联系人信息
    SHHomeDetailInfoCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SHHomeDetailInfoCell"];
    if (cell == nil)
    {
        cell = [[SHHomeDetailInfoCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"SHHomeDetailInfoCell"];
    }
    NSArray *titleArray = @[@"联系人：",@"联系电话：",@"地址："];
    NSArray *contentArray = @[@"**山",@"135****2541",@"江苏省苏州市姑苏区*****************"];
    cell.dict = @{};
    cell.titleLabel.text = titleArray[indexPath.row];
    cell.contentLabel.text = contentArray[indexPath.row];
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
    if (section == 0 ||section == 1 ||section == 2)
    {
        return 1;
    }
    else
    {
        return 3;
    }
}
// 表的行高
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0)
    {
        return WScale(350);
    }
    else  if (indexPath.section == 1)
    {
        return  WScale(120);
    }
    else  if (indexPath.section == 2)
    {
        return  WScale(35);
    }
    else
    {
        return WScale(43);
    }
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
    
}
///表
-(UITableView *)tableView
{
    if (_tableView == nil)
    {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0,SafeAreaTopHeight, kWindowW, kWindowH-SafeAreaTopHeight-SafeAreaBottomHeight-WScale(50)) style:UITableViewStyleGrouped];
        _tableView.delegate = self;
        _tableView.dataSource = self;
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
        [_tableView registerClass:[SHHomeDetailCell class] forCellReuseIdentifier:@"SHHomeDetailCell"];
        [_tableView registerClass:[SHHomeDetailTextCell class] forCellReuseIdentifier:@"SHHomeDetailTextCell"];
        [_tableView registerClass:[SHHomeDetailTipCell class] forCellReuseIdentifier:@"SHHomeDetailTipCell"];
        [_tableView registerClass:[SHHomeDetailInfoCell class] forCellReuseIdentifier:@"SHHomeDetailInfoCell"];
        [self.view addSubview:_tableView];
    }
    return _tableView;
}
#pragma mark 底部视图
-(UIView *)bottomView
{
    if (!_bottomView) {
        _bottomView = [[UIView alloc] init];
        [self.view addSubview:_bottomView];
        [_bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(self.view);
            make.left.bottom.mas_equalTo(0);
            make.height.mas_equalTo(SafeAreaBottomHeight+WScale(50));
        }];
        
        UIButton *chatBtn = [UIButton buttonWithTitle:@" 发私信" font:kFont(15) titleColor:UIColorFromRGB(0x333333) backGroundColor:ClearColor buttonTag:0 target:self action:@selector(chatBtnClick) showView:_bottomView];
        [chatBtn setImage:[UIImage imageNamed:@"home_chat"] forState:UIControlStateNormal];
        [chatBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.top.mas_equalTo(0);
            make.height.mas_equalTo(WScale(50));
            make.width.mas_equalTo(WScale(125));
        }];
        
        UIButton *touBtn = [UIButton buttonWithTitle:@"我要投单" font:kFont(15) titleColor:WhiteColor backGroundColor:ThemeColor buttonTag:0 target:self action:@selector(touBtnClick) showView:_bottomView];
        [touBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.top.mas_equalTo(0);
            make.height.mas_equalTo(WScale(50));
            make.left.mas_equalTo(chatBtn.mas_right);
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
