//
//  SHPostViewController.m
//  SharedHome
//
//  Created by 解辉 on 2020/7/27.
//  Copyright © 2020 NaDao. All rights reserved.
//

#import "SHPostViewController.h"
#import <CoreServices/UTCoreTypes.h>
#import "NIMGrowingTextView.h"
#import "SHChatCollectionViewCell.h"
#import "SHTakePhotoSelectView.h"
#import <TZImagePickerController/TZImagePickerController.h>
#import "SHFeePopView.h"
#import "SHSelectSortsVC.h"
#import "SHShowAreaViewController.h"
#import "SHGoPayViewController.h"
#define ChatCollectionViewCell @"ChatCollectionViewCell"

@interface SHPostViewController ()<UINavigationControllerDelegate,UIImagePickerControllerDelegate,UIGestureRecognizerDelegate,NIMGrowingTextViewDelegate,TZImagePickerControllerDelegate>

@property (nonatomic,weak) NIMGrowingTextView *inputTextView;
@property (nonatomic,weak) UILabel *numTip;
@property (nonatomic,weak) UILabel *numTip2;
@property (nonatomic,weak) UILabel *moneyLabel;
@property (nonatomic,strong) UIButton *sendBtn;
@property (nonatomic,strong) UIView *bottomView;
@property (nonatomic,strong) UIImageView *playIcon;
@property (nonatomic,weak) UIButton *upLoadBtn;
@property (nonatomic,weak) UILabel *typeLabel;
@property (nonatomic,weak) UIButton *showBtn;
@property (nonatomic,strong) BigClickBT *areaView;
@property (nonatomic,strong) NSMutableArray *showArray;
@property (nonatomic,strong) NSMutableArray *sortArray;
@property (nonatomic,strong) NSMutableDictionary *selectAreaDict;
@property (nonatomic,strong) SHFeePopView *feeView;
@end

@implementation SHPostViewController

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.showArray = [[NSMutableArray alloc] init];
    [self setNavView];
    [self setUI];
    [self bottomView];
}

#pragma mark *****************  按钮的点击事件
#pragma mark 返回
-(void)backBtnClick
{
  [self dismissViewControllerAnimated:YES completion:nil];
}

//选择类别
-(void)typeBtnClick
{
    YBWeakSelf;
    SHSelectSortsVC *sortVC = [[SHSelectSortsVC alloc] init];
    [sortVC setSelectSort:^(NSArray * _Nonnull sortArray) {
        weakSelf.typeLabel.text = [sortArray componentsJoinedByString:@","];
        weakSelf.sortArray = sortArray.mutableCopy;
    }];
    sortVC.selectArray = self.sortArray;
    [self.navigationController pushViewController:sortVC animated:YES];
}

//上传视频
-(void)uploadBtnClick
{
    [self takePhotoFromAlbum];
}

//视频展示区域
-(void)showBtnClick
{
    MJWeakSelf;
    SHShowAreaViewController *areaVC = [[SHShowAreaViewController alloc] init];
    [areaVC setSelectArea:^(NSMutableDictionary * _Nonnull dict) {
        weakSelf.selectAreaDict = dict;
        self.showArray = [[NSMutableArray alloc] init];
        for (NSString *city in dict.allKeys)
        {
            NSArray *quArray = dict[city];
            for (NSString *qu in quArray) {
                NSString *areaStr = [NSString stringWithFormat:@"%@ %@",city,qu];
                [self.showArray addObject:areaStr];
            }
        }
        [self setVideoShowWithArray];
    }];
    areaVC.selectDict = self.selectAreaDict;
    [self.navigationController pushViewController:areaVC animated:YES];
}

//收费标准
-(void)setTipBtn
{
    [self.feeView show];
}

//我要上热门资源
-(void)setSelectBtnClick:(UIButton *)button
{
    button.selected = !button.selected;
    if (button.selected == YES) {
        self.moneyLabel.text = @"￥100";
    }
    else
    {
        self.moneyLabel.text = @"￥0";
    }
}

//发布
-(void)publicBtnClick
{
    SHGoPayViewController *payVC = [[SHGoPayViewController alloc] init];
    [self.navigationController pushViewController:payVC animated:YES];
}

//视频展示区域 -- 位置删除
-(void)areaBtnClick:(UIButton *)button
{
    NSString *title = button.titleLabel.text;
    NSArray *titleArray = [title componentsSeparatedByString:@" "];
    
    NSString *key = titleArray[0];
    NSString *value = titleArray[1];
    
    NSMutableArray *areaArray = self.selectAreaDict[key];
    [areaArray removeObject:value];
    [self.selectAreaDict setValue:areaArray forKey:key];
    
    [self.showArray removeObject:title];
    [self setVideoShowWithArray];
}

