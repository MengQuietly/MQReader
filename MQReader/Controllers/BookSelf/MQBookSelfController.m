//
//  MQBookSelfController.m
//  MQReader
//
//  Created by Meng on 2018/4/27.
//  Copyright © 2018年 Meng. All rights reserved.
//

#import "MQBookSelfController.h"
#import "MQBookSelfWithTitleView.h"
#import "MQSearchOnLineController.h"

@interface MQBookSelfController ()<MQBookSelfWithTitleViewDelegate>

@property (nonnull) MQBookSelfWithTitleView *titleViews;

@property (nonnull) MQSearchOnLineController *searchOnLineVC;

@end

@implementation MQBookSelfController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"书架";
    [self setUpViews];
    
    self.view.backgroundColor = RGBRandom;
    
}

-(void) setUpViews {
    
    self.titleViews = [[MQBookSelfWithTitleView alloc] init];
    self.titleViews.frame = CGRectMake(0, 0, SCREEN_WIDTH, 70);
    self.titleViews.bookSelfWithTitleViewDelegate = self;
    [self.view addSubview:self.titleViews];
    
    self.titleViews.backgroundColor = RGBRandom;
    
}

#pragma mark - MQBookSelfWithTitleViewDelegate
-(void)didTouchBtnWithIndex:(NSInteger)index{
    
    if (index == 1000) {
        
        NSLog(@"search");
        
        self.searchOnLineVC = [[MQSearchOnLineController alloc] init];
        UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:self.searchOnLineVC];
        [self presentViewController:nav animated:YES completion:NULL];
        
    }else if (index == 1001) {
        NSLog(@"add");
        
    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
