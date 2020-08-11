//
//  SHChatViewController.m
//  SharedHome
//
//  Created by 解辉 on 2020/8/2.
//  Copyright © 2020 NaDao. All rights reserved.
//

#import "SHChatViewController.h"
#import <CoreServices/UTCoreTypes.h>
#import "NIMGrowingTextView.h"
#import "SHChatCollectionViewCell.h"
#import "SHTakePhotoSelectView.h"
#import <TZImagePickerController/TZImagePickerController.h>

#define ChatCollectionViewCell @"ChatCollectionViewCell"

@interface SHChatViewController ()<UINavigationControllerDelegate,UIImagePickerControllerDelegate,UICollectionViewDelegate, UICollectionViewDataSource,UIGestureRecognizerDelegate,NIMGrowingTextViewDelegate,TZImagePickerControllerDelegate>

@property (nonatomic,weak) NIMGrowingTextView *inputTextView;
@property (nonatomic,strong) UIImageView *headImg;
@property (nonatomic,strong) UICollectionView  *collectionView;
@property (nonatomic,strong) NSMutableArray  *picListArr;
@property (nonatomic,weak) UILabel *titleLabel3;
@property (nonatomic,weak) UILabel *numTip;
@property (nonatomic,weak) UILabel *numTip2;
@property (nonatomic,strong) UIButton *sendBtn;
@property (nonatomic,strong)SHTakePhotoSelectView *selectView;
@end

@implementation SHChatViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = WhiteColor;
    self.title = @"发送";
    
    self.picListArr = [[NSMutableArray alloc] init];
    [self setUI];
    [self sendBtn];
}

#pragma mark ************* 按钮的点击事件
//发送
-(void)sendBtnClick
{
    
}

#pragma mark ************* UI
-(void)setUI
{
    UIScrollView *bgScrollView = [[UIScrollView alloc] init];
    bgScrollView.showsVerticalScrollIndicator = NO;
    if (@available(iOS 11.0, *)) {
        bgScrollView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    }
    else
    {
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    bgScrollView.userInteractionEnabled = YES;
    [self.view addSubview:bgScrollView];
    [bgScrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.view);
        make.left.mas_equalTo(0);
        make.width.mas_equalTo(kWindowW);
        make.top.mas_equalTo(SafeAreaTopHeight);
        make.bottom.mas_equalTo(-SafeAreaBottomHeight);
    }];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hiddenKeyboard)];
    tap.delegate = self;
    [bgScrollView addGestureRecognizer:tap];
    
    ///头像
    _headImg = [[UIImageView alloc] init];
    _headImg.layer.cornerRadius = WScale(20);
    _headImg.clipsToBounds = YES;
    _headImg.image = [UIImage imageNamed:@"public_bg"];
    [bgScrollView addSubview:_headImg];
    [_headImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(WScale(15));
        make.top.mas_equalTo(WScale(20));
        make.width.height.mas_equalTo(WScale(40));
    }];
    
    ///昵称
    UILabel *nameLabel = [UILabel labelWithText:@"我" font:kFont(15) textColor:UIColorFromRGB(0x333333) backGroundColor:ClearColor superView:bgScrollView];
    [nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.headImg.mas_right).mas_equalTo(WScale(15));
        make.centerY.mas_equalTo(self.headImg);
    }];
    
    
    ///文字输入
    UIView *textView = [[UIView alloc] init];
    textView.backgroundColor = UIColorFromRGB(0xF5F5F5);
    [bgScrollView addSubview:textView];
    [textView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(bgScrollView);
        make.left.mas_equalTo(WScale(15));
        make.top.mas_equalTo(self.headImg.mas_bottom).mas_equalTo(WScale(20));
       // make.height.mas_equalTo(WScale(120));
    }];
    
    NSString *tipContent = @"请输入私信内容";
    NSMutableAttributedString*mulAttriStr =  [[NSMutableAttributedString alloc]initWithString:tipContent];
    [mulAttriStr addAttributes:@{NSForegroundColorAttributeName:UIColorFromRGB(0xB4B4B4), NSFontAttributeName:kFont(15)} range:NSMakeRange(0,tipContent.length)];
    NIMGrowingTextView *inputTextView = [[NIMGrowingTextView alloc] init];
    inputTextView.layer.cornerRadius = 5;
    inputTextView.placeholderAttributedText = mulAttriStr;
    inputTextView.font = kFont(15);
    inputTextView.maxNum = 500;
    inputTextView.maxNumberOfLines = 7;
    inputTextView.minNumberOfLines = 1;
    inputTextView.textColor = [UIColor blackColor];
    inputTextView.textViewDelegate = self;
    [textView addSubview:inputTextView];
    [inputTextView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(textView);
        make.left.mas_equalTo(WScale(10));
        make.top.mas_equalTo(WScale(5));
        make.height.mas_equalTo(WScale(90));
        make.bottom.mas_equalTo(-WScale(30));
    }];
    self.inputTextView = inputTextView;
    
    UILabel *numTip = [UILabel labelWithText:@"0/500" font:kFont(12) textColor:UIColorFromRGB(0xB4B4B4) backGroundColor:ClearColor superView:textView];
    [numTip mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(WScale(-20));
        make.bottom.mas_equalTo(WScale(-12));
    }];
    self.numTip = numTip;
        
    
    ///拍照上传
    UILabel *titleLabel3 = [UILabel labelWithText:@"上传图片" font:kFont(15) textColor:UIColorFromRGB(0x666666) backGroundColor:ClearColor superView:bgScrollView];
    [titleLabel3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(WScale(15));
        make.top.mas_equalTo(textView.mas_bottom).mas_equalTo(WScale(17));
    }];
    self.titleLabel3 = titleLabel3;
    
    UILabel *numTip2 = [UILabel labelWithText:@"0/9" font:kFont(12) textColor:UIColorFromRGB(0xb4b4b4) backGroundColor:ClearColor superView:bgScrollView];
    [numTip2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.view.mas_right).mas_equalTo(WScale(-15));
        make.centerY.mas_equalTo(titleLabel3);
    }];
    self.numTip2 = numTip2;

    CGFloat picWidth = (kWindowW-WScale(30)-2*7)/3.0;
    NSInteger count = MIN(self.picListArr.count+1, 9);
    NSInteger row = count%3==0?count/3:(count/3+1);
    CGFloat height = picWidth*row+(row-1)*7;
    [bgScrollView addSubview:self.collectionView];
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(titleLabel3.mas_bottom).mas_equalTo(WScale(15));
        make.left.mas_equalTo(WScale(15));
        make.width.mas_equalTo(kWindowW-WScale(30));
        make.height.mas_equalTo(height);
        make.bottom.mas_equalTo(-SafeAreaBottomHeight-WScale(55));
    }];
    
}

