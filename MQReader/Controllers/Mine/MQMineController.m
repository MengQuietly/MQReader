//
//  MQMineController.m
//  MQReader
//
//  Created by Meng on 2018/4/27.
//  Copyright © 2018年 Meng. All rights reserved.
//

#import "MQMineController.h"

@interface MQMineController ()

@end

@implementation MQMineController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"我的";
    
    self.view.backgroundColor = RGBRandom;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
