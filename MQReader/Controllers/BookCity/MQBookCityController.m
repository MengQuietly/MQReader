//
//  MQBookCityController.m
//  MQReader
//
//  Created by Meng on 2018/4/27.
//  Copyright © 2018年 Meng. All rights reserved.
//

#import "MQBookCityController.h"
#import "MQRankingController.h"
#import "MQCategoryController.h"

@interface MQBookCityController ()

@end

@implementation MQBookCityController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"书城";
    
    self.view.backgroundColor = RGBRandom;
    
    [self setUpViews];
    
}

-(void) setUpViews {
    
    UIButton *rankBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    rankBtn.tag = 111;
    rankBtn.frame = CGRectMake(0, 0, 35, 40);
    [rankBtn setImage:[UIImage imageNamed:@"rank_normal6"] forState:UIControlStateNormal];
    rankBtn.adjustsImageWhenHighlighted = NO;
    [rankBtn setContentHorizontalAlignment:UIControlContentHorizontalAlignmentLeft];
    CGSize imgS = rankBtn.imageView.frame.size;
    rankBtn.imageEdgeInsets = UIEdgeInsetsMake(0, rankBtn.width-imgS.width, 0, 0);
    [rankBtn addTarget:self action:@selector(bookCityWithNavItemClick:) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *categoryBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    categoryBtn.tag = 112;
    categoryBtn.frame = CGRectMake(0, 0, 35, 40);
    [categoryBtn setImage:[UIImage imageNamed:@"category_normal"] forState:UIControlStateNormal];
    categoryBtn.adjustsImageWhenHighlighted = NO;
    [categoryBtn setContentHorizontalAlignment:UIControlContentHorizontalAlignmentLeft];
    CGSize imgS2 = categoryBtn.imageView.frame.size;
    categoryBtn.imageEdgeInsets = UIEdgeInsetsMake(0, categoryBtn.width-imgS2.width, 0, 0);
    [categoryBtn addTarget:self action:@selector(bookCityWithNavItemClick:) forControlEvents:UIControlEventTouchUpInside];
    
    self.navigationItem.rightBarButtonItems = @[[[UIBarButtonItem alloc] initWithCustomView:rankBtn], [[UIBarButtonItem alloc] initWithCustomView:categoryBtn]];
}

-(void) bookCityWithNavItemClick:(UIButton *) btn {
    self.hidesBottomBarWhenPushed = YES;
    if (btn.tag == 111) {
        MQRankingController *rankingVC = [[MQRankingController alloc] init];
        [self.navigationController pushViewController:rankingVC animated:YES];
    } else {
        MQCategoryController *categoryVC = [[MQCategoryController alloc] init];
        [self.navigationController pushViewController:categoryVC animated:YES];
    }
    
    self.hidesBottomBarWhenPushed = NO;
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
    
}

@end
