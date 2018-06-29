//
//  MQBookSelfWithTitleView.m
//  MQReader
//
//  Created by Meng on 2018/4/27.
//  Copyright © 2018年 Meng. All rights reserved.
//

#import "MQBookSelfWithTitleView.h"

@interface MQBookSelfWithTitleView ()

@property (nonatomic) UILabel *titleLab;
@property (nonatomic) UIButton *searchBtn;
@property (nonatomic) UIButton *addBtn;

@end

@implementation MQBookSelfWithTitleView

-(instancetype)initWithCoder:(NSCoder *)aDecoder{
    if (self == [super initWithCoder:aDecoder]) {
        [self setUpViews];
        NSLog(@"---%s",__func__);
    }
    return self;
}

-(instancetype)initWithFrame:(CGRect)frame {
    if (self == [super initWithFrame:frame]) {
        [self setUpViews];
        NSLog(@"---%s",__func__);
    }
    return self;
}

-(void) setUpViews{
    
    [self addSubview:self.titleLab];
    [self addSubview:self.searchBtn];
    [self addSubview:self.addBtn];
    
//    self.addBtn.size = CGSizeMake(44, 44);
//    self.searchBtn.size = self.addBtn.size;
    self.titleLab.origin = CGPointMake(10, 0);
    self.titleLab.text = @"掌阅";
    
    self.addBtn.y = 0;
    self.addBtn.width = 44;
    self.searchBtn.y = 0;
    self.searchBtn.width = 44;
    
}

-(void)layoutSubviews {
    
    [super layoutSubviews];
    
    if ((self.addBtn.x == 0) && (self.searchBtn.x == 0)) {
//        self.addBtn.bottom = self.frame.size.height - 8;
        self.addBtn.right = self.frame.size.width - 10;
//        self.searchBtn.bottom = self.addBtn.bottom;
        self.searchBtn.right = self.addBtn.left;

        self.searchBtn.height = self.frame.size.height;
        self.addBtn.height = self.frame.size.height;
        self.titleLab.height = self.frame.size.height;
        self.titleLab.width = self.searchBtn.left - self.titleLab.x;
        NSLog(@"------计算书架的 titleViewFrame = %s",__func__);
    }
}

#pragma mark - lazy
-(UILabel *)titleLab {
    if (_titleLab == nil) {
        _titleLab = [[UILabel alloc] init];
        _titleLab.font = [UIFont fontWithName:@"AmericanTypewriter-Bold" size:40];
    }
    return _titleLab;
    
}

-(UIButton *)searchBtn {
    if (_searchBtn == nil) {
        _searchBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_searchBtn setImage:[UIImage imageNamed:@"search_normal"] forState:UIControlStateNormal];
        _searchBtn.adjustsImageWhenHighlighted = NO;
        _searchBtn.tag = 1000;
        [_searchBtn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _searchBtn;
    
}

-(UIButton *)addBtn {
    if (_addBtn == nil) {
        _addBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_addBtn setImage:[UIImage imageNamed:@"add_normal"] forState:UIControlStateNormal];
        _addBtn.adjustsImageWhenHighlighted = NO;
        _addBtn.tag = 1001;
        [_addBtn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _addBtn;
    
}

-(void) btnClick:(UIButton *) btn {
    
    if ((self.bookSelfWithTitleViewDelegate) && ([self.bookSelfWithTitleViewDelegate respondsToSelector:@selector(didTouchBtnWithIndex:)])) {
        
        [self.bookSelfWithTitleViewDelegate didTouchBtnWithIndex:btn.tag];
    }
    
}

@end
