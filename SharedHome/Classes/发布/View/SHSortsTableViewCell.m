//
//  SHSortsTableViewCell.m
//  SharedHome
//
//  Created by 解辉 on 2020/8/5.
//  Copyright © 2020 NaDao. All rights reserved.
//

#import "SHSortsTableViewCell.h"

@implementation SHSortsTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

-(UILabel *)titleLabel
{
    if (!_titleLabel) {
        _titleLabel = [UILabel labelWithText:@"" font:kFont(15) textColor:UIColorFromRGB(0x333333) backGroundColor:ClearColor superView:self];
        [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(WScale(15));
            make.centerY.mas_equalTo(self);
        }];
    }
    return _titleLabel;
}

-(UIImageView *)selectImgView
{
    if (!_selectImgView) {
        _selectImgView = [[UIImageView alloc] init];
        _selectImgView.image = [UIImage imageNamed:@"post_sort_select"];
        [self addSubview:_selectImgView];
        [_selectImgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(self);
            make.right.mas_equalTo(WScale(-15));
        }];
    }
    return _selectImgView;
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
