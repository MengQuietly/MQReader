//
//  MQBooksListCell.m
//  MQReader
//
//  Created by mengJing on 2018/5/9.
//  Copyright © 2018年 Meng. All rights reserved.
//

#import "MQBooksListCell.h"
#import "MQFindBookModel.h"

@interface MQBooksListCell()

@property (nonatomic, strong) UILabel *nameLabel;

@end

@implementation MQBooksListCell

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
    self.backgroundColor = RGBRandom;
}

-(void)setFindBookModel:(MQFindBookModel *)findBookModel {
    _findBookModel = findBookModel;
    _nameLabel.text = findBookModel.title;
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



- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
