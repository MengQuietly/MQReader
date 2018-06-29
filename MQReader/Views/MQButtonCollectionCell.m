//
//  MQButtonCollectionCell.m
//  MQReader
//
//  Created by mengJing on 2018/5/8.
//  Copyright © 2018年 Meng. All rights reserved.
//

#import "MQButtonCollectionCell.h"
#import "MQFindBookModel.h"

@interface MQButtonCollectionCell()

//@property (nonatomic, strong) UIButton *chooseBtn;
@property (nonatomic, strong) UILabel *nameLabel;

@end

@implementation MQButtonCollectionCell

-(instancetype)initWithCoder:(NSCoder *)aDecoder{
    if (self == [super initWithCoder:aDecoder]) {
        [self setUpViews];
    }
    return self;
}

-(instancetype)initWithFrame:(CGRect)frame {
    if (self == [super initWithFrame:frame]) {
        [self setUpViews];
    }
    return self;
}

-(void) setUpViews{
    self.nameLabel.frame = self.bounds;
    [self addSubview:self.nameLabel];
}

-(void)setHasBeenSelected:(BOOL)hasBeenSelected {
    
    _hasBeenSelected = hasBeenSelected;
    if (_hasBeenSelected) {
//        _nameLabel.backgroundColor = RGBNormal;
        _nameLabel.textColor = RGBSelect;
    } else{
//        _nameLabel.backgroundColor = RGBGray;
        _nameLabel.textColor = RGBNormal;
    }
}

-(void)setFindBookModel:(MQFindBookModel *)findBookModel {
    _findBookModel = findBookModel;
    _nameLabel.text = findBookModel.shortTitle;
}

-(UILabel *)nameLabel{
    if (_nameLabel == nil) {
        _nameLabel = [[UILabel alloc] init];
        _nameLabel.textColor = RGBNormal;
        _nameLabel.font = [UIFont systemFontOfSize:13.0];
        _nameLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _nameLabel;
    
}

//-(UIButton *)chooseBtn{
//    if (_chooseBtn == nil) {
//        _chooseBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//
//        _chooseBtn.titleLabel.font = [UIFont systemFontOfSize:13.0];
//        _chooseBtn.titleLabel.lineBreakMode = NSLineBreakByTruncatingTail;
//        [_chooseBtn setTitleColor:RGBSelect forState:UIControlStateSelected];
//        [_chooseBtn setTitleColor:RGBNormal forState:UIControlStateNormal];
//        [_chooseBtn setTitle:findBookModel.shortTitle forState:UIControlStateSelected];
//
////        [_chooseBtn addTarget:self action:@selector(chooseBtnClick:) forControlEvents:UIControlEventTouchUpInside];
//    }
//    return _chooseBtn;
//}


@end
