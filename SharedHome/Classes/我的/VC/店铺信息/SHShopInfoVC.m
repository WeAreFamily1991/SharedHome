//
//  SHShopInfoVC.m
//  SharedHome
//
//  Created by 解辉 on 2020/8/6.
//  Copyright © 2020 NaDao. All rights reserved.
//

#import "SHShopInfoVC.h"
#import "SHShopInfoCell.h"
#import <TZImagePickerController/TZImagePickerController.h>
#import "SHShopTypeSelectView.h"

@interface SHShopInfoVC ()<UITableViewDelegate,UITableViewDataSource,TZImagePickerControllerDelegate>
{
    NSString *selectType; ///<服务商类型
    NSString *serviceName;    ///<服务商名称
    NSString *numStr;     ///<营业执照编号
    NSString *areaStr;    ///<所在区域
    NSString *addressStr; ///<详细地址
    NSString *rangeStr;   ///<服务范围
    
    NSString *nameStr;    ///<技能达人 - 姓名
    
    UIImage *numImg;  ///<营业执照照片
    UIImage *logoImg; ///<logo照片
    UIImage *cerImg;  ///<技能证书照片
    UIImage *headImg; ///<个人头像
    UIImage *IDZhengImg; ///<身份证正面照
    UIImage *IDFanImg;   ///<身份证反面照
    
    NSString *numImgStr;
    NSString *logoImgStr;
    NSString *cerImgStr;
    NSString *headImgStr;
    NSString *IDZhengStr;
    NSString *IDFanStr;
}
@property(nonatomic,assign)NSInteger typeTag; ///<0:服务商   1:技能达人
@property(nonatomic,strong)UITableView *tableView;

@property(nonatomic,strong)NSArray *listArray;
@property(nonatomic,strong)NSArray *listArray2;

@property(nonatomic,strong)NSMutableArray *contentArray;
@property(nonatomic,strong)NSMutableArray *contentArray2;

@property(nonatomic,strong)NSArray *placeholdArray;
@property(nonatomic,strong)NSArray *placeholdArray2;

@property(nonatomic,assign)NSInteger photoNum;
@property(nonatomic,assign)NSInteger photoIndex; ///<0:营业执照  1:logo   2:技能证书  3:个人头像  4:门头照片  5:身份证正面照   6:身份证反面照

@property(nonatomic,strong)NSMutableArray *doorArray;
@property(nonatomic,strong)UIView *footView;

@property(nonatomic,strong)SHShopTypeSelectView *typeSelectView;
@end

@implementation SHShopInfoVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = WhiteColor;
    self.title = @"店铺信息";
    
    self.typeTag = 0;
    selectType = @"服务商";
    
    ///标题
    self.listArray = @[@"服务商类型",@"服务商名称",@"营业执照编号",@"所在区域",@"详细地址",@"服务范围"];
    self.listArray2 = @[@"服务商类型",@"姓名",@"所在区域",@"详细地址",@"服务范围"];
    
    [self relodArrayData];
    
    //提示语
    self.placeholdArray = @[@"",@"请输入营业执照上的企业名称",@"请输入营业执照号码",@"请选择区域",@"请选择详细地址",@"请选择服务范围"];
    self.placeholdArray2 = @[@"",@"请输入身份证上的姓名",@"请选择区域",@"请选择详细地址",@"请选择服务范围"];
    
    self.doorArray = [[NSMutableArray alloc] init];
    
    [self.tableView reloadData];
}

-(void)relodArrayData
{
    //内容
    self.contentArray = @[selectType?:@"",serviceName?:@"",numStr?:@"",areaStr?:@"",addressStr?:@"",rangeStr?:@""].mutableCopy;
    self.contentArray2 = @[selectType?:@"",nameStr?:@"",areaStr?:@"",addressStr?:@"",rangeStr?:@""].mutableCopy;
    
}
#pragma mark ************ 按钮的点击事件
//确认提交
-(void)publicBtnClick
{
    
}

-(void)textFieldChangeAction:(UITextField *)textField
{
    if (textField.tag == 1) {
        serviceName = textField.text;
    }
    else if (textField.tag == 2)
    {
        numStr = textField.text;
    }
    else if (textField.tag == 101)
    {
        nameStr = textField.text;
    }
}

