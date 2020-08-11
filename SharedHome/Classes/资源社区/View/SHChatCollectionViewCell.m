//
//  SHChatCollectionViewCell.m
//  SharedHome
//
//  Created by 解辉 on 2020/8/2.
//  Copyright © 2020 NaDao. All rights reserved.
//

#import "SHChatCollectionViewCell.h"

@implementation SHChatCollectionViewCell

- (UIImageView *)cellImgView
{
    if (!_cellImgView) {
        _cellImgView = [[UIImageView alloc] init];
        _cellImgView.contentMode = UIViewContentModeScaleAspectFill;
        _cellImgView.clipsToBounds = YES;
        _cellImgView.layer.masksToBounds = YES;
        [self addSubview:_cellImgView];
        [_cellImgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(0);
        }];
    }
    return _cellImgView;
}
@end
