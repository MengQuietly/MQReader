//
//  MQBookCityController.m
//  MQReader
//
//  Created by Meng on 2018/4/27.
//  Copyright © 2018年 Meng. All rights reserved.
//

#import "MQBookCityController.h"
#import "MQRankingController.h"

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
    rankBtn.frame = CGRectMake(0, 0, 40, 40);
    [rankBtn setImage:[UIImage imageNamed:@"rank_normal2"] forState:UIControlStateNormal];
    rankBtn.adjustsImageWhenHighlighted = NO;
    [rankBtn setContentHorizontalAlignment:UIControlContentHorizontalAlignmentLeft];
    CGSize imgS = rankBtn.imageView.frame.size;
    rankBtn.imageEdgeInsets = UIEdgeInsetsMake(0, rankBtn.width-imgS.width, 0, 0);

    [rankBtn addTarget:self action:@selector(rankBtnClick) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:rankBtn];
    
}

-(void) rankBtnClick {
    self.hidesBottomBarWhenPushed = YES;
    MQRankingController *rankingVC = [[MQRankingController alloc] init];
    [self.navigationController pushViewController:rankingVC animated:YES];
    self.hidesBottomBarWhenPushed = NO;
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
    
}

@end