#pragma mark 表的内容
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ///店铺信息
    if (indexPath.section == 0) {
        
        SHShopInfoCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SHShopInfoCell"];
        if (cell == nil)
        {
            cell = [[SHShopInfoCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"SHShopInfoCell"];
        }
        if (self.typeTag == 0) {
            cell.infoTF.tag = indexPath.row;
            cell.titleLabel.text = self.listArray[indexPath.row];
            cell.infoTF.text = self.contentArray[indexPath.row];
            cell.infoTF.placeholder  = self.placeholdArray[indexPath.row];
            
            if (indexPath.row == 1 || indexPath.row == 2) {
                cell.arrowImg.hidden = YES;
                cell.infoTF.userInteractionEnabled = YES;
            }
            else
            {
                cell.arrowImg.hidden = NO;
                cell.infoTF.userInteractionEnabled = NO;
            }
        }
        else
        {
            cell.infoTF.tag = 100+indexPath.row;
            cell.titleLabel.text = self.listArray2[indexPath.row];
            cell.infoTF.text = self.contentArray2[indexPath.row];
            cell.infoTF.placeholder  = self.placeholdArray2[indexPath.row];
            
            cell.arrowImg.hidden = indexPath.row == 1?(YES):(NO);
            cell.infoTF.userInteractionEnabled = indexPath.row == 1?(YES):(NO);
        }
        [cell.infoTF addTarget:self action:@selector(textFieldChangeAction:)   forControlEvents:UIControlEventEditingChanged];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
    //营业执照 | logo | 技能证书 | 个人头像
    else if (indexPath.section == 1  || indexPath.section == 3)
    {
        SHShopInfoPhotoCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SHShopInfoPhotoCell"];
        if (cell == nil)
        {
            cell = [[SHShopInfoPhotoCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"SHShopInfoPhotoCell"];
        }
        cell.dict = @{};
        cell.selectType = self.typeTag;
        cell.section = indexPath.section;
        
        NSString *title;
        if (self.typeTag == 0) {
            title = indexPath.section == 1?(@"营业执照"):(@"logo");
            
            ///营业执照
            if (indexPath.section == 1)
            {
                UIImage *currentImg = numImgStr.length >0?(numImg):([UIImage imageNamed:@"addpic"]);
                [cell.photoBtn setImage:currentImg forState:UIControlStateNormal];
            }
            ///logo
            else
            {
                UIImage *currentImg = logoImgStr.length >0?(logoImg):([UIImage imageNamed:@"addpic"]);
                [cell.photoBtn setImage:currentImg forState:UIControlStateNormal];
            }
        }
        else
        {
            title = indexPath.section == 1?(@"技能证书"):(@"个人头像");
            
            ///技能证书
            if (indexPath.section == 1)
            {
                UIImage *currentImg = cerImgStr.length >0?(cerImg):([UIImage imageNamed:@"addpic"]);
                [cell.photoBtn setImage:currentImg forState:UIControlStateNormal];
            }
            ///个人头像
            else
            {
                UIImage *currentImg = headImgStr.length >0?(headImg):([UIImage imageNamed:@"addpic"]);
                [cell.photoBtn setImage:currentImg forState:UIControlStateNormal];
            }
        }
        cell.titleLabel.text = title;
        
        ///数据回调
        YBWeakSelf;
        [cell setSelectPhotoBlock:^(NSInteger selectType, NSInteger section) {
            weakSelf.photoNum = 1;
            if (selectType == 0) {
                weakSelf.photoIndex = section == 1?(0):(1);
            }
            else
            {
                weakSelf.photoIndex = section == 1?(2):(3);
            }
            [weakSelf takePhotoFromAlbum];
        }];
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
    ///门头照片 | 身份证照片
    else if (indexPath.section == 2)
    {
        SHShopDoorPhotoCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SHShopDoorPhotoCell"];
        if (cell == nil)
        {
            cell = [[SHShopDoorPhotoCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"SHShopDoorPhotoCell"];
        }
        ///门头照
        if (self.typeTag == 0) {
            cell.dict = @{};
            cell.photoArray = self.doorArray;
            cell.IDFanBtn.hidden = YES;
            cell.IDZhengBtn.hidden = YES;
        }
        ///身份证照片
        else
        {
            cell.dict2= @{};
            cell.titleLabel.text = @"身份证照片";
            UIImage *currentImg1 = IDZhengStr.length >0?(IDZhengImg):([UIImage imageNamed:@"id_zheng"]);
            [cell.IDZhengBtn setImage:currentImg1 forState:UIControlStateNormal];
            
            UIImage *currentImg2 = IDFanStr.length >0?(IDFanImg):([UIImage imageNamed:@"id_fan"]);
            [cell.IDFanBtn setImage:currentImg2 forState:UIControlStateNormal];
            
            
            [cell.photoView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
            cell.photoBtn.hidden = YES;
            cell.IDFanBtn.hidden = NO;
            cell.IDZhengBtn.hidden = NO;
            [cell.photoView mas_updateConstraints:^(MASConstraintMaker *make) {
                make.height.mas_equalTo(WScale(120));
            }];
        }
        
        MJWeakSelf;
        [cell setSelectDoorPhotoBlock:^(BOOL isSelect) {
            
            weakSelf.photoIndex = 4;
            weakSelf.photoNum = 6 -self.doorArray.count;
            [weakSelf takePhotoFromAlbum];
        }];
        
        ///删除照片
        [cell setDeleteDoorPhotoBlock:^(NSInteger Tag) {
            [weakSelf.doorArray removeObjectAtIndex:Tag];
            [weakSelf.tableView reloadData];
        }];
        
        [cell setAddIDPhotoBlock:^(NSInteger Tag) {
            weakSelf.photoIndex = Tag+5;
            weakSelf.photoNum = 1;
            [weakSelf takePhotoFromAlbum];
        }];
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
    
    //有提供24小时服务的能力
    SHShop24HourCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SHShop24HourCell"];
    if (cell == nil)
    {
        cell = [[SHShop24HourCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"SHShop24HourCell"];
    }
    cell.dict = @{};
    [cell setSelectBlock:^(BOOL select) {
        
    }];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}
// 表的区数
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 5;
}
// 表的行数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0)
    {
        return self.typeTag == 0?(self.listArray.count):(self.listArray2.count);
    }
    else
    {
        return 1;
    }
}
// 表的行高
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0)
    {
        return WScale(45);
    }
    else  if (indexPath.section == 1 || indexPath.section == 3)
    {
        return  WScale(155);
    }
    else  if (indexPath.section == 2)
    {
        return UITableViewAutomaticDimension;
    }
    else
    {
        return WScale(60);
    }
}
- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return UITableViewAutomaticDimension;
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
    NSString *title;
    if (self.typeTag == 0) {
        title = self.listArray[indexPath.row];
    }
    else
    {
        title = self.listArray2[indexPath.row];
    }
    if ([title isEqualToString:@"服务商类型"])
    {
        [self.typeSelectView show];
    }
    else if ([title isEqualToString:@"所在区域"])
    {
        
    }
    else if ([title isEqualToString:@"详细地址"])
    {
        
    }
    else if ([title isEqualToString:@"服务范围"])
    {
        
    }
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
        [self.view addSubview:_tableView];
        _tableView.tableFooterView = self.footView;
    }
    return _tableView;
}

#pragma mark ******* 从相册获取照片
-(void)takePhotoFromAlbum
{
    TZImagePickerController *imagePickerVc = [[TZImagePickerController alloc] initWithMaxImagesCount:_photoNum delegate:self];
    imagePickerVc.allowTakePicture = NO;
    imagePickerVc.allowPickingOriginalPhoto = YES;
    imagePickerVc.allowTakeVideo = NO;
    imagePickerVc.allowPickingVideo = NO;
    
    MJWeakSelf;
    [imagePickerVc setDidFinishPickingPhotosHandle:^(NSArray<UIImage *> *photos, NSArray *assets, BOOL isSelectOriginalPhoto)
    {
        if (weakSelf.photoIndex == 4) {
            [self.doorArray addObjectsFromArray:photos];
        }
        else
        {
            UIImage *image = photos[0];
            NSData *imgData = UIImageJPEGRepresentation(image,0.3f);
            NSString *imgStr = [imgData base64EncodedStringWithOptions:0];
            
            if (weakSelf.photoIndex == 0) {
                self->numImg = image;
                self->numImgStr = imgStr;
            }
            else if (weakSelf.photoIndex == 1)
            {
                self->logoImg = image;
                self->logoImgStr = imgStr;
            }
            else if (weakSelf.photoIndex == 2)
            {
                self->cerImg = image;
                self->cerImgStr = imgStr;
            }
            else if (weakSelf.photoIndex == 3)
            {
                self->headImg = image;
                self->headImgStr = imgStr;
            }
            else if (weakSelf.photoIndex == 5)
            {
                self->IDZhengImg = image;
                self->IDZhengStr = imgStr;
            }
            else if (weakSelf.photoIndex == 6)
            {
                self->IDFanImg = image;
                self->IDFanStr = imgStr;
            }
        }
        [weakSelf.tableView reloadData];
    }];
    imagePickerVc.modalPresentationStyle = UIModalPresentationFullScreen;
    [self presentViewController:imagePickerVc animated:YES completion:nil];
}

-(UIView *)footView
{
    if (!_footView) {
        _footView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kWindowW, WScale(100))];
        
        UIButton *publicBtn = [UIButton buttonWithTitle:@"确认提交" font:kFont(15) titleColor:WhiteColor backGroundColor:ThemeColor buttonTag:0 target:self action:@selector(publicBtnClick) showView:_footView];
        publicBtn.layer.cornerRadius = 4;
        publicBtn.clipsToBounds = YES;
        publicBtn.frame = CGRectMake(WScale(15), WScale(30), kWindowW-WScale(30), WScale(40));
    }
    return _footView;
}

-(SHShopTypeSelectView *)typeSelectView
{
    MJWeakSelf;
    if (!_typeSelectView) {
        _typeSelectView = [[SHShopTypeSelectView alloc] init];
        _typeSelectView.selectArray = @[@"服务商",@"技能达人"];
        [_typeSelectView setSelectBlock:^(NSInteger Tag) {
            weakSelf.typeTag = Tag;
            self->selectType = Tag == 0?(@"服务商"):(@"技能达人");
            [weakSelf relodArrayData];
            [weakSelf.tableView reloadData];
        }];
    }
    return _typeSelectView;
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