-(void)setVideoShowWithArray
{
    [self.areaView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    NSInteger num = self.showArray.count >2?(2):(self.showArray.count);
    for (int i = 0; i<num; i++)
    {
        BigClickBT *areaBtn = [[BigClickBT alloc] init];
        [areaBtn setTitle:self.showArray[i] forState:UIControlStateNormal];
        [areaBtn setTitleColor:UIColorFromRGB(0x666666) forState:UIControlStateNormal];
        areaBtn.titleLabel.font = kFont(11);
        areaBtn.backgroundColor = UIColorFromRGB(0xF5F5F5);
        areaBtn.tag = i;
        areaBtn.layer.cornerRadius = 4;
        areaBtn.clipsToBounds = YES;
        [areaBtn setImage:[UIImage imageNamed:@"area_close"] forState:UIControlStateNormal];
        [areaBtn addTarget:self action:@selector(areaBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.areaView addSubview:areaBtn];
        [areaBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(self.areaView);
            make.width.mas_equalTo(WScale(96));
            make.height.mas_equalTo(WScale(30));
            make.right.mas_equalTo(WScale(-15)-(WScale(102)*i));
        }];
        [areaBtn layoutButtonWithEdgeInsetsStyle:MKButtonEdgeInsetsStyleRight imageTitleSpace:WScale(3)];
    }
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
        make.bottom.mas_equalTo(-SafeAreaBottomHeight-WScale(50));
    }];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hiddenKeyboard)];
    tap.delegate = self;
    [bgScrollView addGestureRecognizer:tap];
    
    
    //选择类别
    UIButton *typeBtn = [UIButton buttonWithTitle:@"选择类别" font:kFont(15) titleColor:UIColorFromRGB(0x333333) backGroundColor:ClearColor buttonTag:0 target:self action:@selector(typeBtnClick) showView:bgScrollView];
    [typeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.view);
        make.left.top.mas_equalTo(WScale(15));
        make.height.mas_equalTo(WScale(20));
    }];
    typeBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    
    UIImageView *arrowImg = [[UIImageView alloc] init];
    arrowImg.image = [UIImage imageNamed:@"public_arrow_right"];
    [typeBtn addSubview:arrowImg];
    [arrowImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(0);
        make.centerY.mas_equalTo(typeBtn);
    }];
    
    UILabel *typeLabel = [UILabel labelWithText:@"" font:kFont(14) textColor:UIColorFromRGB(0x666666) backGroundColor:ClearColor superView:typeBtn];
    typeLabel.numberOfLines = 1;
    typeLabel.textAlignment = NSTextAlignmentRight;
    [typeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(WScale(-20));
        make.centerY.mas_equalTo(typeBtn);
        make.width.mas_equalTo(WScale(140));
    }];
    self.typeLabel = typeLabel;
    
    
    //上传视频
    UILabel *uploadTitle = [UILabel labelWithText:@"上传视频" font:kFont(15) textColor:UIColorFromRGB(0x333333) backGroundColor:ClearColor superView:bgScrollView];
    [uploadTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(WScale(15));
        make.top.mas_equalTo(typeBtn.mas_bottom).mas_equalTo(WScale(25));
    }];
    
    UILabel *uploadTitle2 = [UILabel labelWithText:@"30s内，文件大小不超过20M" font:kFont(12) textColor:UIColorFromRGB(0x999999) backGroundColor:ClearColor superView:bgScrollView];
    [uploadTitle2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(uploadTitle.mas_right).mas_equalTo(WScale(10));
        make.centerY.mas_equalTo(uploadTitle);
    }];
    
    UIButton *upLoadBtn = [UIButton buttonWithImage:@"addpic" target:self action:@selector(uploadBtnClick) showView:bgScrollView];
    [upLoadBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(WScale(15));
        make.top.mas_equalTo(uploadTitle.mas_bottom).mas_equalTo(WScale(15));
        make.width.height.mas_equalTo(WScale(107));
    }];
    self.upLoadBtn = upLoadBtn;
    
    self.playIcon = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"play_icon"]];
    self.playIcon.hidden = YES;
    [upLoadBtn addSubview:self.playIcon];
    [self.playIcon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.mas_equalTo(upLoadBtn);
        make.width.height.mas_equalTo(WScale(20));
    }];
    
    
    //视频标题
    UILabel *videoTitle = [UILabel labelWithText:@"视频标题" font:kFont(15) textColor:UIColorFromRGB(0x333333) backGroundColor:ClearColor superView:bgScrollView];
    [videoTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(WScale(15));
        make.top.mas_equalTo(upLoadBtn.mas_bottom).mas_equalTo(WScale(25));
    }];
    
    UIView *textView = [[UIView alloc] init];
    [bgScrollView addSubview:textView];
    [textView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(bgScrollView);
        make.left.mas_equalTo(WScale(10));
        make.top.mas_equalTo(videoTitle.mas_bottom).mas_equalTo(WScale(10));
        make.height.mas_equalTo(WScale(90));
    }];
    
    NSString *tipContent = @"请输入视频标题...";
    NSMutableAttributedString*mulAttriStr =  [[NSMutableAttributedString alloc]initWithString:tipContent];
    [mulAttriStr addAttributes:@{NSForegroundColorAttributeName:UIColorFromRGB(0xB4B4B4), NSFontAttributeName:kFont(15)} range:NSMakeRange(0,tipContent.length)];
    NIMGrowingTextView *inputTextView = [[NIMGrowingTextView alloc] init];
    inputTextView.layer.cornerRadius = 5;
    inputTextView.placeholderAttributedText = mulAttriStr;
    inputTextView.font = [UIFont boldSystemFontOfSize:WScale(15)];
    inputTextView.maxNum = 30;
    inputTextView.maxNumberOfLines = 7;
    inputTextView.minNumberOfLines = 1;
    inputTextView.textColor = [UIColor blackColor];
    inputTextView.textViewDelegate = self;
    [textView addSubview:inputTextView];
    [inputTextView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(textView);
        make.left.top.mas_equalTo(0);
        make.height.mas_equalTo(WScale(60));
    }];
    self.inputTextView = inputTextView;
    
    UILabel *numTip = [UILabel labelWithText:@"0/30" font:kFont(12) textColor:UIColorFromRGB(0xB4B4B4) backGroundColor:ClearColor superView:textView];
    [numTip mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(0);
        make.right.mas_equalTo(-WScale(5));
    }];
    self.numTip = numTip;
    
    
    //视频展示区域
    UIButton *showBtn = [UIButton buttonWithTitle:@"视频展示区域" font:kFont(15) titleColor:UIColorFromRGB(0x333333) backGroundColor:ClearColor buttonTag:0 target:self action:@selector(showBtnClick) showView:bgScrollView];
    [showBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.view);
        make.left.mas_equalTo(WScale(15));
        make.top.mas_equalTo(textView.mas_bottom).mas_equalTo(WScale(25));
        make.height.mas_equalTo(WScale(20));
    }];
    showBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    self.showBtn = showBtn;
    
    UIImageView *arrowImg2 = [[UIImageView alloc] init];
    arrowImg2.image = [UIImage imageNamed:@"public_arrow_right"];
    [showBtn addSubview:arrowImg2];
    [arrowImg2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(0);
        make.centerY.mas_equalTo(showBtn);
    }];
    
    BigClickBT *areaView = [[BigClickBT alloc] init];
    [areaView addTarget:self action:@selector(showBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [showBtn addSubview: areaView];
    [areaView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.mas_equalTo(showBtn);
        make.left.top.mas_equalTo(0);
    }];
    self.areaView = areaView;
    [self setVideoShowWithArray];
    
    
    //推广设置
    UILabel *setTitle = [UILabel labelWithText:@"推广设置" font:kFont(15) textColor:UIColorFromRGB(0x333333) backGroundColor:ClearColor superView:bgScrollView];
    [setTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(WScale(15));
        make.top.mas_equalTo(showBtn.mas_bottom).mas_equalTo(WScale(25));
    }];
    
    UIButton *setTipBtn = [UIButton buttonWithTitle:@"收费标准" font:kFont(12) titleColor:UIColorFromRGB(0x999999) backGroundColor:ClearColor buttonTag:0 target:self action:@selector(setTipBtn) showView:bgScrollView];
    [setTipBtn setImage:[UIImage imageNamed:@"setTip"] forState:UIControlStateNormal];
    [setTipBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.view.mas_right).mas_equalTo(WScale(-10));
        make.centerY.mas_equalTo(setTitle);
        make.width.mas_equalTo(WScale(80));
    }];
    [setTipBtn layoutButtonWithEdgeInsetsStyle:MKButtonEdgeInsetsStyleRight imageTitleSpace:WScale(4)];
    
    BigClickBT *setSelectBtn = [[BigClickBT alloc] init];
    [setSelectBtn setImage:[UIImage imageNamed:@"post_quan_normal"] forState:UIControlStateNormal];
    [setSelectBtn setImage:[UIImage imageNamed:@"post_quan_select"] forState:UIControlStateSelected];
    [setSelectBtn setTitle:@" 我要上热门资源" forState:UIControlStateNormal];
    [setSelectBtn setTitleColor:UIColorFromRGB(0x666666) forState:UIControlStateNormal];
    [setSelectBtn setTitleColor:ThemeColor forState:UIControlStateSelected];
    [setSelectBtn addTarget:self action:@selector(setSelectBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    setSelectBtn.titleLabel.font = kFont(14);
    [bgScrollView addSubview:setSelectBtn];
    [setSelectBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(WScale(15));
        make.top.mas_equalTo(setTitle.mas_bottom).mas_equalTo(WScale(20));
        make.bottom.mas_equalTo(-WScale(15));
    }];
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
        
        UILabel *moneyTitle = [UILabel labelWithText:@"需支付：" font:kFont(15) textColor:UIColorFromRGB(0x333333) backGroundColor:ClearColor superView:_bottomView];
        [moneyTitle mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(WScale(15));
            make.centerY.mas_equalTo(_bottomView);
        }];
        
        UILabel *moneyLabel = [UILabel labelWithText:@"￥0" font:[UIFont boldSystemFontOfSize:WScale(15)] textColor:UIColorFromRGB(0xFF3640) backGroundColor:ClearColor superView:_bottomView];
        [moneyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(moneyTitle.mas_right);
            make.centerY.mas_equalTo(_bottomView);
        }];
        self.moneyLabel = moneyLabel;
        
        UIButton *publicBtn = [UIButton buttonWithTitle:@"发 布" font:kFont(15) titleColor:WhiteColor backGroundColor:ThemeColor buttonTag:0 target:self action:@selector(publicBtnClick) showView:self.bottomView];
        [publicBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.bottom.right.mas_equalTo(0);
            make.width.mas_equalTo(WScale(140));
        }];
    }
    return _bottomView;
}

