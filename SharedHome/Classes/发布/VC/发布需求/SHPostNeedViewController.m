//
//  SHPostNeedViewController.m
//  SharedHome
//
//  Created by 解辉 on 2020/8/4.
//  Copyright © 2020 NaDao. All rights reserved.
//

#import "SHPostNeedViewController.h"
#import <TZImagePickerController/TZImagePickerController.h>
#import "SHFeePopView.h"
#import <CoreServices/UTCoreTypes.h>
#import "NIMGrowingTextView.h"
#import "SHSelectNeedTypeVC.h"
#import "SHTakePhotoSelectView.h"
#import "SHFeePopView.h"
#import "SHIdentificationVC.h"
@interface SHPostNeedViewController ()<UINavigationControllerDelegate,UIImagePickerControllerDelegate,UIGestureRecognizerDelegate,NIMGrowingTextViewDelegate,TZImagePickerControllerDelegate,UITextFieldDelegate>

@property (nonatomic,weak) UIButton *upLoadBtn;
@property (nonatomic,weak) NIMGrowingTextView *inputTextView;
@property (nonatomic,weak) UILabel *numTip;
@property (nonatomic,weak) UILabel *typeLabel;
@property (nonatomic,strong) NSMutableArray *showArray;
@property (nonatomic,copy) NSString *selectTypeStr;
@property (nonatomic,strong)SHTakePhotoSelectView *selectView;
@property (nonatomic,strong)SHFeePopView *feeView;
@end

@implementation SHPostNeedViewController
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNavView];
    [self setUI];
}

#pragma mark *****************  按钮的点击事件
#pragma mark 返回
-(void)backBtnClick
{
  [self dismissViewControllerAnimated:YES completion:nil];
}

//发布需求类型
-(void)typeBtnClick
{
    MJWeakSelf;
    SHSelectNeedTypeVC *typeVC = [[SHSelectNeedTypeVC alloc] init];
    [typeVC setSelectType:^(NSString * _Nonnull selectType) {
        weakSelf.selectTypeStr = selectType;
        weakSelf.typeLabel.text = selectType;
    }];
    typeVC.currentType2 = self.selectTypeStr;
    [self.navigationController pushViewController:typeVC animated:YES];
}

//发布现场图片
-(void)uploadBtnClick
{
    [self.selectView show];
}

//发布需求
-(void)publicBtnClick
{
    self.feeView.content = @"发布内容包含敏感词，请修改";
  //  self.feeView.content = @"您之前两次发布且删除需求间隔时长都小于5分钟，需要10分钟后再来发布哦";
    [self.feeView show];
    
//    SHIdentificationVC *IDVC = [[SHIdentificationVC alloc] init];
//    [self.navigationController pushViewController:IDVC animated:YES];
}

-(void)textFieldChangeAction:(UITextField *)textField
{
    if (textField.tag == 0) {
        
    }
    else if (textField.tag == 1)
    {
        
    }
}