- (UICollectionView *)collectionView
{
    if (!_collectionView) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.backgroundColor = WhiteColor;
        [_collectionView registerClass:[SHChatCollectionViewCell class] forCellWithReuseIdentifier:ChatCollectionViewCell];
        _collectionView.showsVerticalScrollIndicator = NO;
        _collectionView.scrollEnabled = NO;
        
    }
    return _collectionView;
}

-(UIButton *)sendBtn
{
    if (!_sendBtn) {
        _sendBtn = [UIButton buttonWithTitle:@"发送" font:kFont(15) titleColor:WhiteColor backGroundColor:ThemeColor buttonTag:0 target:self action:@selector(sendBtnClick) showView:self.view];
        [_sendBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.mas_equalTo(0);
            make.bottom.mas_equalTo(-SafeAreaBottomHeight);
            make.height.mas_equalTo(WScale(44));
        }];
    }
    return _sendBtn;;
}

#pragma mark ********************** 代理
#pragma mark - collection 代理
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.picListArr.count>0)
    {
        if (indexPath.row<self.picListArr.count)
        {
            //跳转到图片预览页面
            [self previewVideoOrPic:indexPath.row];
        }
        else
        {
           // [self takePhoto];
            [self.selectView show];
        }
    }
    else
    {
       // [self takePhoto];
        [self.selectView show];
    }
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    SHChatCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:ChatCollectionViewCell forIndexPath:indexPath];
    if (self.picListArr.count>0)
    {
        if (indexPath.row < self.picListArr.count)
        {
            cell.cellImgView.image = self.picListArr[indexPath.row];
        }
        else
        {
            cell.cellImgView.image = [UIImage imageNamed:@"addpic"];
        }
    }
    else
    {
        cell.cellImgView.image = [UIImage imageNamed:@"addpic"];
    }
    return cell;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    if (self.picListArr.count>0 && [self.picListArr[0] isKindOfClass:[NSURL class]]) {
        return 1;
    }
    return MIN(self.picListArr.count+1, 9);
}
- (CGSize) collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat picWidth = (kWindowW-WScale(60)-2*7)/3.0;
    CGFloat height = picWidth;
    if (self.picListArr.count>0 && [self.picListArr[0] isKindOfClass:[NSURL class]]) {
        height = WScale(180);
    }
    return CGSizeMake(picWidth, height);
}
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsZero;
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return 0;
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    return 7;
}