#pragma mark 收费标准
-(SHFeePopView *)feeView
{
    if (!_feeView) {
        _feeView = [[SHFeePopView alloc] init];
        _feeView.title = @"收费标准";
        _feeView.content = @"按选择的区域数量*区域单价（每个区 域的单价都一样），区域单位为每个10 元 \n\n 免费视频只可以在资源才可以看到，付费视频直接推荐至首页，增大曝光量哦";
    }
    return _feeView;
}

#pragma mark ******* 从相册获取视频
-(void)takePhotoFromAlbum
{
    TZImagePickerController *imagePickerVc = [[TZImagePickerController alloc] initWithMaxImagesCount:1 delegate:self];
    imagePickerVc.allowTakePicture = NO;
    imagePickerVc.allowPickingOriginalPhoto = NO;
    imagePickerVc.allowTakeVideo = NO;
    imagePickerVc.allowPickingImage = NO;
    imagePickerVc.allowPickingVideo = YES;
    MJWeakSelf;
    [imagePickerVc setDidFinishPickingVideoHandle:^(UIImage *coverImage, PHAsset *asset) {
        [weakSelf.upLoadBtn setImage:coverImage forState:UIControlStateNormal];
        weakSelf.playIcon.hidden = NO;
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

- (BOOL)textViewShouldBeginEditing:(NIMGrowingTextView *)growingTextView;
{
    return YES;
}
- (void)textViewDidChange:(NIMGrowingTextView *)growingTextView
{
    NSInteger num = growingTextView.text.length >= 30?(30):(growingTextView.text.length);
    self.numTip.text = [NSString stringWithFormat:@"%ld/30",num];
}

#pragma mark 导航栏
-(void)setNavView
{
    UILabel *titleLabel = [UILabel labelWithText:@"发布短视频" font:[UIFont boldSystemFontOfSize:WScale(17)] textColor:BlackColor backGroundColor:ClearColor superView:self.view];
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.view);
        make.top.mas_equalTo(SafeAreaStateHeight+WScale(10));
    }];
    
    BigClickBT *backBtn = [[BigClickBT alloc] init];
    [backBtn setImage:[UIImage imageNamed:@"nav_back"] forState:UIControlStateNormal];
    [backBtn addTarget:self action:@selector(backBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:backBtn];
    [backBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(titleLabel);
        make.left.mas_equalTo(WScale(15));
    }];
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