#pragma mark *****************  UI
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
    
    //提示语
    UIButton *tipBtn = [UIButton buttonWithTitle:@"隐私信息平台会有保护机制，选中服务商前，看不到隐私信息" font:kFont(12) titleColor:UIColorFromRGB(0xFF3640) backGroundColor:UIColorFromRGB(0xFBF2F2) buttonTag:0 target:self action:nil showView:bgScrollView];
    [tipBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.view);
        make.left.top.mas_equalTo(0);
        make.height.mas_equalTo(WScale(35));
    }];
    
    
    //发布需求类型
    UIButton *typeBtn = [UIButton buttonWithTitle:@"发布需求类型" font:kFont(15) titleColor:UIColorFromRGB(0x333333) backGroundColor:ClearColor buttonTag:0 target:self action:@selector(typeBtnClick) showView:bgScrollView];
    [typeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.view);
        make.left.mas_equalTo(WScale(15));
        make.top.mas_equalTo(tipBtn.mas_bottom).mas_equalTo(WScale(15));
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
    
    
    //发布现场图片
    UILabel *uploadTitle = [UILabel labelWithText:@"发布现场图片" font:kFont(15) textColor:UIColorFromRGB(0x333333) backGroundColor:ClearColor superView:bgScrollView];
    [uploadTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(WScale(15));
        make.top.mas_equalTo(typeBtn.mas_bottom).mas_equalTo(WScale(25));
    }];
    
    UILabel *uploadTitle2 = [UILabel labelWithText:@"推荐尺寸690*450" font:kFont(12) textColor:UIColorFromRGB(0x999999) backGroundColor:ClearColor superView:bgScrollView];
    [uploadTitle2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(uploadTitle.mas_right).mas_equalTo(WScale(10));
        make.centerY.mas_equalTo(uploadTitle);
    }];
    
    UIButton *upLoadBtn = [UIButton buttonWithImage:@"addpic" target:self action:@selector(uploadBtnClick) showView:bgScrollView];
    upLoadBtn.backgroundColor = UIColorFromRGB(0xF5F5F5);
    [upLoadBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(WScale(15));
        make.centerX.mas_equalTo(self.view);
        make.top.mas_equalTo(uploadTitle.mas_bottom).mas_equalTo(WScale(20));
        make.height.mas_equalTo(WScale(225));
    }];
    self.upLoadBtn = upLoadBtn;
    
    
    //服务地址
    UIButton *addressBtn = [UIButton buttonWithTitle:@"服务地址" font:kFont(15) titleColor:UIColorFromRGB(0x333333) backGroundColor:ClearColor buttonTag:0 target:self action:@selector(typeBtnClick) showView:bgScrollView];
    [addressBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.view);
        make.left.mas_equalTo(WScale(15));
        make.top.mas_equalTo(upLoadBtn.mas_bottom).mas_equalTo(WScale(25));
        make.height.mas_equalTo(WScale(20));
    }];
    addressBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    
    UIImageView *arrowImg2 = [[UIImageView alloc] init];
    arrowImg2.image = [UIImage imageNamed:@"public_arrow_right"];
    [addressBtn addSubview:arrowImg2];
    [arrowImg2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(0);
        make.centerY.mas_equalTo(addressBtn);
    }];
        
    //    UILabel *typeLabel = [UILabel labelWithText:@"" font:kFont(14) textColor:UIColorFromRGB(0x666666) backGroundColor:ClearColor superView:typeBtn];
    //    typeLabel.numberOfLines = 1;
    //    typeLabel.textAlignment = NSTextAlignmentRight;
    //    [typeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
    //        make.right.mas_equalTo(WScale(-20));
    //        make.centerY.mas_equalTo(typeBtn);
    //        make.width.mas_equalTo(WScale(140));
    //    }];
    //    self.typeLabel = typeLabel;
    
    
    //标题
    UILabel *publicTitle = [UILabel labelWithText:@"标题" font:kFont(15) textColor:UIColorFromRGB(0x333333) backGroundColor:ClearColor superView:bgScrollView];
    [publicTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(WScale(15));
        make.top.mas_equalTo(addressBtn.mas_bottom).mas_equalTo(WScale(25));
    }];
    
    UITextField *titleTF = [[UITextField alloc] initWithPlaceholder:@"请简要描述现场问题，不超过20个字" showView:bgScrollView delegate:self showFont:[UIFont boldSystemFontOfSize:WScale(15)] showColor:UIColorFromRGB(0x333333) placeholderColor:UIColorFromRGB(0xB4B4B4)];
    titleTF.tag = 0;
    [titleTF addTarget:self action:@selector(textFieldChangeAction:)   forControlEvents:UIControlEventEditingChanged];
    [titleTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(WScale(44));
        make.centerX.mas_equalTo(self.view);
        make.top.mas_equalTo(publicTitle.mas_bottom).mas_equalTo(0);
        make.left.mas_equalTo(WScale(15));
    }];
    
    //描述
    UILabel *describeLabel = [UILabel labelWithText:@"描述" font:kFont(15) textColor:UIColorFromRGB(0x333333) backGroundColor:ClearColor superView:bgScrollView];
    [describeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(WScale(15));
        make.top.mas_equalTo(titleTF.mas_bottom).mas_equalTo(WScale(20));
    }];
    
    UIView *textView = [[UIView alloc] init];
    textView.backgroundColor = UIColorFromRGB(0xF5F5F5);
    [bgScrollView addSubview:textView];
    [textView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(bgScrollView);
        make.left.mas_equalTo(WScale(10));
        make.top.mas_equalTo(describeLabel.mas_bottom).mas_equalTo(WScale(15));
    }];
    
    NSString *tipContent = @"请详细描述现场问题";
    NSMutableAttributedString*mulAttriStr =  [[NSMutableAttributedString alloc]initWithString:tipContent];
    [mulAttriStr addAttributes:@{NSForegroundColorAttributeName:UIColorFromRGB(0xB4B4B4), NSFontAttributeName:kFont(15)} range:NSMakeRange(0,tipContent.length)];
    NIMGrowingTextView *inputTextView = [[NIMGrowingTextView alloc] init];
    inputTextView.layer.cornerRadius = 5;
    inputTextView.placeholderAttributedText = mulAttriStr;
    inputTextView.font = kFont(14);
    inputTextView.maxNum = 500;
    inputTextView.maxNumberOfLines = 7;
    inputTextView.minNumberOfLines = 1;
    inputTextView.textColor = [UIColor blackColor];
    inputTextView.textViewDelegate = self;
    [textView addSubview:inputTextView];
    [inputTextView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(textView);
        make.left.mas_equalTo(WScale(5));
        make.top.mas_equalTo(WScale(5));
        make.height.mas_equalTo(WScale(70));
        make.bottom.mas_equalTo(-WScale(30));
    }];
    self.inputTextView = inputTextView;
    
    UILabel *numTip = [UILabel labelWithText:@"0/500" font:kFont(12) textColor:UIColorFromRGB(0xB4B4B4) backGroundColor:ClearColor superView:textView];
    [numTip mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(-WScale(10));
        make.right.mas_equalTo(-WScale(5));
    }];
    self.numTip = numTip;
    
    
    //联系人
    UILabel *nameTitle = [UILabel labelWithText:@"联系人" font:kFont(15) textColor:UIColorFromRGB(0x333333) backGroundColor:ClearColor superView:bgScrollView];
    [nameTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(WScale(15));
        make.top.mas_equalTo(textView.mas_bottom).mas_equalTo(WScale(25));
    }];
    
    UITextField *nameTF = [[UITextField alloc] initWithPlaceholder:@"请输入联系人姓名" showView:bgScrollView delegate:self showFont:[UIFont boldSystemFontOfSize:WScale(15)] showColor:UIColorFromRGB(0x333333) placeholderColor:UIColorFromRGB(0xB4B4B4)];
    nameTF.tag = 1;
    nameTF.textAlignment = NSTextAlignmentRight;
    [nameTF addTarget:self action:@selector(textFieldChangeAction:)   forControlEvents:UIControlEventEditingChanged];
    [nameTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(WScale(44));
        make.centerY.mas_equalTo(nameTitle);
        make.right.mas_equalTo(self.view.mas_right).mas_equalTo(WScale(-15));
    }];
    
    
    //联系手机
    UILabel *phoneTitle = [UILabel labelWithText:@"联系手机" font:kFont(15) textColor:UIColorFromRGB(0x333333) backGroundColor:ClearColor superView:bgScrollView];
    [phoneTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(WScale(15));
        make.top.mas_equalTo(nameTitle.mas_bottom).mas_equalTo(WScale(25));
    }];
    
    UITextField *phoneTF = [[UITextField alloc] initWithPlaceholder:@"请输入联系人手机" showView:bgScrollView delegate:self showFont:[UIFont boldSystemFontOfSize:WScale(15)] showColor:UIColorFromRGB(0x333333) placeholderColor:UIColorFromRGB(0xB4B4B4)];
    phoneTF.tag = 2;
    phoneTF.keyboardType = UIKeyboardTypeNumberPad;
    phoneTF.textAlignment = NSTextAlignmentRight;
    [phoneTF addTarget:self action:@selector(textFieldChangeAction:)   forControlEvents:UIControlEventEditingChanged];
    [phoneTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(WScale(44));
        make.centerY.mas_equalTo(phoneTitle);
        make.right.mas_equalTo(self.view.mas_right).mas_equalTo(WScale(-15));
    }];
    
    
    //期望服务时间
    UIButton *timeBtn = [UIButton buttonWithTitle:@"期望服务时间" font:kFont(15) titleColor:UIColorFromRGB(0x333333) backGroundColor:ClearColor buttonTag:0 target:self action:@selector(typeBtnClick) showView:bgScrollView];
    [timeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.view);
        make.left.mas_equalTo(WScale(15));
        make.top.mas_equalTo(phoneTF.mas_bottom).mas_equalTo(WScale(25));
        make.height.mas_equalTo(WScale(20));
    }];
    timeBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    
    UIImageView *arrowImg3 = [[UIImageView alloc] init];
    arrowImg3.image = [UIImage imageNamed:@"public_arrow_right"];
    [timeBtn addSubview:arrowImg3];
    [arrowImg3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(0);
        make.centerY.mas_equalTo(timeBtn);
    }];
    
    
    //提示
    UILabel *publicTipLabel = [UILabel labelWithText:@"*该服务模块只限消费方，资源拥有方请在资源社区分享推广即可" font:kFont(12) textColor:UIColorFromRGB(0x999999) backGroundColor:ClearColor superView:bgScrollView];
    [publicTipLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(WScale(15));
        make.centerX.mas_equalTo(self.view);
        make.top.mas_equalTo(timeBtn.mas_bottom).mas_equalTo(WScale(25));
    }];
    
    
    //发布
    UIButton *publicBtn = [UIButton buttonWithTitle:@"发布需求" font:kFont(15) titleColor:WhiteColor backGroundColor:ThemeColor buttonTag:0 target:self action:@selector(publicBtnClick) showView:bgScrollView];
    publicBtn.layer.cornerRadius = 4;
    publicBtn.clipsToBounds = YES;
    [publicBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.view);
        make.left.mas_equalTo(WScale(15));
        make.height.mas_equalTo(WScale(40));
        make.top.mas_equalTo(publicTipLabel.mas_bottom).mas_equalTo(WScale(20));
        make.bottom.mas_equalTo(-WScale(15));
    }];
}