#pragma mark ***** 拍照选择框
-(SHTakePhotoSelectView *)selectView
{
    if (!_selectView) {
        _selectView = [[SHTakePhotoSelectView alloc] init];
        _selectView.selectArray = @[@"拍照",@"从相册中选择",@"取消"];
        MJWeakSelf;
        [_selectView setSelectBlock:^(NSInteger Tag) {
            if (Tag == 0) {
                [weakSelf takePhoto];
            }
            else if (Tag == 1)
            {
                [weakSelf takePhotoFromAlbum];
            }
        }];
    }
    return _selectView;
}
#pragma mark ******* 拍照
-(void)takePhoto
{
    UIImagePickerController *imagePickerVc = [[UIImagePickerController alloc] init];
     imagePickerVc.sourceType =UIImagePickerControllerSourceTypeCamera;
     imagePickerVc.mediaTypes =@[(NSString *)kUTTypeImage];
     imagePickerVc.delegate = self;

     imagePickerVc.navigationBar.barTintColor = self.navigationController.navigationBar.barTintColor;
     imagePickerVc.navigationBar.tintColor = self.navigationController.navigationBar.tintColor;
     UIBarButtonItem *BarItem = [UIBarButtonItem appearanceWhenContainedInInstancesOfClasses:@[[UIImagePickerController class]]];
     [BarItem setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor blackColor]} forState:UIControlStateNormal];
     imagePickerVc.modalPresentationStyle = UIModalPresentationFullScreen;
     [self presentViewController:imagePickerVc animated:YES completion:nil];
}
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    UIImage *image = info[UIImagePickerControllerOriginalImage];
    [self.picListArr addObject:image];
    
    self.numTip2.text = [NSString stringWithFormat:@"%ld/9",self.picListArr.count];
    CGFloat picWidth = (kWindowW-WScale(60)-2*7)/3.0;
    NSInteger count = MIN(self.picListArr.count+1, 9);
    NSInteger row = count%3==0?count/3:(count/3+1);
    CGFloat height = picWidth*row+(row-1)*7;
    
    [self.collectionView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.titleLabel3.mas_bottom).mas_equalTo(WScale(15));
        make.left.mas_equalTo(WScale(15));
        make.width.mas_equalTo(kWindowW-WScale(30));
        make.height.mas_equalTo(height);
        make.bottom.mas_equalTo(-SafeAreaBottomHeight-WScale(55));
    }];
    [self.collectionView reloadData];
    [picker dismissViewControllerAnimated:YES completion:nil];
}
#pragma mark ******* 从相册获取照片
-(void)takePhotoFromAlbum
{
    TZImagePickerController *imagePickerVc = [[TZImagePickerController alloc] initWithMaxImagesCount:9-self.picListArr.count delegate:self];
    imagePickerVc.allowTakePicture = NO;
    imagePickerVc.allowPickingOriginalPhoto = YES;
    imagePickerVc.allowTakeVideo = NO;
    imagePickerVc.allowPickingVideo = NO;
    
    MJWeakSelf;
    [imagePickerVc setDidFinishPickingPhotosHandle:^(NSArray<UIImage *> *photos, NSArray *assets, BOOL isSelectOriginalPhoto) {
        
        [weakSelf.picListArr addObjectsFromArray:photos];
        
        CGFloat picWidth = (kWindowW-WScale(60)-2*7)/3.0;
        
        NSInteger count = MIN(weakSelf.picListArr.count+1, 9);
        NSInteger row = count%3==0?count/3:(count/3+1);
        CGFloat height = picWidth*row+(row-1)*7;
        
        [weakSelf.collectionView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.titleLabel3.mas_bottom).mas_equalTo(WScale(15));
            make.left.mas_equalTo(WScale(15));
            make.width.mas_equalTo(kWindowW-WScale(30));
            make.height.mas_equalTo(height);
            make.bottom.mas_equalTo(-SafeAreaBottomHeight-WScale(55));
        }];
        weakSelf.numTip2.text = [NSString stringWithFormat:@"%ld/9",weakSelf.picListArr.count];
        [weakSelf.collectionView reloadData];
    }];
    imagePickerVc.modalPresentationStyle = UIModalPresentationFullScreen;
    [self presentViewController:imagePickerVc animated:YES completion:nil];
}


#pragma mark - 预览图片|视频
- (void)previewVideoOrPic:(NSInteger)index
{

}

#pragma mark - NIMGrowingTextView代理
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch
{
    if ([[touch.view class] isKindOfClass:[UIScrollView class]]) {
        return YES;
    }
    return NO;
}
- (void)hiddenKeyboard
{
    [self.inputTextView resignFirstResponder];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.inputTextView resignFirstResponder];
}
//- (BOOL)textViewShouldEndEditing:(NIMGrowingTextView *)growingTextView
//{
//    self.numTip.text = [NSString stringWithFormat:@"%ld/500",growingTextView.text.length];
//    return YES;
//}
- (BOOL)textViewShouldBeginEditing:(NIMGrowingTextView *)growingTextView;
{
    return YES;
}
- (void)textViewDidChange:(NIMGrowingTextView *)growingTextView
{
    self.numTip.text = [NSString stringWithFormat:@"%ld/500",growingTextView.text.length];
}
- (void)willChangeHeight:(CGFloat)height
{
    NZLog(@"ppppppppppuuuu == %f",height);
    if (height >WScale(90)) {
        [self.inputTextView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(height);
        }];
    }
    else
    {
        [self.inputTextView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(WScale(90));
        }];
    }
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