#pragma mark 导航栏
-(void)setNavView
{
    UILabel *titleLabel = [UILabel labelWithText:@"发布需求" font:[UIFont boldSystemFontOfSize:WScale(17)] textColor:BlackColor backGroundColor:ClearColor superView:self.view];
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

- (void)hiddenKeyboard
{
    [self.view endEditing:YES];
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
     [self.view endEditing:YES];
}
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
    if (height >WScale(70)) {
        [self.inputTextView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(height);
        }];
    }
    else
    {
        [self.inputTextView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(WScale(70));
        }];
    }
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
    [self.upLoadBtn setImage:image forState:UIControlStateNormal];
    
    [picker dismissViewControllerAnimated:YES completion:nil];
}
#pragma mark ******* 从相册获取照片
-(void)takePhotoFromAlbum
{
    TZImagePickerController *imagePickerVc = [[TZImagePickerController alloc] initWithMaxImagesCount:1 delegate:self];
    imagePickerVc.allowTakePicture = NO;
    imagePickerVc.allowPickingOriginalPhoto = YES;
    imagePickerVc.allowTakeVideo = NO;
    imagePickerVc.allowPickingVideo = NO;
    
    MJWeakSelf;
    [imagePickerVc setDidFinishPickingPhotosHandle:^(NSArray<UIImage *> *photos, NSArray *assets, BOOL isSelectOriginalPhoto) {
        
        UIImage *image = photos[0];
        [weakSelf.upLoadBtn setImage:image forState:UIControlStateNormal];
    }];
    imagePickerVc.modalPresentationStyle = UIModalPresentationFullScreen;
    [self presentViewController:imagePickerVc animated:YES completion:nil];
}

#pragma mark 发布提示
-(SHFeePopView *)feeView
{
    if (!_feeView) {
        _feeView = [[SHFeePopView alloc] init];
        _feeView.title = @"提示";
        _feeView.contentLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _feeView;
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self.navigationController setNavigationBarHidden:NO];
}


@end
